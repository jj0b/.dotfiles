return {
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local groups = {
            "Normal",
            "NormalNC",
            "SignColumn",
            "EndOfBuffer",
            "NormalFloat",
            "FloatBorder",
          }
          for _, group in ipairs(groups) do
            vim.api.nvim_set_hl(0, group, { bg = "none" })
          end
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
}
