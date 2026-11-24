{ ... }:

{
  imports = [
    ./docker.nix
  ];

  # Beszel monitoring agent
  virtualisation.oci-containers.containers.beszel-agent = {
    image = "henrygd/beszel-agent:0.21.2";
    extraOptions = [ "--network=host" ];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    environment = {
      LISTEN = "45876";
      HUB_URL = "https://beszel.services.husovich.com";
      DISABLE_SSH = "true";
      DATA_DIR = "/var/lib/beszel-agent";
      SKIP_GPU = "true";
      SKIP_WIFI = "true";
      TOKEN_FILE = "/var/lib/secrets/beszel_token";
    };
  };
}
