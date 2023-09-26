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
    nix-store-path = builtins.readFile ./bin/nix-store-path;
  };

  scripts = pkgs.symlinkJoin {
    name = "scripts";
    paths = pkgs.lib.attrValues (pkgs.lib.mapAttrs pkgs.writeScriptBin aliases);
  };

  # Script on PATH instead of alias so this also works out of the
  # box with things like `git` and `psql`
  vim = pkgs.writeShellScriptBin "vim" ''
    exec nvim $@
  '';
in
  {
    inherit
      vim
      scripts;

    inherit (pkgs)
      cacert
      cloc
      coreutils
      direnv
      fd
      ffmpeg
      fzf
      git
      gh
      htop
      jless
      jq
      neovim
      nix
      openssh
      python39
      ripgrep
      shellcheck
      starship
      stow
      tmux
      tree
      rustup
      wget
      zsh;
  }
