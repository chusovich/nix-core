{ config, lib, pkgs, ... }:

{
  users.users.admin = {
    uid = 1111;
    description = "Server admin user";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "password";
    linger = true;
    autoSubUidGidRange = true;
  };
}
