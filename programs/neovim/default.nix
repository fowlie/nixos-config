# Inspired by https://github.com/gvolpe/nix-config/blob/master/home/programs/neovim/default.nix
# Maybe a solution for treesitter? https://web.archive.org/web/20211025012346/https://breuer.dev/blog/nixos-home-manager-neovim

{ config, lib, pkgs, ... }:

let
  myVimPlugins = with pkgs.vimPlugins; [
    editorconfig-nvim
    gruvbox         # theme
    lightline-vim
    nerdtree
    surround
    telescope-nvim
    vim-devicons
    vim-nerdtree-syntax-highlight
    vim-fugitive
    vim-nix
    vim-startify

    # LSP & Code completion
    # Ref https://dev.to/jakewies/getting-started-with-vim-a-practical-guide-1mm5
    cmp-nvim-lsp    # autocompletion for nvim lsp
    cmp_luasnip     # snippet autocompletion source
    lspkind-nvim    # autocompletion icons
    luasnip        # autocomplete your snippets
    nvim-cmp        # autocompletion framework
    nvim-lspconfig  # lsp client utils
    nvim-treesitter # improved syntax highlighting
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
  xdg.configFile."nvim/lua/custom/lsp.lua".source = ./lsp.lua;
  xdg.configFile."nvim/lua/custom/treesitter.lua".source = ./treesitter.lua;

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
      :luafile ~/.config/nvim/lua/custom/lsp.lua
      :luafile ~/.config/nvim/lua/custom/treesitter.lua

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

      " Hybrid line numbers in normal mode, and normal line numbers in insert mode
      " Credits: https://jeffkreeftmeijer.com/vim-number
      :augroup numbertoggle
      :  autocmd!
      :  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
      :  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
      :augroup END

      " NERDTree
      nnoremap <leader>n :NERDTreeFocus<CR>
      nnoremap <C-n> :NERDTree<CR>
      nnoremap <C-t> :NERDTreeToggle<CR>
      nnoremap <C-f> :NERDTreeFind<CR>
      let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
      let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['Jenkinsfile'] = ''

      " Startify
      nnoremap <leader>s :Startify<CR>
      let g:startify_bookmarks = [
          \ {'c': '~/.config/nixpkgs/configuration.nix'},
          \ {'h': '~/.config/nixpkgs/home.nix'},
          \ {'n': '~/.config/nixpkgs/programs/neovim/default.nix'},
          \ {'l': '~/.config/nixpkgs/programs/neovim/lsp.lua'},
          \ ]

      " Telescope
      " Find files using Telescope command-line sugar.
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>

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

      " leader + hjkl to jump between windows
      nnoremap <leader>h <C-\><C-N><C-w>h
      nnoremap <leader>j <C-\><C-N><C-w>j
      nnoremap <leader>k <C-\><C-N><C-w>k
      nnoremap <leader>l <C-\><C-N><C-w>l

      " Terminal
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
