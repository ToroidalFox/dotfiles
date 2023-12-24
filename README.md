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
