# Inspired by https://github.com/gvolpe/nix-config/blob/master/home/programs/neovim/default.nix
# Maybe a solution for treesitter? https://web.archive.org/web/20211025012346/https://breuer.dev/blog/nixos-home-manager-neovim

{ config, lib, pkgs, ... }:

let
  myVimPlugins = with pkgs.vimPlugins; [
    vim-nix
    nerdtree
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
      set noswapfile
      set mouse=a
      set number relativenumber
      set nowrap
      set expandtab
      set autoindent

      " Use space as leader key
      let mapleader=" "

      " NERDTree
      nnoremap <leader>e :NERDTreeToggle<CR>

      " Window splits
      set splitright
      set splitbelow

      " Tab sizes
      set sw=4
      autocmd Filetype yaml setocal sw=2
      autocmd Filetype sh setocal sw=2
      
      " Better indenting
      vnoremap < <gv
      vnoremap > >gv

      " TAB in normal mode will cycle buffers
      nnoremap <silent> <TAB>   :bnext<CR>
      nnoremap <silent> <S-TAB> :bprevious<CR>

      " Move selected line / block of text in visual mode
      xnoremap K :move '<-2<CR>gv'
      xnoremap J :move '>+1<CR>gv'

      " Use CTRL + hjkl to scroll buffer
      nnoremap <C-h> zh
      nnoremap <C-j> <C-e>
      nnoremap <C-k> <C-y>
      nnoremap <C-l> zl

      " ALT + arrow to jump between windows
      tnoremap <A-h> <C-\><C-N><C-w>h
      tnoremap <A-j> <C-\><C-N><C-w>j
      tnoremap <A-k> <C-\><C-N><C-w>k
      tnoremap <A-l> <C-\><C-N><C-w>l

      inoremap <A-h> <C-\><C-N><C-w>h
      inoremap <A-j> <C-\><C-N><C-w>j
      inoremap <A-k> <C-\><C-N><C-w>k
      inoremap <A-l> <C-\><C-N><C-w>l

      nnoremap <A-h> <C-\><C-N><C-w>h
      nnoremap <A-j> <C-\><C-N><C-w>j
      nnoremap <A-k> <C-\><C-N><C-w>k
      nnoremap <A-l> <C-\><C-N><C-w>l

      inoremap <A-h> <C-w>h
      inoremap <A-j> <C-w>j
      inoremap <A-k> <C-w>k
      inoremap <A-l> <C-w>l
    '';
  };
}
