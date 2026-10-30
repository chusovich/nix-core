{ config, lib, pkgs, ... }:

{
  # Beszel monitoring agent
  services.beszel.agent = {
    enable = true;
    environment = {
      LISTEN = "45876";
      KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE/5J1jgxg8L7bkiFuGv+Y8doBXrAaqW3npi1Sm+9mTw";
      HUB_URL = "https://beszel.services.husovich.com";
      TOKEN = "7e0d6f07-2536-4251-b253-db6ee05e3289";
     };
  };
}
