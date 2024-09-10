HISTFILE=~/.zsh_history
HISTSIZE=6000
SAVEHIST=6000000

setopt \
  autocd \
  no_beep \
  extendedglob \
  nomatch \
  notify \

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/toroidalfox/.zshrc'

bindkey -e

bindkey '^[[1;5D' backward-word
bindkey '^[[H'    beginning-of-line
bindkey '^[[1;5C' forward-word
bindkey '^[[F'    end-of-line

autoload -Uz compinit
compinit

# aliases
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias es="eza"
alias ea="eza -a"
alias el="eza -l"
alias ela="eza -la"

alias zj="zellij"
alias ff="fastfetch"

export EDITOR=hx
# export VISUAL=bat

export BAT_THEME="OneHalfLight"

PLATFORM="$(uname)"
function cppwd {
    if [[ "$PLATFORM" == "Linux" && "$XDG_SESSION_TYPE" == "wayland" ]]; then
        if command -v wl-copy > /dev/null 2>&1; then
            echo -n $(pwd) | wl-copy
            echo "$(pwd) > clipboard"
        else
            echo "wl-clipboard(wl-copy) does not exist."
        fi
    else
        echo "`cppwd` is not implemented in this platform."
    fi
}

function evoke {
    if [[ $PLATFORM == "Linux" ]]; then
        xdg-open $@ > /dev/null 2>&1
    else
        echo "`evoke` is not implemented in this platform."
    fi
}

function justemplate {
    if [ ! -f .justfile ]; then cat << EOF > .justfile
[private]
default:
    @just --list --unsorted

[private]
edit:
    @\$EDITOR .justfile
EOF
    fi
}

eval "$(starship init zsh)"
