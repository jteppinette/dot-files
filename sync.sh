#!/bin/zsh

SCRIPT=$(realpath $0)
DIR=$(dirname $SCRIPT)
CONFIG=$HOME/.config/home-manager

mkdir -p $CONFIG &>/dev/null

ln -sf $DIR/flake.nix $CONFIG/flake.nix
ln -sf $DIR/home.nix $CONFIG/home.nix

if ! command -v home-manager &>/dev/null; then
	CHANNEL="https://github.com/nixos/nixpkgs/tarball/nixpkgs-24.11-darwin"
	nix-shell \
		--packages home-manager \
		--include "nixpkgs=$CHANNEL" \
		--run "home-manager switch --impure"
else
	home-manager switch --impure
fi
