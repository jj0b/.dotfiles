local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'shaunsingh/nord.nvim' -- Nord theme
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'neovim/nvim-lspconfig' -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client
  use 'williamboman/mason.nvim' -- LSP support to get Tailwind CSS language server to work
  use 'williamboman/mason-lspconfig.nvim' -- LSP support to get Tailwind CSS language server to work
  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use {
    'nvim-treesitter/nvim-treesitter', -- Syntax highlighting
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'kyazdani42/nvim-web-devicons' -- Lua fork of vim-web-devicons for neovim
  use 'nvim-telescope/telescope.nvim' -- A highly extendable fuzzy finder over lists
  use 'nvim-telescope/telescope-file-browser.nvim' -- File Browser extension for telescope.nvim
  use 'windwp/nvim-autopairs' -- Autopairs
  use 'windwp/nvim-ts-autotag' -- Use treesitter to auto close and auto rename html tag
  use 'norcalli/nvim-colorizer.lua' -- A high-performance color highlighter
  use 'folke/zen-mode.nvim' -- Distraction-free mode
  use({
    "iamcco/markdown-preview.nvim", -- Markdown live preview
    run = function() vim.fn["mkdp#util#install"]() end, 
  })
  use 'akinsho/nvim-bufferline.lua' -- A snazzy bufferline
  use 'lewis6991/gitsigns.nvim' -- git integration for buffers
  use 'dinhhuy258/git.nvim' -- For git blame & browse
  use 'L3MON4D3/LuaSnip' -- Snippet Engine for Neovim written in Lua
  use 'folke/lsp-colors.nvim' -- Automatically creates missing LSP diagnostics highlight groups for color schemes that don't yet support the Neovim 0.5 builtin lsp client
  use "kylechui/nvim-surround" -- Lua port of vim-surround
  use 'romgrk/nvim-treesitter-context'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
