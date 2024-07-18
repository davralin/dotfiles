{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../includes/ansible.nix
      ../includes/auto-update.nix
      ../includes/backup-k8s.nix
      ../includes/common.nix
      ../includes/docker.nix
      ../includes/docker-adguard.nix
      ../includes/docker-immich.nix
      ../includes/docker-zigbee2mqtt.nix
      ../includes/garbage-collect.nix
      ../includes/impermanence-root.nix
      ../includes/locale.nix
      ../includes/mikr.nix
      ../includes/node-exporter.nix
      ../includes/openzfs.nix
      ../includes/physical.nix
      ../includes/rclone-backup.nix
      ../includes/rsnapshot.nix
      ../includes/ssh.nix
      ../includes/sudo.nix
      ../includes/unfree.nix
    ];

  # ZFS-config:
  # zpool create -O compression=on -O mountpoint=none -O xattr=sa -O acltype=posixacl -o ashift=12 home-nas /dev/disk/by-id/xxx /dev/disk/by-id/xxx
  # zfs set com.sun:auto-snapshot=true home-nas
  # zfs create -o mountpoint=legacy home-nas/local

  # Add mdadm-support for /nix
  boot.swraid = {
    enable = true;
    mdadmConf =
      "ARRAY /dev/md0 level=raid1 num-devices=2 metadata=1.2 name=nixos:0 UUID=6ae89e1b:881758ed:3abb2a8b:d3da1b16 devices=/dev/sda1,/dev/sdb1";
  };

  # Bootloader.
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "home-nas";
    hostId = "3f784dab"; # for OpenZFS
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
