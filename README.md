# dotfiles

This is a repository containing all my configuration files. On some UNIX systems
these are called dotfiles, since their filenames start with a dot to make them
hidden from the general file view.

## Installation and usage

The easiest way of using these it to use GNU Stow to create symlinks to the
files that you want. You can find a tutorial [here].

## Bootstrap a new computer

```
$ git clone https://github.com/duijf/dotfiles.git
$ ./bin/bootstrap-pacman.sh
$ stow tmux zsh git
```

  [here]:http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html
