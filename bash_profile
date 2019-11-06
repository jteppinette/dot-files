export ANSIBLE_HOST_KEY_CHECKING=False

alias luarocks5.3="luarocks --lua-dir=/usr/local/opt/lua@5.3"
alias luarocks5.1="luarocks --lua-dir=/usr/local/opt/lua@5.1"

BASH_COMPLETION_DIR=/usr/local/etc/bash_completion.d
for file in $BASH_COMPLETION_DIR/*; do source $file; done

if [ ! -d "$HOME/.tmux/plugins" ]; then
	if [ -x "$(command -v git)" ]; then
		echo "INITIALIZING TPM"
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	fi
fi

if [ -f $HOME/.bash_profile.local ]; then
    source $HOME/.bash_profile.local
fi
