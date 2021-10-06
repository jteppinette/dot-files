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

# git
function git-open() {(
    set -e

    git remote >> /dev/null

    remote=${1:-origin}
    url=$(git config remote.$remote.url | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")

    echo "git: opening $remote $url"

    open $url
)}

# nvm
export NVM_DIR="$HOME/.nvm"

NVM_ROOT="/usr/local/opt/nvm"
NVM_SCRIPT_PATH="${NVM_ROOT}/nvm.sh"
NVM_COMPLETIONS_PATH="${NVM_ROOT}/etc/bash_completion.d/nvm"

[ -s "${NVM_SCRIPT_PATH}" ] && . "${NVM_SCRIPT_PATH}"
[ -s "${NVM_COMPLETIONS_PATH}" ] && . "${NVM_COMPLETIONS_PATH}"
