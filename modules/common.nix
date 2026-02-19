{ config, lib, pkgs, ... }:

{
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  

  # Default user account
  users.users.nix-core = {
    isNormalUser = true;
    description = "A base user account";
    initialPassword = "password"
    extraGroups = [ "docker" ];
  };

  # Enable SSH
  services.openssh.enable = true;

  # Include some basic packages
  environment.systemPackages = with pkgs; [
    git
  ];    
}
