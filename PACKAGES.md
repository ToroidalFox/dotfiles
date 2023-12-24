## Fedora Asahi Remix
### DNF
```sh
  dnf install zsh alacritty gh gitui stow helix wl-clipboard just ripgrep bat fd-find neofetch python-unversioned-command nodejs podman
  dnf install thunderbird chromium gimp kdenlive
  dnf install asahi-bless
  dnf groupinstall "Development Tools" "Development Libraries"
```
### DNF Copr
```sh
  dnf copr enable toroidalfox/kime
  dnf install kime
  dnf copr enable g3tchoo/prismlauncher
  dnf install prismlauncher
  dnf copr enable atim/bottom
  dnf install bottom
```

### Flatpak
```sh
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  flatpak install flathub io.dbeaver.DBeaverCommunity
  flatpak install flathub io.podman_desktop.PodmanDesktop
```

### npm

### AppImage

[Obsidian](https://obsidian.md/download)

### Script

```sh
# starship
curl -sS https://starship.rs/install.sh | sh
# rust toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### Manual Installation with RPM

- [overGrive](https://www.overgrive.com)
- [ArmCord](https://github.com/ArmCord/ArmCord/releases)
- [VSCode](https://code.visualstudio.com/docs/setup/linux)

### KDE Plasma Widgets

- Plasma Drawer
- Window Title Applet
