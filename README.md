# dotfiles

This is a repository containing my dotfiles. Features:

 - Nix for declarative package management.
 - Stow for dotfile management / symlinks.

No overly complicated setup with `home-manager` or `nix-darwin`. Just the
basics to set up some useable devtools.

## Bootstrap a new computer

```
# Get the repo
$ git clone https://github.com/duijf/dotfiles.git

# Initialize submodules
$ git submodule update --init

# Install the Nix package manager
$ ./bin/install-nix.sh

# Install all dependencies / tools
$ ./bin/replace-nix-profile.sh

# Get the dotfiles in place. This uses GNU stow to create
# the symlinks.
$ stow tmux zsh git ...
```

## macOS apps

 - Hammerspoon
 - Vimac
