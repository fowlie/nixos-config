# Inspired by https://github.com/gvolpe/nix-config/blob/master/home/programs/neovim/default.nix
# Maybe a solution for treesitter? https://web.archive.org/web/20211025012346/https://breuer.dev/blog/nixos-home-manager-neovim

{ config, lib, pkgs, ... }:

let
  myVimPlugins = with pkgs.vimPlugins; [
    vim-nix
  ];
in
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.neovim = {
    enable       = true;
    package      = pkgs.neovim-nightly;
    plugins      = myVimPlugins;
    vimAlias     = true;
    vimdiffAlias = true;
    extraConfig = ''
      set mouse=a
      set relativenumber
      set expandtab
      set autoindent
    '';
  };
}
