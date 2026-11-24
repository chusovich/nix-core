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

## Secrets (host-local files)

The Tailscale and Beszel modules read secret files directly from each server. Their contents are not stored in this repository or embedded in the Nix store:

| Path | Contents |
| --- | --- |
| `/var/lib/secrets/tailscale_auth_key` | Tailscale auth key as one plain line, without a `KEY=` prefix |
| `/var/lib/secrets/beszel-env` | Beszel agent variables in `NAME=value` format, one per line |

### Set up a server

Create the directory on the server with root-only access:

```sh
sudo install -d -o root -g root -m 0700 /var/lib/secrets
```

Create empty, root-only files, then edit them with `sudoedit` so their contents are not passed as shell arguments:

```sh
sudo install -o root -g root -m 0400 /dev/null /var/lib/secrets/tailscale_auth_key
sudo install -o root -g root -m 0400 /dev/null /var/lib/secrets/beszel-env
sudoedit /var/lib/secrets/tailscale_auth_key
sudoedit /var/lib/secrets/beszel-env
```

Put only the auth key in `tailscale_auth_key`. Put the environment variables expected by your Beszel agent in `beszel-env`; use `NAME=value` lines and do not add `export`.

Set ownership and permissions, then verify them:

```sh
sudo chown root:root /var/lib/secrets/tailscale_auth_key /var/lib/secrets/beszel-env
sudo chmod 0400 /var/lib/secrets/tailscale_auth_key /var/lib/secrets/beszel-env
sudo stat -c '%U:%G %a %n' /var/lib/secrets /var/lib/secrets/*
```

The directory should be `root:root` mode `700`; each file should be `root:root` mode `400`. Create the files before activating the NixOS configuration. Keep backups outside the Nix store and repository. Anyone with root access to the server can read these files.

### Deploy files over SSH

Keep local source files outside the repository and deploy each one individually:

```sh
./scripts/deploy-secret myserver tailscale_auth_key /secure/path/tailscale_auth_key
./scripts/deploy-secret myserver beszel-env /secure/path/beszel-env
```

The script streams the file over SSH without displaying its contents, then installs it as root-owned mode `0400` under `/var/lib/secrets`. The SSH account must have non-interactive `sudo -n` access. Never commit the local source files.

The old `secrets/beszel-env.age` and `agenix-rules.nix` are retained as a legacy encrypted backup; the modules no longer use agenix. The Tailscale auth key previously pasted into chat must be revoked and replaced before use.
