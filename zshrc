# paths
[[ :$PATH: == *:$HOME/bin:* ]] || PATH=$HOME/bin:$PATH

# zsh-completions
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

autoload -Uz compinit
compinit

# direnv
eval "$(direnv hook zsh)"

# pyenv
export PATH="$HOME/.pyenv/shims:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
fi

eval "$(pyenv init -)"

# fzf
export FZF_DEFAULT_COMMAND="fd --type f"

# aliases
alias fzf="fzf --preview 'bat --color=always --style=numbers --line-range=:250 {}'"
alias vimf='vim -o "$(fzf)"'
