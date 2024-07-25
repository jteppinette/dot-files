# brew
if [ -d /opt/homebrew ]; then
	BREW_PREFIX=/opt/homebrew
else
	BREW_PREFIX=/usr/local
fi

eval "$($BREW_PREFIX/bin/brew shellenv)"

# paths
[[ :$PATH: == *:$HOME/bin:* ]] || PATH=$HOME/bin:$PATH

# zsh-completions
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
autoload -U compinit && compinit

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
alias fda="fd --hidden --exclude .git --exclude .direnv --exclude __pycache__ --type f"
alias ls="exa"
alias du="du -A"

# git
function git-open() { (
	set -e

	git remote >>/dev/null

	remote=${1:-origin}
	url=$(git config remote.$remote.url | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")

	echo "git: opening $remote $url"

	open $url
); }

# gcloud
if [ -d "$HOME/google-cloud-sdk" ]; then
	export PATH="$HOME/google-cloud-sdk/bin:$PATH"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$BREW_PREFIX/opt/nvm/nvm.sh" ] && . "$BREW_PREFIX/opt/nvm/nvm.sh"
[ -s "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && . "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

# llvm
export PATH="$BREW_PREFIX/opt/llvm/bin:$PATH"
