{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arandr
  ];
}
