{ config, pkgs, ... }:

{
  # Inspiration:
  #  - https://francis.begyn.be/blog/nixos-home-router
  #  - https://github.com/ghostbuster91/blogposts/blob/a2374f0039f8cdf4faddeaaa0347661ffc2ec7cf/router2023-part2/main.md
  #  - https://nixos.wiki/wiki/Systemd-networkd
  #  - https://wiki.nixos.org/wiki/Networking
  #  - https://dataswamp.org/~solene/2022-08-03-nixos-with-live-usb-router.html

  powerManagement.cpuFreqGovernor = "ondemand";
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  boot.kernel = {
    sysctl = {
      "net.ipv4.conf.all.forwarding" = true;
      "net.ipv6.conf.all.forwarding" = false;
    };
  };
  systemd.network = {
    enable = true;
    wait-online.anyInterface = true;
    networks = {
      "20-enp4s0" = {
        matchConfig.Name = "enp4s0";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = false;
        };
      };
    };
  };

  networking = {
    firewall.interfaces = {
      lan = {
        allowedTCPPorts = [
          22 # SSH
          53 # DNSmasq
          9100 # node-exporter
          9153 # node-exporter for DNSmasq
        ];
        allowedUDPPorts = [
          53 # DNSmasq
          67 # DNSmasq-dhcp
          69 # DNSmasq-tftp
        ];
      };
    };
    bridges.lan = {
        interfaces = [ "enp1s0" "enp2s0" "enp3s0" ];
    };
    interfaces.lan = {
        ipv4.addresses = [
            { address = "10.0.1.1"; prefixLength = 24; }
        ];
    };
    nat = {
      enable = true;
      internalInterfaces = [
        "lan"
      ];
      externalInterface = "enp4s0";
      forwardPorts = [
        {
          # minecraft
          sourcePort = 25565;
          proto = "tcp";
          destination = "10.0.1.31:25565";
        }
        {
          # plex
          sourcePort = 32400;
          proto = "tcp";
          destination = "10.0.1.30:32400";
        }
        {
          # qbit
          sourcePort = 9500;
          proto = "tcp";
          destination = "10.0.1.38:9500";
        }
        {
          # syncthing
          sourcePort = 22000;
          proto = "tcp";
          destination = "10.0.1.33:22000";
        }
        {
          # syncthing
          sourcePort = 22000;
          proto = "udp";
          destination = "10.0.1.33:22000";
        }
      ];
    };
  };
  services = {
    avahi = {
      enable = true;
      reflector = true;
      allowInterfaces = [
        "lan"
        "tailscale0"
      ];
    };
    dnsmasq = {
      enable = true;
    };
    prometheus.exporters.dnsmasq = {
      enable = true;
    };
    openssh = {
      openFirewall = false;
    };
    resolved = {
      enable = false;
    };
  };
}