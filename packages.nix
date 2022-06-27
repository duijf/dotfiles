# Replace a Nix profile with the tools from this file:
#
# nix-env --install --remove-all -f ./packages.nix
# or use ./bin/nix-refresh-profile

let
  pkgs = import ./nixpkgs.nix {};

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
      ffmpeg
      fzf
      git
      htop
      jless
      jq
      neovim
      nix-direnv
      nix_2_4
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
