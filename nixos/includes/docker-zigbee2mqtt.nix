{ config, pkgs, ... }:

{
  systemd.services.docker-zigbee2mqtt = {
    description = "Docker zigbeem2qtt";
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /opt/zigbeem2qtt/docker-compose.yml up";
      Restart = "on-failure";
    };
    wantedBy = ["multi-user.target"];
    after = ["docker.service" "docker.socket"];
  };
}