# Zsh variables ---------------------------------------------------------------

fpath=("$HOME/.zsh" $fpath)

# Environment variables -------------------------------------------------------

export EDITOR='vim'
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Prompt ----------------------------------------------------------------------

autoload -Uz promptinit
promptinit
prompt pure

# Aliases ---------------------------------------------------------------------

alias c='clear'
alias mkl='latexmk.pl -pdf -pvc'
alias mklc='latexmk.pl -c'
alias ls="ls -F --color=auto --ignore='.*.un~'"
alias lsa='ls -la'
