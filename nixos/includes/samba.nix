{ config, pkgs, ... }:

{
  # Add samba, open firewall
  # Config goes elsewhere
  services.samba = {
    enable = true;
    openFirewall = true;
    winbindd.enable = false;
    nmbd.enable = false;
  };
}