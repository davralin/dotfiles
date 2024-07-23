{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../includes/ansible.nix
      ../includes/auto-update.nix
      ../includes/common.nix
      ../includes/docker.nix
      ../includes/garbage-collect.nix
      ../includes/impermanence-root.nix
      ../includes/locale.nix
      ../includes/mikr.nix
      ../includes/qemu-guest.nix
      ../includes/node-exporter.nix
      ../includes/ssh.nix
      ../includes/sudo.nix
      ../includes/unfree.nix
    ];

  # Bootloader.
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "Template";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
