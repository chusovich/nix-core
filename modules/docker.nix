{ config, lib, pkgs, ... }:

{
  options.coreModules.docker.enable = lib.mkEnableOption "Docker support";

  config = lib.mkIf config.myModules.docker.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };
}
