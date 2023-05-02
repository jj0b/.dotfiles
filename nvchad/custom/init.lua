local opt = vim.opt

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has("macunix")

-------------------------------------- options ------------------------------------------

if is_mac then
  opt.clipboard:append({ "unnamedplus" })
end

opt.ignorecase = true     -- Case insensitive searching UNLESS /C or capital in search

opt.path:append({ "**" }) -- Finding files - Search down into subfolders
opt.wildignore:append({ "*/node_modules/*" })

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Add asterisks in block comments
opt.formatoptions:append({ "r" })
