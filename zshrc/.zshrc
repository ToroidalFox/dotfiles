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
alias ela="eza -la"
alias cppwd='echo $(pwd) | wl-copy'

alias aie="gh copilot explain"
alias ais="gh copilot suggest"

export BAT_THEME="OneHalfLight"

eval "$(starship init zsh)"
