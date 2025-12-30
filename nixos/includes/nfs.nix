{ config, pkgs, ... }:

{
  # Add nfs, open firewall
  networking.firewall.enable = false;
  services = {
    nfs = {
      server = {
        enable = true;
        exports = ''
            /opt/local/nfs 10.0.1.0/24(rw,sync,no_subtree_check)
        '';
      };
    };
  };
}