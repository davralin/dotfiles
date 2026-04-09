{ config, pkgs, ... }:

{
  services.dockerRegistry = {
    enable = true;
    listenAddress = "10.0.1.1";
    port = 5001;
    storagePath = "/opt/local/dockercache/dockerhub";
    enableDelete = true;
    extraConfig = {
      proxy = {
        remoteurl = "https://registry-1.docker.io";
      };
    };
  };
}
