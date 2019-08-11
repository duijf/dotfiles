# Zsh variables ---------------------------------------------------------------

fpath=("$HOME/.zsh" $fpath)

# Environment variables -------------------------------------------------------

export EDITOR='nvim'
export VISUAL='nvim'
#export PATH="$HOME/.cargo/bin:$HOME/bin:$HOME/.local/bin:$HOME/.yarn/bin:/usr/local/bin:/usr/local/go/bin:$PATH"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin"
export SSH_ENV="$HOME/.ssh/environment"

# Prompt ----------------------------------------------------------------------

autoload -Uz promptinit
promptinit
prompt pure

# Aliases ---------------------------------------------------------------------

alias c='clear'
alias mkl='latexmk -pdf -pvc'
alias mklc='latexmk -c'
alias ls="ls -F --color=auto --group-directories-first --ignore='.*.un~'"
alias lsa='ls -la'
alias gst='git status'
alias compress_jpg='ocnvert -strip -interlace Plane -gaussian-blur 0.05 -quality 85%'
alias lk='i3lock -i ~/wallpaper.png'
alias be='bundle exec'
alias vim='nvim'
alias gp='git push'
alias ga='git add'
alias gc='git commit'
alias gl='git log --oneline'
alias open='xdg-open'

function tunnel {
  gcloud compute ssh --ssh-flag="-C2qTnN -D 7890" $1 &
}

# Go to git toplevel dir
function gtl {
  cd $(git rev-parse --show-toplevel)
}

# History --------------------------------------------------------------------

export HISTSIZE=20000000
export HISTFILE="$HOME/.history"
export SAVEHIST=20000000
setopt hist_ignore_all_dups
setopt hist_ignore_space

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

# Bindkeys -------------------------------------------------------------------

# Edit command in editor with V
bindkey -v

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd V edit-command-line

# C-r for history search
bindkey "^R" history-incremental-search-backward

# Disable C-s as terminal freeze
stty -ixon

# Virtualenv -----------------------------------------------------------------

# A function to load a virtualenv without sourcing madness.
# Based on https://gist.github.com/datagrok/2199506.
function workon {
  source "$HOME/env/$1/bin/activate"
}

# Autocomplete the "workon" command with directories in ~/env.
if [ -d "$HOME/env" ]; then
  # compdef '_path_files -/ -g "$HOME/env/*" -W "$HOME/env/"' workon
fi

# Store the name of the current virtualenv for use in the prompt.
if [ -f $VIRTUAL_ENV ]; then
  virtualenv_prompt=""
else
  virtualenv_prompt="$(basename "$VIRTUAL_ENV") "
fi

# Notes ----------------------------------------------------------------------

# `note meeting xyz` will open a file `~/notes/$(date)-meeting-xyz.md`.
function note {
  if (( $# == 0 )) then
    echo usage: note filename supporting bare words
  fi

  filename="$HOME/notes/$(date -Idate)"
  for i do
    filename+="-$i"
  done
  filename+=".md"

  touch $filename
  vim $filename
}

export PATH="/nix/store/hbhdjn5ik3byg642d1m11k3k3s0kn3py-nix-2.2.2/bin/:$PATH"
