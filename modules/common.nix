{ config, lib, pkgs, nixpkgs-unstable, ... }:

let
  pkgsUnstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config = config.nixpkgs.config;
  };
in
{
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable SSH
  services.openssh.enable = true;

  # Include some basic packages
  environment.systemPackages = with pkgs; [
    git
    helix
    just
    pkgsUnstable.opencode
    pkgsUnstable.mcp-nixos
  ];
}
