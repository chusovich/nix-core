{ config, lib, pkgs, ... }:

{
  # Beszel monitoring agent
  services.beszel.agent = {
    enable = true;
    environment = {
      LISTEN = "45876";
      KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHMo4d4U9y7xxAzSmjUt2ce3Zh/3+bPL3IP1aM71up1";
      HUB_URL = "https://beszel.services.husovich.com";
      TOKEN = "f1abf1a6-efc8-4ff4-b14c-c9fc6bfaa153";
     };
  };
}
