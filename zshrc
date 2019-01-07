# Defaults
export ZSH=$HOME/.oh-my-zsh

export PATH=$HOME/dotfiles/bin/:$PATH
export DOTFILES=$HOME/dotfiles

export EDITOR='nvim'
export SSH_KEY_PATH="~/.ssh/rsa_id"
export DEVBOX='HARVEY'

DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git npm z yarn pip)

# Loads color aliases
autoload -U colors && colors


# Show System Info - use neofect as it's aster
if hash neofetch 2>/dev/null; then
  neofetch
elif hash screenfetch 2>/dev/null; then
  screenfetch
fi


# Extras
source $ZSH/oh-my-zsh.sh
source $DOTFILES/zshrc-theme.zsh
source $DOTFILES/zshrc_aliases.zsh
source $DOTFILES/zshrc_env_plugin.zsh



