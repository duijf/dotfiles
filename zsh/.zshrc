# Zsh variables ---------------------------------------------------------------

fpath=("$HOME/.zsh" $fpath)

# Environment variables -------------------------------------------------------

export EDITOR='vim'
export VISUAL='vim'
export PATH="$HOME/dotfiles/bin:$PATH"

# Prompt and theme ------------------------------------------------------------

export PURE_PROMPT_SYMBOL="$"
export PURE_PROMPT_VICMD_SYMBOL="|"
export PURE_GIT_DOWN_ARROW="↓"
export PURE_GIT_UP_ARROW="↑"

autoload -Uz promptinit
promptinit
prompt pure

eval $(dircolors ~/.dir_colors)

# Basic Aliases ---------------------------------------------------------------

alias c='clear'
alias ls="ls -F --color=auto --group-directories-first --ignore='.*.un~'"
alias lsa='ls -la'
alias lk='i3lock -i ~/wallpaper.png'
alias cat='bat'

alias open='xdg-open'

# Git -------------------------------------------------------------------------

alias gst='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdf='git diff --name-only'
alias gp='git push'
alias ga='git add'
alias gc='git commit'
alias gl='git log --oneline'

function gtl {
  cd $(git rev-parse --show-toplevel)
}

# SSH and SCP -----------------------------------------------------------------

function gtunnel {
  gcloud compute ssh --ssh-flag="-C2qTnN -D 7890" $1 &
}

function gssh {
  gcloud compute ssh 
}

export SSH_ENV="$HOME/.ssh/environment"

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

# History --------------------------------------------------------------------

export HISTSIZE=20000000
export HISTFILE="$HOME/.history"
export SAVEHIST=20000000
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Bindkeys -------------------------------------------------------------------

# Use the vim keybindings 
bindkey -v

# Edit command in editor with V
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd V edit-command-line

# C-r for history search
bindkey "^R" history-incremental-search-backward

# Disable C-s as terminal freeze
stty -ixon

# Virtualenv -----------------------------------------------------------------

function workon {
  source "$HOME/env/$1/bin/activate"
}

# Store the name of the current virtualenv for use in the prompt.
if [ -f $VIRTUAL_ENV ]; then
  virtualenv_prompt=""
else
  virtualenv_prompt="$(basename "$VIRTUAL_ENV") "
fi

# FZF -------------------------------------------------------------------------

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_ALT_C_COMMAND="fd --type d . '$HOME'"

bindkey '^Y' fzf-cd-widget

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Use fd for file and directory completions with `**`
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Notes ----------------------------------------------------------------------

# `note meeting xyz` will open a file `~/notes/$(date)-meeting-xyz.md`.
function note {
  if (( $# == 0 )) then
    echo usage: note [filename supporting bare words]
  fi

  filename="$HOME/notes/$(date -Idate)"
  for i do
    filename+="-$i"
  done
  filename+=".md"

  touch $filename
  vim $filename
}
