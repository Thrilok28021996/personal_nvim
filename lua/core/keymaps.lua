-- Keymaps for better default experience

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-- For conciseness
local map = vim.keymap.set

-- Disable the spacebar key's default behavior in Normal and Visual modes
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- clear highlights
map('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true, desc = 'Clear highlights' })

-- save file
map('n', '<C-s>', '<cmd> w <CR>', { noremap = true, silent = true, desc = 'Save the File' })
-- -- Comment
map('n', '<C-/>', 'gcc', { desc = 'toggle comment', remap = true, desc = 'Comment the lines' })
map('v', '<C-/>', 'gc', { desc = 'toggle comment', remap = true, desc = 'Comment the lines' })
-- save file without auto-formatting
-- [[ map('n', '<leader>sn', '<cmd>noautocmd w <CR>', {noremap=true,silent=true}) ]]

-- quit file
map('n', '<C-q>', '<cmd> q <CR>', { noremap = true, silent = true, desc = 'Quit the IDE' })

-- delete single character without copying into register
map('n', 'x', '"_x', { noremap = true, silent = true, desc = 'Delete single character' })

-- Resize with arrows
-- map('n', '<Up>', ':resize -2<CR>', { noremap = true, silent = true, desc = 'Save the File' })
-- map('n', '<Down>', ':resize +2<CR>', { noremap = true, silent = true, desc = 'Save the File' })
-- map('n', '<Left>', ':vertical resize -2<CR>', { noremap = true, silent = true, desc = 'Save the File' })
-- map('n', '<Right>', ':vertical resize +2<CR>', { noremap = true, silent = true, desc = 'Save the File' })

-- Navigate buffers
map('n', '<Tab>', '<CMD>bnext<CR>', { noremap = true, silent = true, desc = 'Go to next Tab' })
map('n', '<S-Tab>', '<CMD>bprevious<CR>', { noremap = true, silent = true, desc = 'Go to previous tab' })
map('n', '<leader>tx', '<CMD>bdel<CR>', { remap = true, silent = true, desc = 'Close the current buffer' })

-- window management
map('n', '<leader>v', '<C-w>v', { noremap = true, silent = true, desc = 'split window vertically' })
map('n', '<leader>h', '<C-w>s', { noremap = true, silent = true, desc = 'split window horizontally' })
map('n', '<leader>we', '<C-w>=', { noremap = true, silent = true, desc = 'make split windows equal width & height' })
map('n', '<leader>wc', '<CMD>close<CR>', { noremap = true, silent = true, desc = 'close current split window' })

-- Navigate between splits
map('n', '<C-k>', '<CMD>wincmd k<CR>', { noremap = true, silent = true, desc = 'Go to UP Window' })
map('n', '<C-j>', '<CMD>wincmd j<CR>', { noremap = true, silent = true, desc = 'GO to Down Window' })
map('n', '<C-h>', '<CMD>wincmd h<CR>', { noremap = true, silent = true, desc = 'Go to Left Window' })
map('n', '<C-l>', '<CMD>wincmd l<CR>', { noremap = true, silent = true, desc = 'Go to Right Window' })

-- Stay in indent mode
map('v', '<', '<gv', { noremap = true, silent = true, desc = 'Left Indent' })
map('v', '>', '>gv', { noremap = true, silent = true, desc = 'Right Indent' })

-- Keep last yanked when pasting
map('v', 'p', '"_dP', { noremap = true, silent = true, desc = 'Paste the yanked content' })

-- Search and replace
map('n', '<leader>sr', [[:%s///gc<Left><Left><Left>]], { desc = 'Prompted search and replace with confirmation' })

-- Explicitly yank to system clipboard (highlighted and entire row)
map({ 'n', 'v' }, '<leader>y', [["+y]])
map('n', '<leader>Y', [["+Y]])

-- Map Ctrl+a to select all in normal mode
map('n', '<C-a>', 'ggVG', { noremap = true, silent = true, desc = 'Select the All the content of the file' })
-- Lazy
map('n', '<leader>l', '<CMD>Lazy<CR>', { desc = 'Open Lazy' })
-- File Explorer
map('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- Fuzzy Finding
map('n', '<leader>ff', function() require('mini.pick').builtin.files() end, { desc = 'Find Files' })
map('n', '<leader>fw', function() require('mini.pick').builtin.grep_live() end, { desc = 'Find the word' })
map('n', '<leader>fb', function() require('mini.pick').builtin.buffers() end, { desc = 'Find the buffers' })

-- Terminal
map('n', '<C-t>', '<CMD>terminal<CR>', { desc = 'Open terminal' })
map('n', '<leader>th', '<CMD>split | terminal<CR>', { desc = 'Open terminal horizontally' })
map('n', '<leader>tv', '<CMD>vsplit | terminal<CR>', { desc = 'Open terminal vertically' })
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move to left window from terminal' })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Move to down window from terminal' })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Move to up window from terminal' })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move to right window from terminal' })
