{ config, pkgs, ... }:

{
  systemd.services.docker-adsb = {
    description = "Docker ADSB";
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /opt/adsb/docker-compose.yml up";
      Restart = "on-failure";
    };
    wantedBy = ["multi-user.target"];
    after = ["docker.service" "docker.socket"];
  };
}
