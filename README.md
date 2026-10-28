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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-core = {
      url = "github:chusovich/nix-core/0.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nix-core, ... }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit nixpkgs-unstable; };

      modules = [
        nix-core.serverModules.default
        # or pick individual ones:
        # nix-core.serverModules.docker
      ];
    };
  };
}
```
