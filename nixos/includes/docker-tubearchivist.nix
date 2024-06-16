{ config, pkgs, ... }:

{
  systemd.services.docker-tubearchivist = {
    description = "Docker TubeArchivist";
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /opt/tubearchivist/docker-compose.yml up";
      Restart = "on-failure";
    };
    wantedBy = ["multi-user.target"];
    after = ["docker.service" "docker.socket"];
  };
}