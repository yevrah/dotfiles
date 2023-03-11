# What is this?

This repositry contains the dotfiles needed to get a working zsh shell in MacOS and setup a Neovim development environment.

# Network install

The network isntall clones the dotfiles project to `~/dotfiles`, in addition to creating links to the dotfiles, and running `mackup restore` for private files not in the repo - such as ssh private keys which are stored in an iCloud folder.

    curl -sS https://raw.githubusercontent.com/yevrah/dotfiles/master/install.sh | /bin/bash

TODO: Add oh-my-zsh install
