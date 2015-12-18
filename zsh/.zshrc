# Zsh variables ---------------------------------------------------------------

fpath=("$HOME/.zsh" $fpath)

# Environment variables -------------------------------------------------------

export EDITOR='vim'
export PATH="$HOME/.rbenv/bin:$HOME/.gem/ruby/2.2.0/bin:$HOME/bin:/usr/local/bin:$PATH"
export SSH_ENV="$HOME/.ssh/environment"

# Prompt ----------------------------------------------------------------------

autoload -Uz promptinit
promptinit
prompt pure

RPROMPT="$(battery.py)"

# Aliases ---------------------------------------------------------------------

alias c='clear'
alias mkl='latexmk.pl -pdf -pvc'
alias mklc='latexmk.pl -c'
alias ls="ls -F --color=auto --ignore='.*.un~'"
alias lsa='ls -la'
alias gst='git status'

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

# NVM ------------------------------------------------------------------------

export NVM_DIR="/home/duijf/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# rbenv ----------------------------------------------------------------------

eval "$(rbenv init -)"

. /etc/profile.d/fzf.zsh
alias f='fzf'

alias be='bundle exec'
