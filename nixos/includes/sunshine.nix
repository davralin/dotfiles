{ config, pkgs, ... }:

{
  # Enable sunshine
  services.sunshine = {
    enable = true;
    openFirewall = true;
  };
}