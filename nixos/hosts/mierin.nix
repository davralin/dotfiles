{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ../includes/secrets/mierin.nix
      ../includes/secrets/nullmailer.nix
      ../includes/acme.nix
      ../includes/ansible.nix
      ../includes/auto-update.nix
      ../includes/common.nix
      ../includes/garbage-collect.nix
      ../includes/haproxy.nix
      ../includes/impermanence-root.nix
      ../includes/locale.nix
      ../includes/mikr.nix
      ../includes/node-exporter.nix
      ../includes/physical.nix
      ../includes/router.nix
      ../includes/ssh.nix
      ../includes/sudo.nix
      ../includes/tailscale.nix
      ../includes/unfree.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Mierin";
  networking.useDHCP = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
