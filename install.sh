#!/usr/bin/env bash

TIMESTAMP=$(date +%s);

#if ! type git >/dev/null 2>&1 ; then
#    sudo apt-get install -y git
#    sh ./install.sh
#    exit 0;
#fi
#
#if ! type vim >/dev/null 2>&1 ; then
#    sudo apt-get install -y vim-gtk
#    sh ./install.sh
#    exit 0;
#fi
#sudo apt-get install -y zsh xclip git git-flow tig vim-gtk tmux python-pip curl software-properties-common python-software-properties
#sudo apt-get install -y automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev

# Use sudo to run easy_intall
# easy_install pip
pip install --upgrade pip
pip install awscli

#git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.3.0


#########################################################################
#
# Clone this repository using git --recursive option
#
#
#git clone --recursive https://github.com/rafaellucio/dotfiles.git
#
#
#########################################################################


wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | zsh

for f in $(find ~/dotfiles/* -maxdepth 0 -type f -not -name "install.sh" -not -name "LICENSE" -not -name "README.md")
do
	rm -f "$HOME/.${f##*/}"	
	ln -s "$f" "$HOME/.${f##*/}"
done

if [[ -L $HOME/.ssh ]]  && [[ "$(readlink $HOME/.ssh)" = "$HOME/dotfiles/ssh" ]] ; then
	rm -rf "$HOME/.ssh"
else
	mv "$HOME/.ssh" "$HOME/ssh-bkp-$TIMESTAMP"
fi

rm -rf "$HOME/.oh-my-zsh"
rm -rf "$HOME/.backup"
rm -rf "$HOME/.bin"
rm -rf "$HOME/.pgpass"
rm -rf "$HOME/.aws"
mkdir "$HOME/.backup"

ln -s "$HOME/dotfiles/oh-my-zsh" "$HOME/.oh-my-zsh"
ln -s "$HOME/dotfiles/bin" "$HOME/.bin"

ln -s "$HOME/dotfiles/ssh" "$HOME/.ssh"
ln -s "$HOME/dotfiles/ssh/pgpass" "$HOME/.pgpass"
ln -s "$HOME/dotfiles/ssh/aws" "$HOME/.aws"

mkdir $HOME/.backup

vim +PluginInstall +qall

echo FIM
