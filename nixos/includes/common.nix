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
    jq
    ncdu
    nmap
    rclone
    silver-searcher
    tcpdump
    tmux
    vim
    wget
  ];
  # Stop waiting for services to properly stop.
  systemd.extraConfig  = ''
    DefaultTimeoutStopSec=30s
  '';
}
