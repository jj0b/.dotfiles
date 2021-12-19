"
"       _  _  ___  _     
"      (_)(_)/ _ \| |    
"       _  _| | | | |__  
"      | || | | | | '_ \ 
"      | || | |_| | |_) |
"      | || |\___/|_.__/ 
"     _/ |/ |            
"    |__/__/             
"
"   Vim configuration of Jason Job. 

"--------------------------------------------------------------------------
" General 
"--------------------------------------------------------------------------


" number of spaces in a <Tab>
set tabstop=4 
set softtabstop=4
set expandtab

" enable autoindents
set smartindent

" number of spaces used for autoindents
set shiftwidth=4

" adds line numbers
set number

" columns used for the line number
set numberwidth=4

" show line numbers relative to current line
set relativenumber

" enable mouse support
set mouse=a

" save undo history
set undodir=~/.config/nvim/undodir
set undofile

" case insensitive search unless capital letters are used
set ignorecase
set smartcase

" open other buffers without saving
set hidden

" show invisible characters
set list
set listchars=tab:▸\ ,trail:·

" highlight pattern when searching
set incsearch

" stop highlighing search pattern after search
set nohlsearch

" delay when not typing before vim writes to swap file
set updatetime=250 

" don't make a backup before overwriting on save
set nobackup

" don't wrap text
set nowrap

" min # of lines to keep above/below cursor 
set scrolloff=8

" min # of columns to keep left/right of cursor
set sidescrolloff=8

" don't show Insert, Replace, Visual mode, etc
set noshowmode

" text encoding
set encoding=UTF-8

" make sign column use number column
set signcolumn=number

" split new windows to the right
set splitright

"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------

call plug#begin('~/.config/nvim/plugged')

" General
"Plug 'nvim-lualine/lualine.nvim'     " Vim status line
"Plug 'kyazdani42/nvim-web-devicons'  " Devicons
"Plug 'kyazdani42/nvim-tree.lua'      " File explorer
"Plug 'machakann/vim-highlightedyank' " Highlight yanked text in vim
"Plug 'akinsho/bufferline.nvim'       " Buffers

" Themes
Plug 'shaunsingh/nord.nvim'          " Nord theme

" Lsp
"Plug 'neovim/nvim-lspconfig'     
"Plug 'jose-elias-alvarez/null-ls.nvim'

" Autocompletion
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'hrsh7th/nvim-cmp'
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'onsails/lspkind-nvim'          " completion icons

" Treesitter
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Git
"Plug 'tpope/vim-fugitive'
"Plug 'lewis6991/gitsigns.nvim'

" Telescope
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'tpope/vim-surround'
"Plug 'tpope/vim-commentary'
"Plug 'sheerun/vim-polyglot'

call plug#end()

"--------------------------------------------------------------------------
" Require plugin configs
"--------------------------------------------------------------------------

" set lua namespace
" lua require('jj0b')

"--------------------------------------------------------------------------
" Colors
"--------------------------------------------------------------------------

" better colors
set termguicolors

" tell nvim that terminal background is dark
set background=dark

" set theme
colorscheme nord

"--------------------------------------------------------------------------
" Key maps
"--------------------------------------------------------------------------

let mapleader = " "

nnoremap <leader>h :wincmd h<Cr>
nnoremap <leader>j :wincmd j<Cr>
nnoremap <leader>k :wincmd k<Cr>
nnoremap <leader>l :wincmd l<Cr>
nnoremap <C-b> :Lexplore <bar> :vertical resize 30<Cr>
nnoremap <C-p> :Telescope find_files<Cr>
