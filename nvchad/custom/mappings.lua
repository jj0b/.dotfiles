local M = {}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },

    ["<C-A-j>"] = { ":m .+1<CR>==", "move line down" },
    ["<C-A-k>"] = { ":m .-2<CR>==", "move line up" },
  },

  i = {
    ["kj"] = { "<ESC>", "escape insert mode", opts = { nowait = true } },

    ["<C-A-j>"] = { "<ESC>:m .+1<CR>==gi", "move line down" },
    ["<C-A-k>"] = { "<ESC>:m .-2<CR>==gi", "move line up" },
  },

  v = {
    ["kj"] = { "<ESC>", "escape visual mode", opts = { nowait = true } },

    ["<C-A-j>"] = { [[:m '>+1<CR>gv==gv]], "move line down" },
    ["<C-A-k>"] = { [[:m '<-2<CR>gv==gv]], "move line up" },
  },
}

return M
