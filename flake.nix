# Install with: `sudo nix profile install .`
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: let
    pkgs = nixpkgs.legacyPackages.aarch64-darwin;

    # Script on PATH instead of alias so this also works out of the
    # box with things like `git` and `psql`
    vimAlias = pkgs.writeShellScriptBin "vim" ''
      exec nvim $@
    '';
  in {
    packages.aarch64-darwin.default = pkgs.buildEnv {
      name = "programs";
      paths = [
        vimAlias

        pkgs.cloc
        pkgs.coreutils
        pkgs.direnv
        pkgs.fd
        pkgs.fzf
        pkgs.git
        pkgs.gh
        pkgs.htop
        pkgs.jq
        pkgs.neovim
        pkgs.nix
        pkgs.openssh
        pkgs.ripgrep
        pkgs.shellcheck
        pkgs.starship
        pkgs.stow
        pkgs.tmux
        pkgs.tree
        pkgs.rustup
        pkgs.wget
        pkgs.zsh
      ];
    };
  };
}
