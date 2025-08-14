# dotfiles

This is a repository containing my dotfiles. Features:

 - Nix for declarative package management.
 - Stow for dotfile management / symlinks.

## Bootstrap a new computer

Install Nix, then:

```
$ git clone https://github.com/duijf/dotfiles.git

$ cd dotfiles
$ ./bin/rebuild.sh

# Get the dotfiles in place. This uses GNU stow to create
# the symlinks.
$ stow tmux zsh git ...
```
