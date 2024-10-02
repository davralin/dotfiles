{ config, pkgs, ... }:

{
  # Add samba, open firewall
  # Config goes elsewhere
  services.samba = {
    enable = true;
    openFirewall = true;
    enableWinbindd = false;
    enableNmbd = false;
    extraConfig = ''
      server min protocol = SMB3
      guest ok = yes
      guest account = backup
      map to guest = bad user
    '';
  };
}