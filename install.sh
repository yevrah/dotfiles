#!/bin/bash

echo "Changing working folder to $HOME"
cd ~

echo "Cloning dofiles"
git clone https://github.com/yevrah/dotfiles.git dotfiles

echo "Calling restore.sh in ~/dotfiles/bin/"
/bin/bash ./dotfiles/bin/restore.sh

