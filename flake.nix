{
  description = "Reusable NixOS modules for servers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, agenix, ... }: {
    nixosModules = {
      # Import all modules
      default = {
        imports = [
          agenix.nixosModules.default
          ./modules
        ];
      };

      # Import individual modules
      docker = import ./modules/docker.nix;
      podman = import ./modules/podman.nix;
      prometheus-exporters = import ./modules/prometheus-exporters.nix;
      common = import ./modules/common.nix;
      ai = import ./modules/ai.nix;
      tailscale = import ./modules/tailscale.nix;
      beszel-agent = {
        imports = [
          agenix.nixosModules.default
          ./modules/beszel-agent.nix
        ];
      };
    };
  };
}
