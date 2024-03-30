{ config, pkgs, ... }:

{
  # Add bluetooth-support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;


  # If no support in DE, enable this
  # services.blueman.enable = true;
}
