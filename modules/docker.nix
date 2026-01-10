{ config, lib, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
}

#{ config, lib, pkgs, ... }:
#
#{
#  options.myModules.docker.enable = lib.mkEnableOption "Docker support";
#
#  config = lib.mkIf config.myModules.docker.enable {
#    virtualisation.docker = {
#      enable = true;
#      autoPrune.enable = true;
#    };
#
#    users.groups.docker = {};
#  };
#}
