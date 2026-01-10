{
  description = "Reusable NixOS modules for servers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    serverModules = {
      # use default to import all
      default = import ./modules;
      
      # or import each module individually
      docker = import ./modules/docker.nix;
      prometheus-exporters = import ./modules/prometheus-exporters.nix;
      beszel = import ./modules/beszel.nix;
    };
  };
}
