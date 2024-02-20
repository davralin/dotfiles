# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    powertop
    usbutils
  ];

  # If we are physical, we assume a need for fwupd
  services.fwupd.enable = true;

}
