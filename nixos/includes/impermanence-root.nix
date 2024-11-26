{ config, pkgs, ... }:

{
  # Yololol
  users.users.root.initialPassword = "hunter2";

  environment.etc."machine.id".source
    = "/nix/persist/etc/machine-id";
  environment.etc."ssh/ssh_host_rsa_key".source
    = "/nix/persist/etc/ssh/ssh_host_rsa_key";
  environment.etc."ssh/ssh_host_rsa_key.pub".source
    = "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
  environment.etc."ssh/ssh_host_ed25519_key".source
    = "/nix/persist/etc/ssh/ssh_host_ed25519_key";
  environment.etc."ssh/ssh_host_ed25519_key.pub".source
    = "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";
  environment.etc."NetworkManager/system-connections".source
    = "/nix/persist/etc/NetworkManager/system-connections";
  systemd.tmpfiles.rules = [
    "L /var/lib/acme - - - - /nix/persist/var/lib/acme"
    "L /var/lib/bluetooth - - - - /nix/persist/var/lib/bluetooth"
    "L /var/lib/dnsmasq - - - - /nix/persist/var/lib/dnsmasq"
    "L /var/lib/private/ollama - - - - /nix/persist/var/lib/private/ollama"
    "L /var/lib/tailscale - - - - /nix/persist/var/lib/tailscale"
  ];
}
