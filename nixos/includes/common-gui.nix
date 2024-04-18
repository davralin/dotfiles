{ config, pkgs, ... }:

{
  # Enable networking
  networking.networkmanager.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    autorandr
    firefox
    keepassxc
    gparted
    guake
  ];

}
