{
  description = "Reusable NixOS modules for servers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable }:
    {
      serverModules = {
        # use default to import all
        default = ./modules;

        # or import each module individually
        docker = ./modules/docker.nix;
        prometheus-exporters = ./modules/prometheus-exporters.nix;
        common = ./modules/common.nix;
      };
    };
}
