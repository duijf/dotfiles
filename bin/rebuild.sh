#!/usr/bin/env bash
set -eufo pipefail
sudo nix run .#darwin-rebuild -- switch --flake flake.nix
