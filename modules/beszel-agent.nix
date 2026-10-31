{ config, lib, pkgs, ... }:

{
  # Beszel monitoring agent
  services.beszel.agent = {
    enable = true;
    environment = {
      LISTEN = "45876";
      KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE/5J1jgxg8L7bkiFuGv+Y8doBXrAaqW3npi1Sm+9mTw";
      HUB_URL = "https://beszel.services.husovich.com";
      TOKEN = "d0a2dbe3-0463-4e0f-abc6-7ff1208b46e8";
     };
  };
}
