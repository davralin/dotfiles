{ config, pkgs, ... }:

{
  # Add ollama-stuff
  services.ollama.enable = true;
  networking.firewall.allowedTCPPorts = [ 11434 ];
}
