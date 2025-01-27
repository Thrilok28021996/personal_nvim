-- Keymaps for better default experience

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-- For conciseness
local opts = { noremap = true, silent = true }
local map = vim.keymap.set
-- Disable the spacebar key's default behavior in Normal and Visual modes
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- clear highlights
map('n', '<Esc>', ':noh<CR>', opts)

-- save file
map('n', '<C-s>', '<cmd> w <CR>', opts)
-- -- Comment
map('n', '<C-/>', 'gcc', { desc = 'toggle comment', remap = true })
map('v', '<C-/>', 'gc', { desc = 'toggle comment', remap = true })
-- save file without auto-formatting
-- [[ map('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts) ]]

-- quit file
map('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
map('n', 'x', '"_x', opts)

-- Resize with arrows
map('n', '<Up>', ':resize -2<CR>', opts)
map('n', '<Down>', ':resize +2<CR>', opts)
map('n', '<Left>', ':vertical resize -2<CR>', opts)
map('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
map('n', '<Tab>', ':bnext<CR>', opts)
map('n', '<S-Tab>', ':bprevious<CR>', opts)

-- window management
map('n', '<leader>v', '<C-w>v', opts) -- split window vertically
map('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
map('n', '<leader>we', '<C-w>=', opts) -- make split windows equal width & height
map('n', '<leader>wc', ':close<CR>', opts) -- close current split window

-- Navigate between splits
map('n', '<C-k>', ':wincmd k<CR>', opts)
map('n', '<C-j>', ':wincmd j<CR>', opts)
map('n', '<C-h>', ':wincmd h<CR>', opts)
map('n', '<C-l>', ':wincmd l<CR>', opts)

-- Stay in indent mode
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Keep last yanked when pasting
map('v', 'p', '"_dP', opts)

-- Search and replace
map('n', '<leader>sr', [[:%s///gc<Left><Left><Left>]], { desc = 'Prompted search and replace with confirmation' })

-- Explicitly yank to system clipboard (highlighted and entire row)
map({ 'n', 'v' }, '<leader>y', [["+y]])
map('n', '<leader>Y', [["+Y]])

-- Map Ctrl+a to select all in normal mode
map('n', '<C-a>', 'ggVG', { noremap = true, silent = true })

map('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
