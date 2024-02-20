{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    powertop
    usbutils
  ];

  # If we are physical, we assume a need for fwupd
  services.fwupd.enable = true;

}
