{ config, pkgs, ... }:

{
  systemd.services.docker-zigbee2mqtt = {
    description = "Docker zigbee2mqtt";
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /opt/zigbee2mqtt/docker-compose.yml up";
      Restart = "on-failure";
    };
    wantedBy = ["multi-user.target"];
    after = ["docker.service" "docker.socket"];
  };
  networking.firewall.allowedTCPPorts = [ 8080 ];
}
