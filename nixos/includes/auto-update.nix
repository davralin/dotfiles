{ config, pkgs, ... }:

{
  # Automatic host-maintenance.
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  nix.settings.auto-optimise-store = true;

  # Automate git pull of dotfiles
  systemd.timers."git-pull-dotfiles" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "git-pull-dotfiles.service";
      };
  };

  systemd.services."git-pull-dotfiles" = {
    script = ''
      set -eu
      cd /nix/persist/dotfiles
      ${pkgs.git}/bin/git pull --rebase
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
