{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../includes/secrets/away-nas.nix
      ../includes/secrets/nullmailer.nix
      ../includes/acme.nix
      ../includes/ansible.nix
      ../includes/auto-update.nix
      ../includes/backup-k8s.nix
      ../includes/common.nix
      ../includes/docker.nix
      ../includes/docker-adguard.nix
      ../includes/docker-immich.nix
      ../includes/garbage-collect.nix
      ../includes/haproxy.nix
      ../includes/impermanence-root.nix
      ../includes/locale.nix
      ../includes/mikr.nix
      ../includes/node-exporter.nix
      ../includes/openzfs.nix
      ../includes/physical.nix
      ../includes/rclone-backup.nix
      ../includes/rsnapshot.nix
      ../includes/samba.nix
      ../includes/ssh.nix
      ../includes/sudo.nix
      ../includes/tailscale.nix
      ../includes/unfree.nix
    ];

  # ZFS-config:
  # zpool create -O compression=on -O mountpoint=none -O xattr=sa -O acltype=posixacl -o ashift=12 away-nas mirror /dev/disk/by-id/xxx /dev/disk/by-id/xxx
  # zfs set com.sun:auto-snapshot=true away-nas
  # zfs create -o mountpoint=legacy away-nas/coldstorage
  # zfs create -o mountpoint=legacy away-nas/local
  # zfs create -o mountpoint=legacy away-nas/remote

  # Bootloader.
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "away-nas";
    hostId = "3f784bad"; # for OpenZFS
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
