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

# Edit commands in external editor -------------------------------------------

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd V edit-command-line

# Version managers -----------------------------------------------------------

. $HOME/.asdf/asdf.sh
