#!/bin/sh

SCRIPT=$(realpath $0)
DIR=$(dirname $SCRIPT)
CONFIG=$HOME/.config/home-manager

mkdir -p $CONFIG &>/dev/null

ln -sf $DIR/flake.nix $CONFIG/flake.nix
ln -sf $DIR/home.nix $CONFIG/home.nix

if ! command -v home-manager &>/dev/null; then
	nix run home-manager/release-24.11 -- switch --impure
else
	home-manager switch --impure
fi

if [ -f /etc/os-release ]; then
	. /etc/os-release

	if [ "$ID" = "nixos" ]; then
		continue
	fi

	sudo $(which nix) \
		run "github:numtide/system-manager/c9e35e9b7d698533a32c7e34dfdb906e1e0b7d0a" -- \
		switch --flake "." --nix-option pure-eval false
fi
