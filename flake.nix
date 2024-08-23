# Usage:
#
#     sudo nix profile install .
#
# Upgrade later:
#
#     nix flake lock --update-input nixpkgs
#     sudo nix profile upgrade '.*'
#
# The `.` and `'.*'` are different. The `.` is a "reference to a thing to
# install" [^]. The `'.*'` means "upgrade all packages in my profile."
# (And ideally, this flake is the only thing in your profile.)
#
# [^] In this example `.` means the current directory. You can also do
# `nixpkgs#terraform` or `github:user/repo`.

{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }: let
    pkgs = nixpkgs.legacyPackages.aarch64-darwin;

    # Script on PATH instead of alias so this also works out of the
    # box with things like `git` and `psql`
    vimAlias = pkgs.writeShellScriptBin "vim" ''
      exec nvim "$@"
    '';
  in {
    packages.aarch64-darwin.default = pkgs.buildEnv {
      name = "programs";
      paths = [
        vimAlias

        # Important: if this isn't present, then Nix will no
        # longer be able to load certificates, meaning downloads
        # will fail.
        pkgs.cacert

        pkgs.cloc
        pkgs.coreutils
        pkgs.direnv
        pkgs.exiftool
        pkgs.fd
        pkgs.fzf
        pkgs.git
        pkgs.gh
        pkgs.htop
        pkgs.jq
        pkgs.neovim
        pkgs.nix
        pkgs.nushell
        pkgs.openssh
        pkgs.pkg-config
        pkgs.postgresql_14
        pkgs.ripgrep
        pkgs.shellcheck
        pkgs.starship
        pkgs.stow
        pkgs.tmux
        pkgs.rustup
        pkgs.tree
        pkgs.wget
        pkgs.zsh
      ];
    };
  };
}
