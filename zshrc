# Antigen core ----------------------------------------------------------------

export ANTIGEN=$HOME/lib/antigen
source $ANTIGEN/antigen.zsh

# Antigen imports -------------------------------------------------------------

# oh-my-zsh core
antigen-use oh-my-zsh

# Antigen plugins
antigen-bundle git
antigen-bundle osx
antigen-bundle zsh-users/zsh-syntax-highlighting

# Zsh Theme
antigen-theme af-magic

# Apply configuration
antigen-apply

# Environment variables -------------------------------------------------------

export EDITOR='mvim'
export PATH=~/bin:/usr/local/bin:${PATH}

# Aliases ---------------------------------------------------------------------

alias tm='tmux -u2'
alias c='clear'
alias mkl='latexmk -pdf -pvc'
