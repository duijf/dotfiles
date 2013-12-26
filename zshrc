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

export EDITOR='vim'
export PATH=~/bin:/usr/local/bin:${PATH}

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

# Bundle aliases
alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

# Run on new shell ------------------------------------------------------------

# Run on new shell
have_fortune=`which fortune`
if [ -e have_fortune ]; then
    echo ""
    fortune
    echo ""
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
