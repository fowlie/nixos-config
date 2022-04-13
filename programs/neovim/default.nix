# Inspired by https://github.com/gvolpe/nix-config/blob/master/home/programs/neovim/default.nix
# Maybe a solution for treesitter? https://web.archive.org/web/20211025012346/https://breuer.dev/blog/nixos-home-manager-neovim

{ config, lib, pkgs, ... }:

let
  myVimPlugins = with pkgs.vimPlugins; [
    editorconfig-nvim
    nerdtree
    vim-devicons                    # icons for NERDTree
    nvim-web-devicons               # icons for bufferline
    surround
    telescope-nvim                  # Fuzzy find & grep
    vim-nerdtree-syntax-highlight
    vim-fugitive                    # :Git <subcommand>
    vim-nix
    vim-signify
    vim-startify
    vim-test
    wilder-nvim                     # A more adventurous wildmenu
    #lightspeed-nvim                 # More modern easy motion plugin

    # Ranger integration
    #bclose-vim
    #ranger-vim

    # Theme
    gruvbox
    #dracula-vim

    # Lightline
    lightline-vim
    lightline-gruvbox-vim

    # LSP & Code completion
    # Ref https://dev.to/jakewies/getting-started-with-vim-a-practical-guide-1mm5
    cmp-nvim-lsp    # autocompletion for nvim lsp
    cmp_luasnip     # snippet autocompletion source
    lsp-colors-nvim # create missing LSP diagnostics highlight groups for color schemes that don't yet support the Neovim 0.5 builtin lsp client
    lspkind-nvim    # autocompletion icons
    luasnip         # autocomplete your snippets
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
  xdg.configFile."nvim/lua/custom/lightline.lua".source = ./lightline.lua;

  home.packages = with pkgs; [
    go
    gopls
    rnix-lsp
  ];

  programs.neovim = {
    enable       = true;
    # Uncomment below to build latest version from master branch
    #package      = pkgs.neovim-nightly;
    plugins      = myVimPlugins;
    extraConfig = ''
      " Run lua scripts
      :luafile ~/.config/nvim/lua/custom/lsp.lua
      :luafile ~/.config/nvim/lua/custom/treesitter.lua
      :luafile ~/.config/nvim/lua/custom/lightline.lua

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


      " Keybindings
      nnoremap <leader>w :w<CR>
      nnoremap <leader>q :q<CR>
      nnoremap <leader>c :bdelete<CR>
      nnoremap <c-l> :nohlsearch<CR>

      " Vim-test
      nmap <silent> <leader>tn :TestNearest<CR>
      nmap <silent> <leader>tf :TestFile<CR>
      nmap <silent> <leader>ts :TestSuite<CR>
      nmap <silent> <leader>tl :TestLast<CR>
      nmap <silent> <leader>tv :TestVisit<CR>


      " Run gofmt on save
      autocmd BufWritePre *.go lua vim.lsp.buf.formatting()


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
          \ {'t': '~/today'},
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
      xnoremap J :m'>+<CR>gv=gv
      xnoremap K :m-2<CR>gv=gv

      " leader + mnei to jump between windows
      nnoremap <A-m> <Esc><C-w>h
      nnoremap <A-n> <Esc><C-w>j
      nnoremap <A-e> <Esc><C-w>k
      nnoremap <A-i> <Esc><C-w>l

      " Terminal
      tnoremap <Esc> <C-\><C-n>
      nnoremap <leader>t :split term://fish<CR>i
      autocmd TermOpen * set nonumber norelativenumber

      " Theming
      set background=dark
      colorscheme gruvbox

      " Additional lightline config (migrate to lightline.lua in future)
      " Disable the -- INSERT --
      set noshowmode
    '';
  };
}
