{ config, lib, pkgs, ... }:

{
  imports = [
    ./docker.nix
  ];

  # Beszel monitoring agent
  age.identityPaths = [ "/var/lib/agenix/beszel-server.key" ];
  age.secrets.beszel-env = {
    file = ../secrets/beszel-env.age;
    owner = "root";
    group = "users";
    mode = "0400";
  };

  virtualisation.oci-containers.containers.beszel-agent = {
    image = "docker.io/henrygd/beszel-agent:0.21.2";
    extraOptions = [ "--network=host" ];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    environment = {
      LISTEN = "45876";
      HUB_URL = "https://beszel.services.husovich.com";
    };
    environmentFiles = [ config.age.secrets.beszel-env.path ];
  };
}
