{ config, lib, pkgs, ... }:

{
  imports = [ ./podman.nix ];

  # Beszel monitoring agent
  age.identityPaths = [ "/var/lib/agenix/beszel-server.key" ];
  age.secrets.beszel-env = {
    file = ../secrets/beszel-env.age;
    owner = "beszel-agent-container";
    group = "beszel-agent-container";
    mode = "0400";
  };

  virtualisation.oci-containers.containers.beszel-agent = {
    image = "docker.io/henrygd/beszel-agent:0.21.2";
    pull = "newer";
    podman.user = "beszel-agent-container";
    extraOptions = [ "--network=host" ];
    environment = {
      LISTEN = "45876";
      KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE/5J1jgxg8L7bkiFuGv+Y8doBXrAaqW3npi1Sm+9mTw";
      HUB_URL = "https://beszel.services.husovich.com";
    };
    environmentFiles = [ config.age.secrets.beszel-env.path ];
  };

  users.groups.beszel-agent-container = { };

  users.users.beszel-agent-container = {
    group = "container-admin";
    isSystemUser = true;
    linger = true;
    home = "/var/lib/beszel-agent-container";
    createHome = true;
    autoSubUidGidRange = true;
  };
}
