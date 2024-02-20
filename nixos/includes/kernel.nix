{ config, pkgs, ... }:

{
  # Get newest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
