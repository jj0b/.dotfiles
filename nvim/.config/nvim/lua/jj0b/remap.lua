local keymap = vim.keymap

-- vim.g.mapleader = " "

-- Remap Esc to kj
keymap.set('i', 'kj', '<Esc>')
keymap.set('v', 'kj', '<Esc>')

-- Clear search results with Return
keymap.set('n', '<CR>', ':nohlsearch<CR><CR>', { silent=true })

keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
-- keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Browse buffers:
keymap.set('n', 'gb', ':ls<CR>:b<Space>')

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Tabs 
keymap.set('n', 'tt', ':tabnew<CR>')
keymap.set('n', 'tc', ':tabclose<CR>')
keymap.set('n', 'tn', ':tabnext<CR>')
keymap.set('n', 'tp', ':tabprevious<CR>')
keymap.set('n', 'tl', ':tablast<CR>')
keymap.set('n', 'tf', ':tabfirst<CR>')
keymap.set('n', 'te', ':tabedit')

-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')

-- Move between windows
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')

-- Move text up and down
keymap.set('n', '<A-j>', ':m .+1<CR>==')
keymap.set('n', '<A-k>', ':m .-2<CR>==')
keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
keymap.set('v', '<A-j>', [[:m '>+1<CR>gv=gv]])
keymap.set('v', '<A-k>', [[:m '<-2<CR>gv=gv]])

