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


" Number of spaces in a <Tab>
set tabstop=4 
set softtabstop=4
set expandtab

" Enable autoindents
set smartindent

" Number of spaces used for autoindents
set shiftwidth=4

" Adds line numbers
set number

" Columns used for the line number
set numberwidth=4

" Show line numbers relative to current line
set relativenumber

" Enable mouse support
set mouse=a

" Save undo history
set undodir=~/.config/nvim/undodir
set undofile

" Case insensitive search unless capital letters are used
set ignorecase
set smartcase

" Open other buffers without saving
set hidden

" Show invisible characters
set list
set listchars=tab:▸\ ,trail:·

" Highlight pattern when searching
set incsearch

" Stop highlighing search pattern after search
set nohlsearch

" Delay when not typing before vim writes to swap file
set updatetime=250 

" Don't make a backup before overwriting on save
set nobackup
set nowritebackup

" Give more space for displaying messages
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Don't wrap text
set nowrap

" Min # of lines to keep above/below cursor 
set scrolloff=8

" Min # of columns to keep left/right of cursor
set sidescrolloff=8

" Don't show Insert, Replace, Visual mode, etc
set noshowmode

" Text encoding
set encoding=UTF-8

" Make sign column use number column
set signcolumn=number

" Split new windows to the right
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
source ~/.config/nvim/plugins/nord.vim

" Fuzzy search
source ~/.config/nvim/plugins/fzf.vim

" Lsp
"Plug 'neovim/nvim-lspconfig'     
"Plug 'jose-elias-alvarez/null-ls.nvim'

" Autocompletion
source ~/.config/nvim/plugins/coc.vim
"Plug 'hrsh7th/nvim-cmp'
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'onsails/lspkind-nvim'          " completion icons

" Treesitter
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Git
"Plug 'tpope/vim-fugitive'
"Plug 'lewis6991/gitsigns.nvim'

" Surround tools
source ~/.config/nvim/plugins/vim-surround.vim
"Plug 'tpope/vim-commentary'
"Plug 'sheerun/vim-polyglot'

" JSON comment syntax highlighting
source ~/.config/nvim/plugins/vim-jsonrc.vim

call plug#end()

"--------------------------------------------------------------------------
" Require plugin configs
"--------------------------------------------------------------------------

" Set lua namespace
" lua require('jj0b')

"--------------------------------------------------------------------------
" Colors
"--------------------------------------------------------------------------

" Better colors
set termguicolors

" Tell nvim that terminal background is dark
set background=dark

" Set theme
colorscheme nord

"--------------------------------------------------------------------------
" Key maps
"--------------------------------------------------------------------------

let mapleader = "\<space>"

"-------------
" Normal Mode
"-------------

" Open explore
nnoremap <leader>e :Lexplore 30<CR>

" Move between windows
nnoremap <leader>h :wincmd h<Cr>
nnoremap <leader>j :wincmd j<Cr>
nnoremap <leader>k :wincmd k<Cr>
nnoremap <leader>l :wincmd l<Cr>

" Resize windows
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Navigate buffers
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>

" Move text up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

"-------------
" Insert Mode
"-------------

" Quicky escape to normal mode from insert mode
imap jj <esc>

" Easy insertion of a trailing ; or , from insert mode
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

" Move text up and down
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi

"-------------
" Visual Mode
"-------------

" Stay in indent mode
vnoremap < <gv
vnoremap > >gv

" Move text up and down
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Paste replace visual selection without copying it
vnoremap p "_dP


