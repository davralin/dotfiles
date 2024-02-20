{ config, pkgs, ... }:

{
  # Tor-client
  services.tor.client.enable = true;
  services.tor = {
    enable = true;
    openFirewall = false; # only meant for access from localhost
    settings = {
      TransPort = [ 9040 ];
      DNSPort = 5353;
    };
  };
}
