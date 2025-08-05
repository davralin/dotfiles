{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cryptsetup
    dmidecode
    usbutils
  ];

  # If we are physical, we need more monitoring of physical things
  services.fwupd.enable = true;
  services.smartd.enable = true;

}
