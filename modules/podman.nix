{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.backend = "podman";

  virtualisation.podman = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
}
