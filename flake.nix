{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.3-1.tar.gz";
    lix-module.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, lix-module }: {
    # So `nix run .#darwin-rebuild ...` works.
    packages = nix-darwin.packages;

    darwinConfigurations.mbp = nix-darwin.lib.darwinSystem {
      modules = let
        config = {pkgs, lib, ...}: let
          # Script on PATH instead of alias so this also works out of the
          # box with things like `git` and `psql`
          vimAlias = pkgs.writeShellScriptBin "vim" ''
            exec nvim "$@"
          '';
        in {
          nixpkgs.hostPlatform = "aarch64-darwin";
          system.stateVersion = 6;

          users.users.duijf = {
            name = "duijf";
            home = "/Users/duijf";
          };

          nixpkgs.config.allowUnfreePredicate = pkg:
            builtins.elem (nixpkgs.lib.getName pkg) [ "claude-code" ];

          nix.settings = {
            extra-experimental-features = "nix-command flakes";
            sandbox = true;
          };

          environment.systemPackages = [
            pkgs.claude-code
            pkgs.cloc
            pkgs.colima
            pkgs.coreutils
            pkgs.direnv
            pkgs.exiftool
            pkgs.fd
            pkgs.fzf
            pkgs.gh
            pkgs.git
            pkgs.gitui
            pkgs.htop
            pkgs.jq
            pkgs.neovim
            pkgs.nix
            pkgs.openssh
            pkgs.pkg-config
            pkgs.ripgrep
            pkgs.rustup
            pkgs.starship
            pkgs.stow
            pkgs.tmux
            pkgs.tree
            pkgs.wget
            pkgs.zsh

            vimAlias
          ];
        };
      in [
        config
      ];
    };
  };
}
