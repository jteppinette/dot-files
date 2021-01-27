FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

[[ :$PATH: == *:$HOME/bin:* ]] || PATH=$HOME/bin:$PATH

autoload -Uz compinit
compinit
