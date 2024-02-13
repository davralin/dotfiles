# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.autoPrune.enable = true;
  virtualisation.docker.autoPrune.dates = "monthly";
  virtualisation.docker.extraPackages = with pkgs; [
    docker-compose
  ];
}