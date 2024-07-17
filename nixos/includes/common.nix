{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    btop
    cloud-utils # growpart
    dig
    fastfetch
    git
    glances
    iftop
    iotop
    ncdu
    nmap
    rclone
    silver-searcher
    tmux
    vim
    wget
  ];
  # Stop waiting for services to properly stop.
  systemd.extraConfig  = ''
    DefaultTimeoutStopSec=30s
  '';
}
