{ config, pkgs, ... }:

{
  # Automatic host-maintenance.
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
}
