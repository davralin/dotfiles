{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cryptsetup
    dmidecode
    usbutils
  ];

  # If we are physical, we assume a need for fwupd
  services.fwupd.enable = true;

}
