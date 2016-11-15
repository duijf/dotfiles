# Zsh variables ---------------------------------------------------------------

fpath=("$HOME/.zsh" $fpath)

# Environment variables -------------------------------------------------------

export EDITOR='nvim'
export VISUAL='nvim'
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export SSH_ENV="$HOME/.ssh/environment"

# Prompt ----------------------------------------------------------------------

autoload -Uz promptinit
promptinit
prompt pure

# Aliases ---------------------------------------------------------------------

alias c='clear'
alias mkl='latexmk -pdf -pvc'
alias mklc='latexmk -c'
alias ls="ls -F --color=auto --ignore='.*.un~'"
alias lsa='ls -la'
alias gst='git status'
alias compress_jpg='ocnvert -strip -interlace Plane -gaussian-blur 0.05 -quality 85%'
alias lk='i3lock -i ~/wallpapers/new-york-9.png'
alias be='bundle exec'
alias vim='nvim'
alias gp='git push'
alias ga='git add'
alias gc='git commit'
alias open='xdg-open'

# SSH agent ------------------------------------------------------------------

function start_agent {
  echo "Initialising new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo Succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent
fi

# Emacs ----------------------------------------------------------------------

if [ -n "$INSIDE_EMACS" ]; then
  chpwd() { print -P "\033AnSiTc %d" }
  print -P "\033AnSiTu %n"
  print -P "\033AnSiTc %d"
fi

# Bindkeys -------------------------------------------------------------------

# Edit command in editor with V
bindkey -v

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd V edit-command-line

# C-r for history search
bindkey "^R" history-incremental-search-backward

# Disable C-s as terminal freeze
stty -ixon

# Version managers -----------------------------------------------------------

if [ -d "$HOME/.asdf" ]; then
  . $HOME/.asdf/asdf.sh
fi

# Virtualenv -----------------------------------------------------------------

# A function to load a virtualenv without sourcing madness.
# Based on https://gist.github.com/datagrok/2199506.
function workon {
  export VIRTUAL_ENV="$HOME/env/$1"
  export PATH="$VIRTUAL_ENV/bin:$PATH"
  export RPROMPT="$1"
  unset PYTHON_HOME
  zsh
}

# Autocomplete the "workon" command with directories in ~/env.
if [ -d "$HOME/env" ]; then
  compdef '_path_files -/ -g "$HOME/env/*" -W "$HOME/env/"' workon
fi

# Store the name of the current virtualenv for use in the prompt.
if [ -f $VIRTUAL_ENV ]; then
  virtualenv_prompt=""
else
  virtualenv_prompt="$(basename "$VIRTUAL_ENV") "
fi

# added by travis gem
[ -f /home/laurens/.travis/travis.sh ] && source /home/laurens/.travis/travis.sh
