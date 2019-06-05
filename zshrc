export ZSH=$HOME/.oh-my-zsh
# Defaults

export PATH=$HOME/dotfiles/bin/:$PATH
export DOTFILES=$HOME/dotfiles

export EDITOR='nvim'
export SSH_KEY_PATH="~/.ssh/rsa_id"
export DEVBOX='HARVEY'


DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Plugins - Install with
#  k: $ git clone https://github.com/supercrabtree/k $ZSH_CUSTOM/plugins/k
plugins=(git npm z yarn pip k)

# Loads color aliases
autoload -U colors && colors

# Extras
source $ZSH/oh-my-zsh.sh
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $DOTFILES/zshrc-motd.zsh
source $DOTFILES/zshrc-theme.zsh
source $DOTFILES/zshrc_aliases.zsh
source $DOTFILES/zshrc_env_plugin.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/javierwoodhouser/dev/athena/athena-svc/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/javierwoodhouser/dev/athena/athena-svc/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/javierwoodhouser/dev/athena/athena-svc/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/javierwoodhouser/dev/athena/athena-svc/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/javierwoodhouser/dev/athena/athena-svc/src/services/otpV2/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/javierwoodhouser/dev/athena/athena-svc/src/services/otpV2/node_modules/tabtab/.completions/slss.zsh
