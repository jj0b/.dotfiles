local status, context = pcall(require, "nvim-treesitter-context")
if (not status) then return end

context.setup({
  enable = true
})
