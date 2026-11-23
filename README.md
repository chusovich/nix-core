# nix-core
core nix modules for all my servers

## Modules Include
- ⚠️ `beszel-agent`: what's going on
- 🕝 `common`: base user, ssh, some common packages, ...
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
      url = "github:chusovich/nix-core/v2026.10.2";
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
