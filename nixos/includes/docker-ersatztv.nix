{ config, pkgs, ... }:

{
  systemd.services.docker-ersatztv = {
    description = "Docker ErsatzTV";
    serviceConfig = {
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose -f /opt/ersatztv/docker-compose.yml up";
      Restart = "on-failure";
    };
    wantedBy = ["multi-user.target"];
    after = ["docker.service" "docker.socket"];
  };
  networking.firewall.allowedTCPPorts = [
    8409
  ];
}