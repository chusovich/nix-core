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
      "/var/lib/secrets/beszel_token:/var/lib/secrets/beszel_token:ro"
    ];
    environment = {
      LISTEN = "45876";
      HUB_URL = "http://jason:8090";
      DISABLE_SSH = "true";
      DATA_DIR = "/var/lib/beszel-agent";
      SKIP_GPU = "true";
      SKIP_WIFI = "true";
      TOKEN_FILE = "/var/lib/secrets/beszel_token";
      KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBpOOYjkDYuZVd9/WMHlqt/pzf/9FfOuobGRbEw281aN";
    };
  };
}
