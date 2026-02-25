{
  description = "Reusable NixOS modules for servers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }: {
    serverModules = {
      # use default to import all
      default = import ./modules;
      
      # or import each module individually
      docker = import ./modules/docker.nix;
      prometheus-exporters = import ./modules/prometheus-exporters.nix;
      common = import ./modules/common.nix;
      beszel = import ./modules/beszel-agent.nix
    };
  };
}
