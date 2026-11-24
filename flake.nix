{
  description = "Reusable NixOS modules for servers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosModules = {
      # Import all modules in /modules/default.nix
      default = {
        imports = [ ./modules ];
      };

      # Import individual modules
      docker = import ./modules/docker.nix;
      prometheus-exporters = import ./modules/prometheus-exporters.nix;
      common = import ./modules/common.nix;
      ai = import ./modules/ai.nix;
      tailscale = import ./modules/tailscale.nix;
      beszel-agent = import ./modules/beszel-agent.nix;
    };
  };
}
