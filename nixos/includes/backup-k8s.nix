{ config, pkgs, ... }:

{
  # Password isn't needed, as the key should be enough.
  users.users.backup = {
    isNormalUser = true;
    description = "Backup@k8s";
    extraGroups = [ "wheel" ];
    createHome = true;
    group = "backup";
    home = "/opt/local";
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOiSBHUnu15cSSoC0T2QLvOFplb2WzbcxPDTBoxqpXLZ" ];
  };
  users.groups.backup = {};
}
