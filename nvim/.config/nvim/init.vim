" --- General 

set termguicolors
set tabstop=4 
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set number
set numberwidth=4
set relativenumber
set signcolumn=number
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set nohlsearch
set ignorecase
set smartcase
set nowrap
set splitbelow
set splitright
set hidden
set scrolloff=999
set noshowmode
set updatetime=250 
set encoding=UTF-8
set mouse=a

let g:netrw_banner=0

" --- Plugins

call plug#begin('~/.config/nvim/plugged')

" General
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nvim-lualine/lualine.nvim'     " Vim status line
Plug 'kyazdani42/nvim-web-devicons'  " Devicons
Plug 'machakann/vim-highlightedyank' " Highlight yanked text in vim
Plug 'akinsho/bufferline.nvim'
" Lsp
Plug 'neovim/nvim-lspconfig'     
Plug 'jose-elias-alvarez/null-ls.nvim'
" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'onsails/lspkind-nvim'          " completion icons
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

call plug#end()

" --- Colors

set background=dark
colorscheme tokyonight

" --- Remaps

let mapleader = " "

nnoremap <leader>h :wincmd h<Cr>
nnoremap <leader>j :wincmd j<Cr>
nnoremap <leader>k :wincmd k<Cr>
nnoremap <leader>l :wincmd l<Cr>
nnoremap <C-b> :Lexplore <bar> :vertical resize 30<Cr>
nnoremap <C-p> :Telescope find_files<Cr>
