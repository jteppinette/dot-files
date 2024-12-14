#!/bin/zsh

realpath() {
	[[ $1 = /* ]] && echo $1 || echo $PWD/${1#./}
}

SCRIPT=$(realpath $0)
DIR=$(dirname $SCRIPT)

# brew

if ! command -v brew &>/dev/null; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew bundle install --file=$DIR/Brewfile

# configurations
ln -sf $DIR/gitconfig $HOME/.gitconfig
ln -sf $DIR/zshrc $HOME/.zshrc
ln -sf $DIR/tmux.conf $HOME/.tmux.conf
ln -sf $DIR/nvim.lua $HOME/.config/nvim/init.lua
ln -sf $DIR/kitty.conf $HOME/.config/kitty/kitty.conf

# tpm
if [ ! -d $HOME/.tmux/plugins ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# zsh completions
autoload -U compaudit && compaudit 2>/dev/null | xargs chmod g-w

# tldr
tldr --update

# nvm
mkdir -p $HOME/.nvm
