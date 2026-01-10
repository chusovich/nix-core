# nix-core
core nix modules for all my servers

## Modules Include
- 🔥 Promethues Exporter: all the stats
- 🐳 Docker: everything is a container these days
- 📈 Beszel Agent: more stats
- 🕝 Common server setup: ssh, some common packages, ...

## Example Usuage
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-core = {
      url = "github:chusovich/nix-core";
      inputs.nixpkgs.follows = nixpkgs;
    }
  };

  outputs = { self, nixpkgs, nix-core, ... }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        nix-core.serverModules.default
        # or pick individual ones:
        # nix-core.serverModules.beszel
      ];
    };
  };
}
```
