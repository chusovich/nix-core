{ config, lib, pkgs, ... }:

{
  # Tailscale Mesh VPN
  services.tailscale = {
    enable = true;
    authKeyFile = lib.mkDefault "/var/lib/secrets/tailscale_auth_key";
    extraUpFlags = [
      "--reset"
      "--ssh"
      "--advertise-tags=tag:server"
    ];
  };
}
