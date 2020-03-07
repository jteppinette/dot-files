#!/bin/sh

SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")
CONFIG=$HOME/.config

# Create .config directories
mkdir -p $CONFIG/bspwm \
	 $CONFIG/kitty \
	 $CONFIG/mpd \
	 $CONFIG/sxhkd \
	 $CONFIG/ncmpcpp \
	 $CONFIG/neofetch

# Apply symlinks
ln -sf $DIR/bashrc		$HOME/.bashrc
ln -sf $DIR/dmrc 		$HOME/.dmrc
ln -sf $DIR/gpg-agent.conf 	$HOME/.gnupg/gpg-agent.conf
ln -sf $DIR/sshcontrol 		$HOME/.gnupg/sshcontrol
ln -sf $DIR/tmux.conf 		$HOME/.tmux.conf
ln -sf $DIR/vimrc		$HOME/.vimrc
ln -sf $DIR/user-dirs.dirs	$CONFIG/user-dirs.dirs
ln -sf $DIR/bspwmrc		$CONFIG/bspwm/bspwmrc
ln -sf $DIR/kitty.conf		$CONFIG/kitty/kitty.conf
ln -sf $DIR/mpd.conf		$CONFIG/mpd/mpd.conf
ln -sf $DIR/ncmpcpp.config	$CONFIG/ncmpcpp/config
ln -sf $DIR/ncmpcpp.bindings	$CONFIG/ncmpcpp/bindings
ln -sf $DIR/neofetch.conf	$CONFIG/neofetch/config.conf
ln -sf $DIR/sxhkdrc		$CONFIG/sxhkd/sxhkdrc

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins" ]; then
	if [ -x "$(command -v git)" ]; then
		echo "INITIALIZING TPM"
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	fi
fi
