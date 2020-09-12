FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

autoload -Uz compinit
compinit
