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

fpath=(~/.zsh/completions $fpath)

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
source <(jj util completion zsh)

# aliases
alias rm="rm -i" # rm safety
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias es="eza"
alias ea="eza -a"
alias el="eza -l"
alias ela="eza -la"

alias zj="zellij"
alias ff="fastfetch"

export EDITOR=ms
# export VISUAL=bat

export BAT_THEME="OneHalfLight"

PLATFORM="$(uname)"
function cpcwd {
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

# yazi shell wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
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

export PATH="$HOME/.local/bin:$PATH"
export SSH_SK_HELPER="/mnt/c/Windows/System32/OpenSSH/ssh-sk-helper.exe"

# macOS specific
if [[ "$OSTYPE" == darwin* ]]; then
    export PATH="/opt/homebrew/opt/macos-trash/bin:$PATH"
fi

# Linux specific
if [[ "$OSTYPE" == linux-gnu* ]]; then
    export PATH="$HOME/.opencode/bin:$PATH"
fi
