# Antigen ---------------------------------------------------------------------
export ANTIGEN=$HOME/src/checkout/antigen
source $ANTIGEN/antigen.zsh

antigen-use oh-my-zsh

antigen-bundle git
antigen-bundle osx
antigen-bundle zsh-users/zsh-syntax-highlighting

antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen-apply

# Environment variables -------------------------------------------------------

export EDITOR='vim'
export PATH="$HOME/bin:/usr/local/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Aliases ---------------------------------------------------------------------

alias tm='tmux -u2'
alias c='clear'
alias mkl='latexmk.pl -pdf -pvc'
alias mklc='latexmk.pl -c'
alias ls="ls -F --color=auto --ignore='.*.un~'"
alias lsa='ls -la'

# Bundle aliases
alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"

# Configuration for OS X -----------------------------------------------------

if [ "$OSTYPE" = *"darwin"* ]; then
    # Use homebrew direcotry as rbenv root
    export RBENV_ROOT=/usr/local/var/rbenv
    # Load rbenv
    eval "$(rbenv init -)"
    

    export VISUAL='mvim'
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi
