local M = {}

M.general = {
  n = {
    ["<A-j>"] = { ":m .+1<CR>==", "Move line down" },
    ["<A-k>"] = { ":m .-2<CR>==", "Move line up" },
  },

  i = {
    ["kj"] = { "<ESC>", "Escape insert mode", opts = { nowait = true } },

    ["<A-j>"] = { "<ESC>:m .+1<CR>==gi", "Move line down" },
    ["<A-k>"] = { "<ESC>:m .-2<CR>==gi", "Move line up" },
  },

  v = {
    ["kj"] = { "<ESC>", "Escape visual mode", opts = { nowait = true } },

    ["<A-j>"] = { [[:m '>+1<CR>gv==gv]], "Move line down" },
    ["<A-k>"] = { [[:m '<-2<CR>gv==gv]], "Move line up" },
  },
}

M.vim_visual_multi = {
  n = {
    ["<A-n>"] = { "<Plug>(VM-Find-Under)", "Find Under" },
  },
  x = {
    ["<A-n>"] = { "<Plug>(VM-Find-Subword-Under)", "Find Subword Under" },
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
