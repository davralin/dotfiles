{ config, pkgs, ... }:

{
  # Add zfs-support
  boot.supportedFilesystems = [ "zfs" ];
  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;
}
