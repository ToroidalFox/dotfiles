# dotfiles

[GNU Stow](https://www.gnu.org/software/stow/) is used to manage dotfiles.

```sh
stow package_name; stow -S; stow --stow
# Example
# stow helix

stow -n package_name; stow --no; stow --simulate # Don't actually do it. Just simulate.

stow -D package_name; stow --delete # Delete. Unstow package.

stow -R package_name; stow --restow # Restow. Equivalent to --delete followed by --stow.
```

## OTHERS

### Firefox

#### User Agent Switcher and Manager

`Options` > `Custom Mode`
```json
{
  "bing.com": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1788.0",
  "*": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/113.0"
}
```

## PACKAGES

### Fedora

```sh
# Starship cross-shell prompt
# https://starship.rs
curl -sS https://starship.rs/install.sh | sh

dnf install thefuck # Command error corrector. https://github.com/nvbn/thefuck
dnf install bat # better `cat`. https://github.com/sharkdp/bat

dnf copr enable atim/bottom -y
dnf install bottom # cross-platform system monitor. https://github.com/ClementTsang/bottom

dnf install fd-find
dnf install ripgrep
```
