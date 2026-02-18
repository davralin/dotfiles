{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../includes/secrets/nullmailer.nix
      ../includes/ansible.nix
      ../includes/auto-update.nix
      ../includes/backup-k8s.nix
      ../includes/common.nix
      ../includes/docker.nix
      ../includes/docker-adguard.nix
      ../includes/docker-garage.nix
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
  # zpool create -O compression=on -O mountpoint=none -O xattr=sa -O acltype=posixacl -o ashift=12 home-nas mirror /dev/disk/by-id/xxx /dev/disk/by-id/xxx
  # zfs set com.sun:auto-snapshot=true home-nas
  # zfs create -o mountpoint=legacy home-nas/local
  # boot.kernelParams = [ "zfs.zfs_arc_max=1073741824" ];

  # Allow on all one interfaces
  services.prometheus.exporters.node.openFirewall = true;

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
  system.stateVersion = "25.11"; # Did you read the comment?

}
