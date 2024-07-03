{ config, pkgs, ... }:

{
  services.displayManager = {
    defaultSession = "none+i3";
    };
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        alacritty
        autorandr
        dmenu
        i3status
        i3lock
        i3blocks
        rofi
     ];
    };
  };
}
