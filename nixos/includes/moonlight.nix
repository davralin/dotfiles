{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    moonlight-embedded
  ];
}
