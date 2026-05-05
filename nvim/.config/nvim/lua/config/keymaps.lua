-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Insert mode: home-row escape (common alternative to reaching for Esc)
do
  local o = { silent = true, desc = "Exit insert mode" }
  vim.keymap.set("i", "jk", "<Esc>", o)
  vim.keymap.set("i", "kj", "<Esc>", o)
end

-- vim-tmux-navigator: same keys as LazyVim window nav, but must call TmuxNavigate* so tmux gets handoff.
-- Schedule so these win over LazyVim’s VeryLazy <C-w> maps (del-only was wiping maps if it ran after the plugin).
-- Normal mode only — keep insert <C-k> for LSP signature help.
vim.schedule(function()
  local o = { silent = true, noremap = true }
  vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", o)
  vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", o)
  vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", o)
  vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", o)
  vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", o)
end)
