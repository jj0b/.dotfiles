local M = {}

M.general = {
	n = {
		["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "Window left" },
		["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "Window right" },
		["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "Window down" },
		["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "Window up" },

		["<C-A-j>"] = { ":m .+1<CR>==", "Move line down" },
		["<C-A-k>"] = { ":m .-2<CR>==", "Move line up" },
	},

	i = {
		["kj"] = { "<ESC>", "Escape insert mode", opts = { nowait = true } },

		["<C-A-j>"] = { "<ESC>:m .+1<CR>==gi", "Move line down" },
		["<C-A-k>"] = { "<ESC>:m .-2<CR>==gi", "Move line up" },
	},

	v = {
		["kj"] = { "<ESC>", "Escape visual mode", opts = { nowait = true } },

		["<C-A-j>"] = { [[:m '>+1<CR>gv==gv]], "Move line down" },
		["<C-A-k>"] = { [[:m '<-2<CR>gv==gv]], "Move line up" },
	},
}

M.gopher = {
	plugin = true,
	n = {
		["<leader>gsj"] = {
			"<cmd> GoTagAdd json <CR>",
			"Add json struct tags",
		},
		["<leader>gsy"] = {
			"<cmd> GoTagAdd yaml <CR>",
			"Add yaml struct tags",
		},
	},
}

return M
