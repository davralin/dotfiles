{ config, pkgs, ... }:

{
  # Add ollama-stuff
  services.ollama.acceleration = "rocm";
  services.ollama.enable = true;

}
