{ lib, ... }:

{
  # Tailscale msh VPN
  services.tailscale = {
    enable = true;

    authKeyFile = lib.mkDefault "/var/lib/secrets/tailscale_auth_key";

    extraUpFlags = lib.mkDefault [
      "--reset"
      "--ssh"
      "--advertise-tags=tag:server"
    ];
  };
}
