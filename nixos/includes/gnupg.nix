{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubikey-personalization
  ];

  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];

  hardware.gpgSmartcards.enable = true;
  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
