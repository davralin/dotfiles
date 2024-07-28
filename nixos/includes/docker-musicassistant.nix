{ config, pkgs, ... }:

{
  systemd.services.docker-musicassistant = {
    description = "Docker MusicAssistant";
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /opt/musicassistant/docker-compose.yml up";
      Restart = "on-failure";
    };
    wantedBy = ["multi-user.target"];
    after = ["docker.service" "docker.socket"];
  };
  networking.firewall.allowedTCPPorts = [
    8095
    8097
  ];
}