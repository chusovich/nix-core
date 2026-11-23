# nix-core
core nix modules for all my servers

## Modules Include
- 📈 `beszel-agent`: monitoring agent, runs as a docker container with secrets via agenix
- 🕝 `common`: ssh, some common packages, admin user, ...
- 🐳 `docker`: everything is a container these days
- 🌐 `tailscale`: mesh network of choice
- 🤖 `ai`: OpenCode, since bots know best
- 🔥 `promethues-exporters`: all the stats

## Example Flake
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-core = {
      url = "github:chusovich/nix-core/v2026.11.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-core, ... }: {
    nixosConfigurations.MYHOST = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        nix-core.serverModules.default
        ./configuration.nix
      ];
    };
  };
}
```

## Secrets (agenix)

Secrets are encrypted with [agenix](https://github.com/ryantm/agenix) and stored in `secrets/`. The rules file `agenix-rules.nix` lists each secret and the age public keys allowed to decrypt it:

```nix
"secrets/beszel-env.age".publicKeys = [ personal beszelServer ];
```

- `personal` is your age public key, used to edit secrets from your workstation.
- `beszelServer` is the public key of the host that decrypts the secret at boot. It must match the private key at the identity path in `modules/beszel-agent.nix` (`/var/lib/agenix/beszel-server.key`).

### Set up a new host

1. Put the host's age private key at the identity path, e.g. `/var/lib/agenix/beszel-server.key`, with root-only permissions.
2. Get its public key:
   ```sh
   age-keygen -y /var/lib/agenix/beszel-server.key
   ```
3. Add a `let` binding for it in `agenix-rules.nix` and add it to the `publicKeys` of every secret that host needs.
4. Re-encrypt existing secrets so the new host can read them (see "Rotate keys" below).

### Create or edit a secret

Run from the repo root with your personal key available:

```sh
RULES=./agenix-rules.nix agenix -e secrets/beszel-env.age -i ~/.ssh/id_ed25519
```

The file opens in `$EDITOR` as plain text. Use `KEY=VALUE` lines for the environment file. Save and quit to re-encrypt.

To add a new secret, add an entry to `agenix-rules.nix` first, then run the same command with the new filename.

### Rotate keys

After changing any `publicKeys` list, re-encrypt existing secrets so the new recipients can read them:

```sh
RULES=./agenix-rules.nix agenix -r -i ~/.ssh/id_ed25519
```

### Use a secret in a module

Declare it in the module that uses it, and give ownership to the user that runs the service:

```nix
age.secrets.beszel-env = {
  file = ../secrets/beszel-env.age;
  owner = "root";
  group = "users";
  mode = "0400";
};
```

The decrypted file is available at `config.age.secrets.beszel-env.path` (under `/run/agenix/`).
