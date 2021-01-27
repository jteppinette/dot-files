FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

export EDITOR=vim

autoload -Uz compinit
compinit

eval "$(direnv hook zsh)"
