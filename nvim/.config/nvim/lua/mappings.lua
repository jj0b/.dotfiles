require "nvchad.mappings"

local map = vim.keymap.set

-- Use semicolon instead of colon for command mode (no shift needed)
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Quick escape from insert mode using 'jk' keypress
map("i", "jk", "<ESC>")

-- Save file
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Navigate between tmux panes
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "switch pane left" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "switch pane right" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "switch pane down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "switch pane up" })
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "switch to previous pane" })

-- Remove or override the NvChad git status mapping
vim.keymap.del("n", "<leader>gt")  -- Remove the NvChad mapping

-- Add git status under a more git-specific prefix
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })