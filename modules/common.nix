{ config, lib, pkgs, ... }:

{
  options.myModules.common.enable =
    lib.mkEnableOption "Common defaults";

  config = lib.mkIf config.myModules.common.enable {
    environment.systemPackages 
    
  };
}
