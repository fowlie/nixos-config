# Inspired by https://github.com/gvolpe/nix-config/blob/master/home/programs/neovim/default.nix
# Maybe a solution for treesitter? https://web.archive.org/web/20211025012346/https://breuer.dev/blog/nixos-home-manager-neovim

{ config, lib, pkgs, ... }:

let
  myVimPlugins = with pkgs.vimPlugins; [
    gruvbox         # theme
    lightline-vim
    nerdtree
    surround
    vim-devicons
    vim-fugitive
    vim-nix
    vim-startify

    # LSP & Code completion
    cmp-buffer      # autocompletion for buffer
    cmp-nvim-lsp    # autocompletion for nvim lsp
    cmp-vsnip
    vim-vsnip
    nvim-cmp        # autocompletion framework
    nvim-lspconfig  # lsp client
  ];
in
{
  # Uncomment below to build latest version from master branch
  #nixpkgs.overlays = [
  #  (import (builtins.fetchTarball {
  #    url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #  }))
  #];

  # Copy lua scripts
  xdg.configFile."nvim/lspconfig.lua".source = ./lspconfig.lua;
  xdg.configFile."nvim/cmp.lua".source = ./cmp.lua;

  home.packages = with pkgs; [
    go
    gopls
    rnix-lsp
  ];

  programs.neovim = {
    enable       = true;
    # Uncomment below to build latest version from master branch
    # package      = pkgs.neovim-nightly;
    plugins      = myVimPlugins;
    vimAlias     = true;
    vimdiffAlias = true;
    extraConfig = ''
      " Run lua scripts
      :luafile ~/.config/nvim/lspconfig.lua
      set completeopt=menu,menuone,noselect " needed for nvim-cmp setup
      :luafile ~/.config/nvim/cmp.lua

      " Basics
      set ignorecase                        " case insensitive
      set noswapfile                        " disable creating swap file
      set mouse=a                           " enable mouse click
      set number relativenumber             " show relative line numbers
      set nowrap                            " disable line wrapping
      set expandtab                         " converts tab to whitespace
      set autoindent                        " prefix new lines with same indent
      vnoremap < <gv                        " Indent left, then go back to select mode
      vnoremap > >gv                        " Indent right, then go back to select mode
      let mapleader=" "                     " Use space as leader key
      set splitright                        " Split window to the right
      set splitbelow                        " Split window downwards

      " NERDTree
      nnoremap <leader>e :NERDTreeToggle<CR>

      " Tab sizes and file types            " format   T spaces
      "                                     "-------------------"
      set sw=4                              " Default  | 4
      autocmd Filetype yaml setlocal sw=2   " yaml     | 2
      autocmd Filetype sh setlocal sw=2     " shell    | 2

      " TAB in normal mode will cycle buffers
      nnoremap <silent> <TAB>   :bnext<CR>
      nnoremap <silent> <S-TAB> :bprevious<CR>

      " Move selected line / block of text in visual mode
      xnoremap K :move '<-2<CR>gv'
      xnoremap J :move '>+1<CR>gv'

      " CTRL + arrow to jump between windows
      inoremap <C-h> <C-\><C-N><C-w>h
      inoremap <C-j> <C-\><C-N><C-w>j
      inoremap <C-k> <C-\><C-N><C-w>k
      inoremap <C-l> <C-\><C-N><C-w>l

      nnoremap <C-h> <C-\><C-N><C-w>h
      nnoremap <C-j> <C-\><C-N><C-w>j
      nnoremap <C-k> <C-\><C-N><C-w>k
      nnoremap <C-l> <C-\><C-N><C-w>l

      inoremap <C-h> <C-w>h
      inoremap <C-j> <C-w>j
      inoremap <C-k> <C-w>k
      inoremap <C-l> <C-w>l

      " Terminal
      tnoremap <C-h> <C-\><C-N><C-w>h
      tnoremap <C-j> <C-\><C-N><C-w>j
      tnoremap <C-k> <C-\><C-N><C-w>k
      tnoremap <C-l> <C-\><C-N><C-w>l
      tnoremap <Esc> <C-\><C-n>
      nnoremap <leader>t :split term://fish<CR>i
      autocmd TermOpen * set nonumber norelativenumber

      " Theming
      set background=dark
      colorscheme gruvbox
      " Lightline plugin config
      " Disable the -- INSERT --
      set noshowmode
     " Display current git branch
      let g:lightline = { 'colorscheme': 'wombat', 'active': {   'left': [ [ 'mode', 'paste' ],             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ] }, 'component_function': {   'gitbranch': 'FugitiveHead' }, }
    '';
  };
}
