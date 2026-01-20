{ config, lib, pkgs, ...}:

{
  services.beszel.agent = {
    enable = true;
    openFirewall = true;
  };
};
