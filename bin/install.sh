#!/bin/bash

echo "Linking mackup config"
rm -f ~/mackup.cfg
ln -s ~/dotfiles/mackup.cfg ~/.mackup.cfg

echo "Linking bash profile"
rm -f ~/.bash_profile
ln -s ~/dotfiles/bash_profile ~/.bash_profile

echo "Linking ctags config"
rm -f ~/.ctags
ln -s ~/dotfiles/ctags ~/.ctags

echo "Linking global ignore and running git-congig setup"
rm -f ~/.global_ignore
ln -s ~/dotfiles/global_ignore ~/.global_ignore
git config --global core.excludesfile $HOME/.global_ignore
git config --global user.name "Javier Woodhouse"
git config --global user.email yevrah@gmail.com
git config --global core.editor nvim
git config credential.helper store

echo "Link nvimrc config"
mkdir -p ~/.config/nvim
rm -f ~/.config/nvim/init.vim
ln -s ~/dotfiles/nvimrc ~/.config/nvim/init.vim

echo "Link oh-my-zsh config"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm -f ~/.zshrc
ln -s ~/dotfiles/zshrc ~/.zshrc

echo "Running mackup respore"
mackup restore
