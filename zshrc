# Fastfect niceeties
fastfetch --load-config ./fastfect.jsonc

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/Documents/dotfiles/bin:$PATH
export DOTFILES=$HOME/Documents/dotfiles
export ZSH="$HOME/.oh-my-zsh"


plugins=(git npm z pip zsh-syntax-highlighting zsh-autosuggestions)

ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh
source $DOTFILES/zshrc_aliases.zsh

source $HOME/powerlevel10k/powerlevel10k.zsh-theme
source $HOME/.p10k.zsh

