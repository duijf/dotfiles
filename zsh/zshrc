export ZSH=$HOME/.lib/dotfiles/zsh
source $ZSH/antigen.zsh

# Load core oh-my-zsh-functionality
antigen-lib

# Plugins
antigen-bundle git
antigen-bundle osx
antigen-bundle zsh-users/zsh-syntax-highlighting

# Theme
antigen-theme af-magic

antigen-apply

# Environment variables -------------------------------------------------------

export EDITOR='vim'
export PATH=/usr/local/bin:${PATH}

# Source utilities ------------------------------------------------------------

[[ -s "/usr/local/rvm/scripts/rvm" ]] && . "/usr/local/rvm/scripts/rvm"

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# Aliases ---------------------------------------------------------------------

alias tm='tmux -u2'
alias c='clear'
alias mkl='latexmk -pdf -pvc'
