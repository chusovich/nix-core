# nix-core
core nix modules for all my servers

## Modules Include
- 🔥 Promethues Exporter: all the stats
- 🐳 Docker: everything is a container these days
- 🕝 Common server setup: base user, ssh, some common packages, ...

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
