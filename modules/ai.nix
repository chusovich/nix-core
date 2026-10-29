{ config, lib, pkgs, ... }:

{
  # Opencode and a nix mcp server
  environment.systemPackages = with pkgs; [
    opencode
    mcp-nixos
  ];    
}
