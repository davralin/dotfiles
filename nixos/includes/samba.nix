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
    '';
    #shares = {
    #  test = {
    #    path = "/opt/backup/";
    #    browseable = "yes";
    #    "read only" = "no";
    #    "guest ok" = "yes";
    #    "force user" = "backup";
    #    "force group" = "backup";
    #  };
    #};
  };
}