{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      # nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
      <nixos-hardware/lenovo/thinkpad/x1/6th-gen> # It's really 5th-gen, but lets try this a bit first
      ../includes/auto-update.nix
      ../includes/bluetooth.nix
      ../includes/common.nix
      ../includes/common-gui.nix
      ../includes/firmware.nix
      ../includes/garbage-collect.nix
      ../includes/impermanence-root.nix
      ../includes/locale.nix
      ../includes/gnupg.nix
      ../includes/kernel.nix
      ../includes/mikr.nix
      ../includes/physical.nix
      ../includes/physical-laptop.nix
      ../includes/pipewire.nix
      ../includes/prismlauncher.nix
      ../includes/ssh.nix
      ../includes/sudo.nix
      ../includes/tor_client.nix
      ../includes/unfree.nix
      ../includes/xfce.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  services.blueman.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
