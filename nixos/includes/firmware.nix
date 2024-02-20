{ config, pkgs, ... }:

{
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = false;
}
