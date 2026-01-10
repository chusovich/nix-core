{ config, lib, pkgs, ... }:

{
  services.prometheus.exporters.node = {
    enable = true;
    port = 9100;
    enabledCollectors = [
      "logind"
      "systemd"
    ];
    disabledCollectors = [ "textfile" ];
    openFirewall = true;
    firewallFilter = "-i br0 -p tcp -m tcp --dport 9100";
  };
}

#{ config, lib, pkgs, ... }:
#
#let
#  cfg = config.myModules.prometheusExporters;
#in
#{
#  options.myModules.prometheusExporters = {
#    enable = lib.mkEnableOption "Prometheus exporters";
#
#    node = lib.mkEnableOption "Node exporter";
#  };
#
#  config = lib.mkIf cfg.enable {
#    services.prometheus.exporters = {
#      node = lib.mkIf cfg.node {
#        enable = true;
#        port = 9100;
#      };
#    };
#  };
#}
