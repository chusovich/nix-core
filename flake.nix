{
  description = "Reusable NixOS modules for servers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    opencode = {
      url = "github:anomalyco/opencode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcp-nixos = {
      url = "github:utensils/mcp-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, opencode, mcp-nixos }:
    let
      extraOverlays = [
        opencode.overlays.default
        mcp-nixos.overlays.default
      ];
      withPkgs = path: {
        imports = [ path ];
        config.nixpkgs.overlays = extraOverlays;
      };
    in
    {
      serverModules = {
        # use default to import all
        default = withPkgs ./modules;

        # or import each module individually
        docker = import ./modules/docker.nix;
        prometheus-exporters = import ./modules/prometheus-exporters.nix;
        common = withPkgs ./modules/common.nix;
      };
    };
}
