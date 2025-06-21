{ config, pkgs, ... }:

{
  # Inspiration:
  #  - https://francis.begyn.be/blog/nixos-home-router
  #  - https://github.com/ghostbuster91/blogposts/blob/a2374f0039f8cdf4faddeaaa0347661ffc2ec7cf/router2023-part2/main.md
  #  - https://nixos.wiki/wiki/Systemd-networkd
  #  - https://wiki.nixos.org/wiki/Networking
  #  - https://dataswamp.org/~solene/2022-08-03-nixos-with-live-usb-router.html

  #powerManagement.cpuFreqGovernor = "ondemand";
  #boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

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
      "20-enp2s0" = {
        matchConfig.Name = "enp2s0";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = false;
        };
      };
    };
  };

  networking = {
    firewall.interfaces = {
      enp2s0 = {
        allowedTCPPorts = [ ];
        allowedUDPPorts = [
          443 # WireGuard
        ];
      };
      lan = {
        allowedTCPPorts = [
          22 # SSH
          53 # DNSmasq
          8404 # node-exporter for HAproxy
          9100 # node-exporter
          9153 # node-exporter for DNSmasq
          9586 # node-exporter for WireGuard
        ];
        allowedUDPPorts = [
          53 # DNSmasq
          67 # DNSmasq-dhcp
          69 # DNSmasq-tftp
        ];
      };
      wg0 = {
        allowedTCPPorts = [
          22 # SSH
          53 # DNSmasq
        ];
        allowedUDPPorts = [
          53 # DNSmasq
        ];
      };
    };
    bridges.lan = {
        interfaces = [ "enp1s0" ];
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
        "wg0"
      ];
      externalInterface = "enp2s0";
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
    wireguard.interfaces = {
      wg0 = {
        ips = [ "10.0.2.1/24" ];
        listenPort = 443;
        privateKeyFile = "/opt/wireguard/wg-private.key";
        peers = [
        { # GL-Inet
          publicKey = "h/LU8/EF3f1QcPa+thUUfgcWvMPaPyhdJUxIEb8G1kI=";
          allowedIPs = [ "10.0.2.2/32" ];
        }
        { # Laptop
          publicKey = "hW6rycb0yug7eq3NUloXUDE+dYlDcINd2FuBBPCPflc=";
          allowedIPs = [ "10.0.2.3/32" ];
        }
        { # Phone
          publicKey = "f5EOS4Imm9H4CJup/SCvQjocPKM7Givd/UOcAbMjg2Q=";
          allowedIPs = [ "10.0.2.4/32" ];
        }
        { # Tablet
          publicKey = "tx8eAr/FqoXWFmZfBRwP8hWTjY7js42/85sdrsm293I=";
          allowedIPs = [ "10.0.2.5/32" ];
        }
        { # ARM
          publicKey = "VGVrbDI/epkO9xRMeXj/B7FokXfJNGt/ffj4pRPvXnk=";
          allowedIPs = [ "10.0.2.6/32" ];
        }
        { # ADSB
          publicKey = "fTZHXZL0gc3evEeINw+tBTYweL5hf6AeVI+/4pW7zHA=";
          allowedIPs = [ "10.0.2.7/32" ];
        }
      ];
      };
    };
  };
  services = {
    avahi = {
      enable = true;
      reflector = true;
      allowInterfaces = [
        "lan"
        "tailscale0"
        "wg0"
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
    prometheus.exporters.wireguard = {
      enable = true;
    };
  };
}
