#!/bin/bash

# echo "Linking mackup config"
# rm -f ~/mackup.cfg
# ln -s ~/dotfiles/mackup.cfg ~/.mackup.cfg
# 
# rm -rf ~/.mackup
# ln -s ~/dotfiles/mackup ~/.mackup

echo "Linking bash profile"
mv ~/.bash_profile ~/.bash_profile_old
ln -s ~/dotfiles/bash_profile ~/.bash_profile

echo "Linking ctags config"
rm -f ~/.ctags
ln -s ~/dotfiles/ctags ~/.ctags

echo "Linking global ignore and running git-congig setup"
# rm -f ~/.global_ignore
# ln -s ~/dotfiles/global_ignore ~/.global_ignore
git config --global core.excludesfile $HOME/dotfiles/_global_ignore
git config --global user.name "Javier Woodhouse"
git config --global user.email yevrah@gmail.com
git config --global core.editor nvim
git config credential.helper store

echo "Link nvimrc config"
mkdir -p ~/.config/nvim
rm -f ~/.config/nvim/init.vim
ln -s ~/dotfiles/nvimrc ~/.config/nvim/init.vim
pip3.7 install neovim

echo "Link oh-my-zsh config"
# AUTO INSTALL: sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Manual install taken from https://github.com/robbyrussell/oh-my-zsh#manual-installation
# git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
# chsh -s /bin/zsh

# mv ~/.zshrc ~/.zshrc_old
ln -s ~/dotfiles/zshrc ~/.zshrc

# echo "ZSH Plugins"
# cd ~/.oh-my-zsh && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git


# echo "Running mackup respore"
# mackup restore
