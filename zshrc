# Antigen core ----------------------------------------------------------------

export ANTIGEN=$HOME/src/checkout/antigen
source $ANTIGEN/antigen.zsh

# Antigen imports -------------------------------------------------------------

# oh-my-zsh core
antigen-use oh-my-zsh

# Antigen plugins
antigen-bundle git
antigen-bundle osx
antigen-bundle zsh-users/zsh-syntax-highlighting
antigen bundle sindresorhus/pure

# Apply configuration
antigen-apply

# Environment variables -------------------------------------------------------

export GOPATH=$HOME/projects/go
export EDITOR='vim'
export VISUAL='mvim'
export PATH="$HOME/bin:/usr/local/heroku/bin:/usr/local/bin:$GOPATH/bin:$PATH"

# Tools -----------------------------------------------------------------------

# Autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# Use homebrew direcotry as rbenv root
export RBENV_ROOT=/usr/local/var/rbenv
# Load rbenv
eval "$(rbenv init -)"

# Aliases ---------------------------------------------------------------------

alias tm='tmux -u2'
alias c='clear'
alias mkl='latexmk.pl -pdf -pvc'
alias mklc='latexmk.pl -c'
alias ls="ls -F"
alias l="ls -Ol | grep -v hidden | awk '{print $10}' | tail -n +2"
alias ec='/usr/local/Cellar/emacs/24.3/bin/emacsclient'

# Bundle aliases
alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"
