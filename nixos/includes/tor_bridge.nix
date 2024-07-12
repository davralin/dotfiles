{ config, pkgs, ... }:

{
  # Tor-relay
  services.tor = {
    enable = true;
    openFirewall = true;
    relay = {
      enable = true;
      role = "bridge";
    };
    settings = {
      #Address = "127.0.0.1";
      #ContactInfo= "remove@spam.com";
      #Nickname = "TorBridge";
      ORPort = 443;
      MetricsPort = "0.0.0.0:9035 prometheus";
      MetricsPortPolicy = "accept 0.0.0.0/0";
    };
  };
}
