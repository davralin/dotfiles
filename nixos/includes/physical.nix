{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dmidecode
    usbutils
  ];

  # If we are physical, we assume a need for fwupd
  services.fwupd.enable = true;

}
