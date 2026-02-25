{ config, lib, pkgs, ... }:

{
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  

  # Enable SSH
  services.openssh.enable = true;

  # Include some basic packages
  environment.systemPackages = with pkgs; [
    git
  ];    
}
