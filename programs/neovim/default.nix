# Inspired by https://github.com/gvolpe/nix-config/blob/master/home/programs/neovim/default.nix

{ config, lib, pkgs, ... }:

let
  myVimPlugins = with pkgs.vimPlugins; [
    vim-nix
  ];
in
{
  programs.neovim = {
    enable       = true;
    plugins      = myVimPlugins;
    vimAlias     = true;
    vimdiffAlias = true;
  };
}
