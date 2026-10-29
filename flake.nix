{
  description = "Reusable NixOS modules for servers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosModules = {
      # Import all modules
      default = import ./modules;      

      # Import individual modules
      docker = import ./modules/docker.nix;
      prometheus-exporters = import ./modules/prometheus-exporters.nix;
      common = import ./modules/common.nix;
      ai = import ./modules/ai.nix;
    };
  };
}
