{ config, pkgs, ... }:

{
  # Add qemu-agent
  services.qemuGuest.enable = true;
}
