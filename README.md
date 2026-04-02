# dotfiles

Personal configuration files for an i3-based Linux desktop and NixOS systems.

## Desktop Environment

- **Window manager:** i3wm with i3blocks status bar
- **Terminals:** Alacritty, Kitty
- **Launcher:** rofi
- **Notifications:** dunst
- **Compositor:** picom
- **Color temperature:** gammastep
- **Screenshots:** flameshot
- **Theme:** GTK 3.0 config

## Music

- MPD + ncmpcpp + MOC configs
- yt-dlp download presets

## Security

- **GPG/SSH:** YubiKey-based authentication with GPG signing for git commits
- **Encryption:** [git-crypt](https://github.com/AGWA/git-crypt) for sensitive files, [age](https://github.com/FiloSottile/age) keys (GPG-encrypted)

## NixOS

System configurations live in `nixos/`:

**Hosts** (`nixos/hosts/`):
- `mierin.nix` — Workstation
- `home-nas.nix` — Home NAS
- `away-nas.nix` — Off-site NAS

**Shared modules** (`nixos/includes/`): Common system config, Docker services (AdGuard, Immich, Garage), HAProxy, ZFS, impermanence, Tailscale, backups (rsnapshot, rclone, borgmatic for k8s), router, Samba, NFS, libvirtd, and more.

Key patterns:
- **Impermanence** — Root filesystem is ephemeral; only explicitly declared state persists
- **SOPS/age** — Secret management via `nixos/includes/secrets/`
- **Tailscale** — Mesh networking across hosts

## Structure

```
alacritty/     Terminal config
bash/          Aliases
dunst/         Notification daemon
git/           Git config (GPG signing, aliases)
gpg/           GPG config + public key
i3/            Window manager config
i3blocks/      Status bar
kitty/         Terminal config
nixos/
  hosts/       Per-machine NixOS configs
  includes/    Shared NixOS modules
rofi/          App launcher
ssh/           SSH config (YubiKey pubkey)
tmux/          Terminal multiplexer
vim/           Editor config
```

## Usage

Symlink or copy configs to their expected locations (typically `~/.config/<app>/`). NixOS configs are deployed via the standard `nixos-rebuild` workflow.

## License

[GPL-3.0](LICENSE)
