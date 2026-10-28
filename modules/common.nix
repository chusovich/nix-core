{ config, lib, pkgs, ... }:

{
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  

  # Create admin user
  users.users.admin = {
    description = "Server admin user";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    initialPassword = "password";
  };
  
  # Enable SSH
  services.openssh.enable = true;

  # Include some basic packages
  environment.systemPackages = with pkgs; [
    git
    gh
    helix
    just
    opencode
    mcp-nixos
  ];    

  # Configure weekly garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    randomizedDelaySec = "45min";
    options = "--delete-older-than 30d";
  };

  # Keep a reasonable rollback window for system generations.
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;
  
  # Set default time zone
  time.timeZone = lib.mkDefault "America/New_York";
}
