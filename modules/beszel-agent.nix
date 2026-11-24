{ ... }:

{
  imports = [
    ./docker.nix
  ];

  # Beszel monitoring agent
  virtualisation.oci-containers.containers.beszel-agent = {
    image = "docker.io/henrygd/beszel-agent:0.21.2";
    extraOptions = [ "--network=host" ];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    environment = {
      LISTEN = "45876";
      HUB_URL = "https://beszel.services.husovich.com";
      KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE/5J1jgxg8L7bkiFuGv+Y8doBXrAaqW3npi1Sm+9mTw";
    };
    environmentFiles = [ "/var/lib/secrets/beszel-env" ];
  };
}
