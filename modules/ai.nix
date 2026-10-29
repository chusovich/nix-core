{ config, lib, pkgs, ... }:

{
  # Opencode and a Nix MCP server
  environment.systemPackages = with pkgs; [
    opencode
    mcp-nixos
  ];    
}
