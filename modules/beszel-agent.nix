{ config, lib, pkgs, ... }:

{
  services.beszel.agent = {
    enable = true;
    smartmon.enable = true; # Include services.beszel.agent.smartmon.package in the Beszel agent path for disk monitoring and add the agent to the disk group.
    environment = {
      KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPW2VmL6jQHq/AaudZa5t1XeB1rdaVf8bsUG15IOSwa8";
    };
  };
}
