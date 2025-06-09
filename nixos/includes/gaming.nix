{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    package = pkgs.steam-small.override {
                extraEnv = {
                  MANGOHUD = true;
                };
                extraLibraries = p: with p; [
                  mangohud
                ];
              };
  };
}
