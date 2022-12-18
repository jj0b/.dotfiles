require('jj0b.set')
require('jj0b.remap')
require('jj0b.packer')

vim.cmd[[colorscheme nord]]

local has = function(x)
  return vim.fn.has(x) == 1
end
local is_mac = has "macunix"

if is_mac then
  vim.opt.clipboard:append { 'unnamedplus' }
end

