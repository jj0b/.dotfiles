-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

-- Function to check if we're on Apple Silicon
local function is_apple_silicon()
  local arch = vim.loop.os_uname().machine
  return arch == "arm64"  -- Apple Silicon Macs report as arm64
end

M.base46 = {
  theme = "nord",

  hl_override = is_apple_silicon() and {
    Normal = { bg = "NONE" },
    NormalNC = { bg = "NONE" },
    CursorLine = { bg = "NONE" },
    CursorColumn = { bg = "NONE" },
    SignColumn = { bg = "NONE" },
    LineNr = { bg = "NONE" },
    StatusLine = { bg = "NONE" },
    StatusLineNC = { bg = "NONE" },
    TelescopeNormal = { bg = "NONE" },
    TelescopeBorder = { bg = "NONE" },
    NvimTreeNormal = { bg = "NONE" },
    NvimTreeNormalNC = { bg = "NONE" },
    NvimTreeEndOfBuffer = { bg = "NONE" },
  } or {},  -- Empty table for non-Apple Silicon machines
  
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

return M
