#!/bin/bash

# echo "Linking mackup config"
# rm -f ~/mackup.cfg
# ln -s ~/dotfiles/mackup.cfg ~/.mackup.cfg
#
# rm -rf ~/.mackup
# ln -s ~/dotfiles/mackup ~/.mackup

echo "Linking bash profile"
mv ~/.bash_profile ~/.bash_profile_old
ln -s ~/Documents/dotfiles/bash_profile ~/.bash_profile

echo "Linking ctags config"
rm -f ~/.ctags
ln -s ~/Documents/dotfiles/ctags ~/.ctags

echo "Linking global ignore and running git-config setup"
# rm -f ~/.global_ignore
# ln -s ~/Documents/dotfiles/global_ignore ~/.global_ignore
git config --global core.excludesfile $HOME/Documents/dotfiles/_global_ignore
git config --global user.name "Javier Woodhouse"
git config --global user.email yevrah@gmail.com
git config --global core.editor nvim
git config credential.helper store

echo "Link nvimrc config"
mkdir -p ~/.config/nvim
rm -f ~/.config/nvim/init.vim
ln -s ~/Documents/dotfiles/nvimrc ~/.config/nvim/init.vim
pip3 install neovim

echo "Link oh-my-zsh config"
# AUTO INSTALL: sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Manual install taken from https://github.com/robbyrussell/oh-my-zsh#manual-installation
# git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
# chsh -s /bin/zsh

# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# compaudit | xargs chmod g-w,o-w

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/supercrabtree/k $ZSH_CUSTOM/plugins/k

mv ~/.zshrc ~/.zshrc_old
ln -s ~/Documents/dotfiles/zshrc ~/.zshrc

# echo "ZSH Plugins"
# cd ~/.oh-my-zsh && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git


# echo "Running mackup restore"
# mackup restore
