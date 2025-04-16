{ config, pkgs, ... }:

let
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";
in

{
  # Yololol
  users.users.root.initialPassword = "hunter2";

  imports = [ "${impermanence}/nixos.nix" ];

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
      "/opt"
      "/var/log"
      "/var/lib/acme"
      "/var/lib/bluetooth"
      "/var/lib/dnsmasq"
      "/var/lib/nixos"
      "/var/lib/tailscale"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };
}