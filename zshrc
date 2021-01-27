FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

[[ :$PATH: == *:$HOME/bin:* ]] || PATH=$HOME/bin:$PATH

export EDITOR=vim

autoload -Uz compinit
compinit

eval "$(direnv hook zsh)"
