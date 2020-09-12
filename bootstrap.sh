#!/bin/sh

brew install coreutils &> /dev/null

SCRIPT=$(greadlink -f "$0")
DIR=$(dirname "$SCRIPT")

brew bundle install --file=$DIR/Brewfile &> /dev/null

ln -sf $DIR/bash_profile	$HOME/.bash_profile
ln -sf $DIR/tmux.conf 		$HOME/.tmux.conf
ln -sf $DIR/vimrc		$HOME/.vimrc

if [ ! -d "$HOME/.tmux/plugins" ]; then
	if command -v git &> /dev/null; then
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	fi
fi
