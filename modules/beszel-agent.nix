{ config, lib, pkgs, ...}:

{
  services.beszel.agent = {
    enable = true;
    openFirewall = true;
    environmentFile = "/home/nix-core/beszel-agent.env"
  };
}
