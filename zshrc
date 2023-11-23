export ZSH=$HOME/.oh-my-zsh
# Defaults

export PATH=$HOME/Documents/dotfiles/bin:$PATH
# Add sublime support
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export DOTFILES=$HOME/Documents/dotfiles

export EDITOR='nvim'
export SSH_KEY_PATH="~/.ssh/rsa_id"
export DEVBOX='HARVEY'

ZSH_THEME=robbyrussell

DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Plugins - Install with
#  k: $ git clone https://github.com/supercrabtree/k $ZSH_CUSTOM/plugins/k
plugins=(git npm z yarn pip)

# Loads color aliases
autoload -U colors && colors

# Extras
source $ZSH/oh-my-zsh.sh

source $DOTFILES/zshrc-motd.zsh
source $DOTFILES/zshrc-theme.zsh
source $DOTFILES/zshrc_aliases.zsh
source $DOTFILES/zshrc_env_plugin.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/usr/local/opt/mysql-client/bin:$PATH"
