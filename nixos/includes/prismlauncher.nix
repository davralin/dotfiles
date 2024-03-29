{ config, pkgs, ... }:

{
  # Enable prism launcher
  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
}
