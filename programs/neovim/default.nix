# Inspired by https://github.com/gvolpe/nix-config/blob/master/home/programs/neovim/default.nix

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
  };
}
