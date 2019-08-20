#!/bin/bash
set -efuo pipefail

# Get the Firefox profile directory, create a `chrome/` subdir and a symlink to
# `userChrome.css`. `fd` does not support exit code signalling, so we compose
# with head and grep as suggested in `gh://sharkdp/fd/i/303`
FIREFOX_PROFILE=$(fd --type d '.*default-release$' ~/.mozilla/firefox | head -n 1 | grep ".")
mkdir -p "$FIREFOX_PROFILE/chrome"
ln -s "$HOME/dotfiles/firefox/userChrome.css" "$FIREFOX_PROFILE/chrome/userChrome.css"
