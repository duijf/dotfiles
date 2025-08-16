# Nix and direnv --------------------------------------------------------------

export PATH="$HOME/dotfiles/bin:$PATH"
eval "$(direnv hook zsh)"

# Variables -------------------------------------------------------------------

fpath=("$HOME/.zsh" $fpath)
autoload -Uz compinit
compinit

export EDITOR='vim'
export VISUAL='vim'

# Prompt and theme ------------------------------------------------------------

eval "$(starship init zsh)"
export LS_COLORS="$(vivid generate $HOME/dotfiles/vivid/nord-tweaked.yml)";
export EZA_CONFIG_DIR="$HOME/.config/eza"

# Basic Aliases ---------------------------------------------------------------

alias vimdiff='nvim -d'
alias c='clear'
alias r='direnv reload'
alias ls='eza --group-directories-first'
alias lsa='eza --group-directories-first -la'
alias lst='eza --group-directories-first --tree'
alias lsta='eza --all --group-directories-first --tree'
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias tree='tree --gitignore'

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
alias gri='git rebase -i'
alias grim='git rebase -i main'
alias griom='git rebase -i origin/main'
alias gl='git log --oneline'
alias glv='git log --patch'
alias g-='git checkout -'
alias grl="git reflog --format='%C(auto)%h %<|(17)%gd %<|(33)%C(blue)%cr%C(reset) %s'"

function gtl {
    cd $(git rev-parse --show-toplevel)
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

# History --------------------------------------------------------------------

export HISTSIZE=20000000
export HISTFILE="$HOME/.history"
export SAVEHIST=20000000

setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicates first when trimming history
setopt HIST_FIND_NO_DUPS       # Don't display duplicates when searching
setopt HIST_IGNORE_ALL_DUPS    # Ignore duplicate commands in history
setopt HIST_IGNORE_SPACE       # Don't store commands prefixed with a space
setopt HIST_REDUCE_BLANKS      # Remove extra blanks from commands
setopt HIST_VERIFY             # Show command with history expansion before running
setopt INC_APPEND_HISTORY      # Immediately write to history file instead of waiting for shell exit

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

# Zsh by default has an alias for `r` = repeat last command. That can be pretty
# dangerous if used accidentally.
disable r

# FZF -------------------------------------------------------------------------

export FZF_DEFAULT_COMMAND='fd --type f --hidden'

source "$HOME/.zsh/fzf-key-bindings.zsh"
source "$HOME/.zsh/fzf-completion.zsh"

# Use fd for file and directory completions with `**`
function _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

function _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

function fzf_cd_from_home() {
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

function fzf_git_branch_widget() {
    local branches branch
    branches=$(git --no-pager branch -vv) &&
    branch=$(echo "$branches" | fzf --prompt="git checkout > " --reverse +m) &&
    printf "\n" &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
    zle fzf-redraw-prompt
}

zle     -N   fzf_git_branch_widget
bindkey '^B' fzf_git_branch_widget

zle     -N   fzf_cd_from_home
bindkey '^Y' fzf_cd_from_home

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Utils -----------------------------------------------------------------------

function pwgen {
    tr -dc A-Za-z0-9 </dev/urandom | head -c 20 ; echo ''
}
