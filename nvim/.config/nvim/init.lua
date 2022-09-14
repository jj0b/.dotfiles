require('jj0b.base')
require('jj0b.highlights')
require('jj0b.maps')
require('jj0b.plugins')

vim.cmd[[colorscheme nord]]

local has = function(x)
  return vim.fn.has(x) == 1
end
local is_mac = has "macunix"

if is_mac then
  require('jj0b.macos')
end

