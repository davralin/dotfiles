{ config, pkgs, ... }:

{
  systemd.services.docker-watchtower = {
    description = "Docker Watchtower";
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /opt/watchtower/docker-compose.yml up";
      Restart = "on-failure";
    };
    wantedBy = ["multi-user.target"];
    after = ["docker.service" "docker.socket"];
  };
}
