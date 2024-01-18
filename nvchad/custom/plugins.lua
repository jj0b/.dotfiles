local plugins = {
	{
		"neovim/nvim-lspconfig",

		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("custom.configs.null-ls")
			end,
		},

		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"html-lsp",
				"prettier",
				"stylua",
				"typescript-language-server",
				"cssmodules-language-server",
				"svelte-language-server",
				"tailwindcss-language-server",
				"emmet-ls",
				"eslint_d",
				"python-lsp-server",
				"gopls",
				"pyright",
				"black",
			},
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				-- defaults
				"vim",
				"lua",

				-- web dev
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"yaml",
				"svelte",
				"go",

				-- low level
				"c",
				"zig",
			},
		},
	},
	{
		"windwp/nvim-ts-autotag",
	},
	{
		"kylechui/nvim-surround",
	},
	{
		"airblade/vim-gitgutter",
	},
	{
		"mg979/vim-visual-multi",
		lazy = false,
	},
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_, opts)
			require("gopher").setup(opts)
			require("core.utils").load_mappings("gopher")
		end,
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	},
}
return plugins
