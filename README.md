## Bootstrap

Assuems that `nix`, `curl`, `tar` are available.

```sh
curl -Ls https://github.com/ToroidalFox/dotfiles/archive/refs/heads/nix.tar.gz | tar -xz
# cd into the extracted
nix run home-manager/release-26.05 -- switch --flake .#linux-<>-min
just ghrk ID
jj git clone ghID:ToroidalFox/dotfiles.git .dotfiles
cd .dotfiles
```
