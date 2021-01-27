FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

autoload -Uz compinit
compinit

eval "$(direnv hook zsh)"
