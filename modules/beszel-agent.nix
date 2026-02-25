{ config, lib, pkgs, ... }:

{
  services.beszel.agent = {
    enable = true;
    smartmon.enable = true; # Include services.beszel.agent.smartmon.package in the Beszel agent path for disk monitoring and add the agent to the disk group.
    environment = {
      KEY = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPOyZhLeHQsiKAg4X9ztRIE+YOEVm1R3S/pwyprPJVU;
    };
  };
}
