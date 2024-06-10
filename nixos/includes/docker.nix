{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.autoPrune.enable = true;
  virtualisation.docker.autoPrune.dates = "monthly";
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
