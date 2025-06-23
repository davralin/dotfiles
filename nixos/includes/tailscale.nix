{ config, pkgs, ... }:

{
  # Enable tailscale
  services.tailscale.enable = true;
  # Allows tailscale to act as a subnet-router/exit-node without giving warnings
  services.tailscale.useRoutingFeatures = "server";
}
