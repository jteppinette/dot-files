#!/bin/zsh

realpath() {
    [[ $1 = /* ]] && echo $1 || echo $PWD/${1#./}
}

SCRIPT=$(realpath $0)
DIR=$(dirname $SCRIPT)

brew bundle install --file=$DIR/Brewfile

ln -sf $DIR/zshrc		$HOME/.zshrc
ln -sf $DIR/tmux.conf 		$HOME/.tmux.conf
ln -sf $DIR/vimrc		$HOME/.vimrc

if [ ! -d $HOME/.tmux/plugins ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

compaudit 2> /dev/null | xargs chmod g-w

# openjdk
sudo ln -sfn /usr/local/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk

# nvm
mkdir -p $HOME/.nvm
