# Variables -------------------------------------------------------------------

fpath=("$HOME/.zsh" $fpath)
export EDITOR='vim'
export VISUAL='vim'

# Prompt and theme ------------------------------------------------------------

eval "$(starship init zsh)"
eval $(dircolors ~/.dir_colors)

# Basic Aliases ---------------------------------------------------------------

alias vim='nvim'
alias c='clear'
alias ls="ls -F --color=auto --group-directories-first --ignore='.*.un~'"
alias lsa='ls -la'
alias lk='i3lock -i ~/img/bulbs.png'

alias open='xdg-open'

# Force tmux to write UTF8. It doens't seem to detect LC_ stuff properly and
# I don't want to figure out why.
alias tmux='tmux -u'

# Git -------------------------------------------------------------------------

alias gs='git show'
alias gst='git status'
alias gb='git branch'
alias gcb='git checkout -b'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdf='git diff --name-only'
alias gp='git push'
alias ga='git add'
alias gc='git commit'
alias gca='git commit --amend'
alias gcf='git commit --fixup'
alias grc='git rebase --continue'
alias grim='git rebase -i master'
alias gl='git log --oneline'
alias glv='git log --patch'
alias g-='git checkout -'

function gtl {
  cd $(git rev-parse --show-toplevel)
}

# Remove merged local branches
function grmb {
    git branch --merged | grep -v "master" | while read i; do git branch -d $i; done
}

function pr {
    git_branch=$(git rev-parse --abbrev-ref HEAD)
    origin_url=$(git remote get-url origin)
    origin_url_stripped_github=${origin_url#"git@github.com:"}
    origin_repo=${origin_url_stripped_github%".git"}

    open "https://github.com/$origin_repo/compare/$git_branch?expand=1"
}

# Git merge. (Credit: @fatho, edits by @duijf)
#
# Ensures linear history history. (Prevents Utrecht Centraal-like git graphs)
#
# Merges branches wiht a single commit using `--ff-only`. Merges branches with
# more than 1 commit using `--no-ff` to force a merge commit.
function gm {
    if [ ! $# -eq 1 ]; then
        echo "usage: gm BRANCH_NAME"
        echo "Please specify a branch to merge."
        return 1
    fi

    merge_branch="$1"
    cur_branch=$(git rev-parse --abbrev-ref HEAD)

    # Add support for git checkout like `gm -` for merging the previously
    # checked out branch.
    if [ "$merge_branch" -eq "-" ]; then
        merge_branch='@{-1}'
    fi

    if ! git merge-base --is-ancestor "$cur_branch" "$merge_branch"; then
        echo "$merge_branch is not on top of $cur_branch, rebase first"
        return 1
    fi

    commit_count=$(git rev-list --count "$merge_branch" ^"$cur_branch")

    if [ $commit_count -gt 1 ]; then
        echo "There are $commit_count commits, performing no-ff merge"
        git merge --no-ff "$merge_branch" -em "merge: <PR title> #<PR number>"
        return $?
    elif [ $commit_count -eq 1 ]; then
        echo "There is exactly one commit, performing ff merge"
        git merge --ff-only "$merge_branch"
        return $?
    else
        echo "Invalid commit count $commit_count"
        return 1
    fi
}

# SSH and SCP -----------------------------------------------------------------

function gtunnel {
  gcloud compute ssh --ssh-flag="-C2qTnN -D 7890" $1
}

function gssh {
  gcloud compute ssh $@
}

function gscp {
  gcloud compute scp $@
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

# TODO: make this handle multiple terminal windows better
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


# FZF -------------------------------------------------------------------------

export FZF_DEFAULT_COMMAND='fd --type f --hidden'

source "$HOME/.zsh/fzf-key-bindings.zsh"
source "$HOME/.zsh/fzf-completion.zsh"

# Use fd for file and directory completions with `**`
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

fzf-cd-from-home() {
  setopt localoptions pipefail 2> /dev/null
  local dir="$(eval "fd --type d . '$HOME'" | fzf --prompt="cd > " --reverse +m)"
  if [[ -z "$dir" ]]; then
    zle fzf-redraw-prompt
    return 0
  fi
  cd "$dir"
  local ret=$?
  zle fzf-redraw-prompt
  return $ret
}

fzf-git-branch-widget() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf --prompt="git checkout > " --reverse +m) &&
  printf "\n" &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
  zle fzf-redraw-prompt
}

zle     -N   fzf-git-branch-widget
bindkey '^B' fzf-git-branch-widget

zle     -N   fzf-cd-from-home
bindkey '^Y' fzf-cd-from-home

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Nix and direnv --------------------------------------------------------------

# Alias for `nix run -c`.
function nr {
    nix run -c "$@"
}

# Pure version of nr
function nrp {
    nix run --unset PATH -c $@
}

alias ns='nix-shell --command zsh'

# Nix run while passing a target. This is useful when the
# `default.nix` derivation expects an attrset with a `target`
# member.
function nrt {
    target=$1
    shift
    nix run --argstr target $target -c $@
}

function pwgen {
    tr -dc A-Za-z0-9 </dev/urandom | head -c 20 ; echo ''
}

eval "$(pyenv init -)"

eval "$(direnv hook zsh)"
