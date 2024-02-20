{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../includes/auto-update.nix
      ../includes/backup-k8s.nix
      ../includes/common.nix
      ../includes/garbage-collect.nix
      #../includes/impermanence-root.nix
      ../includes/locale.nix
      ../includes/kernel.nix
      ../includes/mikr.nix
      ../includes/node-exporter.nix
      ../includes/qemu-guest.nix
      ../includes/ssh.nix
      ../includes/sudo.nix
      ../includes/unfree.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "Backup";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
