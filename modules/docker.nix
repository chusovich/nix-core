{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.backend = "docker";

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
}
