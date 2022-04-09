# Replace a Nix profile with the tools from this file:
#
# nix-env --install --remove-all -f ./packages.nix
# or use ./replace-profile.sh

let
  # nixpkgs-unstable @ 2021-12-02
  rev = "391f93a83c3a486475d60eb4a569bb6afbf306ad";
  tarball = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = "sha256:0s5f7j2akh3g0013880jfbigdaac1z76r9dv46yw6k254ba2r6nq";
  };
  pkgs = import tarball {};

  aliases = {
    colortest = builtins.readFile ./bin/colortest;
    nix-refresh-profile = builtins.readFile ./bin/nix-refresh-profile;
    nix-system-info = builtins.readFile ./bin/nix-system-info;
  };

  scripts = pkgs.symlinkJoin {
    name = "scripts";
    paths = pkgs.lib.attrValues (pkgs.lib.mapAttrs pkgs.writeScriptBin aliases);
  };
in
  with pkgs; {
    inherit
      coreutils
      direnv
      cloc
      fd
      fzf
      git
      htop
      jq
      neovim
      nix-direnv
      openssh
      python39
      ripgrep
      scripts
      shellcheck
      starship
      stow
      tmux
      tree
      wget
      zsh;
  }
