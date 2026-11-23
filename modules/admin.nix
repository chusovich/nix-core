{ config, lib, pkgs, ... }:

{
  users.users.admin = {
    description = "Server admin user";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "password";
    linger = true;
    autoSubUidGidRange = true;
  };
}
