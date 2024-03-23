{ config, pkgs, ... }:

{
  # Add sunshine-package
  environment.systemPackages = with pkgs; [
    sunshine
  ];

  networking.firewall = {
    allowedTCPPorts = [ 47984 47989 47990 48010 ];
    allowedUDPPortRanges = [
      { from = 47998; to = 48000; }
    ];
  };

  # Requires to simulate input
  boot.kernelModules = [ "uinput" ];
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';

  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${pkgs.sunshine}/bin/sunshine";
  };

  systemd.user.services.sunshine = {
    description = "Sunshine";
    serviceConfig = {
      ExecStart = "${config.security.wrapperDir}/sunshine";
      Restart = "on-failure";
      RestartSec = "5s";
    };
    wantedBy = ["graphical-session.target"];
    after = ["network-oline.target"];
  };
}
