{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    btop
    borgbackup
    cloud-utils # growpart
    dig
    fastfetch
    file
    git
    git-crypt
    git-lfs
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
