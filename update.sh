#!/bin/bash

# zsh config
cp ~/.zshrc ./

# konsole
cp ~/.local/share/konsole ./.local/share -r

# helix editor
cp ~/.config/helix ./.config -r

# kde plasma keyboard shortcuts
cp ~/.config/kglobalshortcutsrc ./.config
cp ~/.config/khotkeysrc ./.config
