{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.autoPrune.enable = true;
  virtualisation.docker.autoPrune.dates = "monthly";
  virtualisation.docker.extraPackages = with pkgs; [
    docker-compose
  ];
}
