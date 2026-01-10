{ config, lib, pkgs, ... }:

{
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  

  # Include some basic packages
  environment.systemPackages = with pkgs; [
    just
  ];    
}
