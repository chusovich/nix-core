{ config, lib, pkgs, ... }:

{
  # Tailscale Mesh VPN
  services.tailscale = {
    enable = true;
    # authKeyFile = "/home/calebh/secrets/tailscale_key";
    extraUpFlags = [
      "--reset"
      "--ssh"
      "--advertise-tags=tag:server"
    ];
  };
}
