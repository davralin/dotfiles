{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    btop
    git
    glances
    ncdu
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
