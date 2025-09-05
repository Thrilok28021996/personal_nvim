-- Keymaps for better default experience

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-- For conciseness
local map = vim.keymap.set

-- Disable the spacebar key's default behavior in Normal and Visual modes
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true, desc = 'Disabled (leader key)' })

-- clear highlights
map('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true, desc = 'Clear highlights' })

-- save file
map('n', '<C-s>', '<cmd> w <CR>', { noremap = true, silent = true, desc = 'Save the File' })
-- Comment
map('n', '<C-/>', 'gcc', { desc = 'Comment the lines', remap = true })
map('v', '<C-/>', 'gc', { desc = 'Comment the lines', remap = true })

-- quit file
map('n', '<C-q>', '<cmd> q <CR>', { noremap = true, silent = true, desc = 'Quit the IDE' })

-- delete single character without copying into register
map('n', 'x', '"_x', { noremap = true, silent = true, desc = 'Delete single character' })

-- Navigate buffers
map('n', '<Tab>', '<CMD>bnext<CR>', { noremap = true, silent = true, desc = 'Go to next Tab' })
map('n', '<S-Tab>', '<CMD>bprevious<CR>', { noremap = true, silent = true, desc = 'Go to previous tab' })
map('n', '<leader>tx', '<CMD>bdel<CR>', { remap = true, silent = true, desc = 'Close the current buffer' })

-- Built-in buffer navigation (pure built-in commands)
map('n', '<leader>1', '<CMD>1buffer<CR>', { desc = 'Go to buffer 1' })
map('n', '<leader>2', '<CMD>2buffer<CR>', { desc = 'Go to buffer 2' })
map('n', '<leader>3', '<CMD>3buffer<CR>', { desc = 'Go to buffer 3' })
map('n', '<leader>4', '<CMD>4buffer<CR>', { desc = 'Go to buffer 4' })
map('n', '<leader>5', '<CMD>5buffer<CR>', { desc = 'Go to buffer 5' })
map('n', '<leader>6', '<CMD>6buffer<CR>', { desc = 'Go to buffer 6' })
map('n', '<leader>7', '<CMD>7buffer<CR>', { desc = 'Go to buffer 7' })
map('n', '<leader>8', '<CMD>8buffer<CR>', { desc = 'Go to buffer 8' })
map('n', '<leader>9', '<CMD>9buffer<CR>', { desc = 'Go to buffer 9' })

-- Built-in buffer management (use native commands directly)
map('n', '<leader>bb', ':<C-u>buffer ', { desc = 'Go to buffer (type name/number)' })
map('n', '<leader>bd', '<CMD>bdelete<CR>', { desc = 'Delete current buffer' })
map('n', '<leader>bo', '<CMD>%bdelete|edit#<CR>', { desc = 'Close all other buffers' })
map('n', '<leader>bn', '<CMD>bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bp', '<CMD>bprevious<CR>', { desc = 'Previous buffer' })

-- NOTE: Terminal mapping consolidated below at line 338

-- Window management (use built-in <C-w> commands directly - no duplicates needed)
-- Use <C-w>v for vertical split, <C-w>s for horizontal split natively
map('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' })
map('n', '<leader>wh', '<C-w>s', { desc = 'Split window horizontally' })

-- Additional window management keymaps for convenience
map('n', '<leader>wc', '<C-w>c', { desc = 'Close window' })
map('n', '<leader>wo', '<C-w>o', { desc = 'Close all other windows' })
map('n', '<leader>we', '<C-w>=', { desc = 'Make windows equal size' })
map('n', '<leader>wr', '<C-w>r', { desc = 'Rotate windows' })
map('n', '<leader>wx', '<C-w>x', { desc = 'Exchange windows' })

-- Window operations - Learn native <C-w> commands for muscle memory
-- Use <C-w>+/- for height, <C-w></>  for width, <C-w>H/J/K/L for movement natively

-- Only essential window navigation shortcuts (others use native <C-w> commands)
map('n', '<C-k>', '<C-w>k', { desc = 'Go to UP Window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to Down Window' })
map('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window' })

-- Stay in indent mode
map('v', '<', '<gv', { noremap = true, silent = true, desc = 'Left Indent' })
map('v', '>', '>gv', { noremap = true, silent = true, desc = 'Right Indent' })

-- NOTE: Surround functionality removed - use native vim commands
-- Use visual mode + c + type surrounding characters manually
-- Example: v + select text + c + "text" or (text) etc.
-- This teaches proper vim muscle memory without complex custom functions

-- NOTE: Autopairs functionality removed - use native typing
-- Type opening/closing characters manually - this is pure vim way
-- Learn to type () [] {} "" '' naturally without auto-insertion
-- This teaches proper vim muscle memory and reduces complexity

-- Built-in line movement (direct vim commands)
map('n', '<M-k>', ':<C-u>move .-2<CR>==', { desc = 'Move line up' })
map('n', '<M-j>', ':<C-u>move .+1<CR>==', { desc = 'Move line down' })

-- Visual mode line movement
map('v', '<M-k>', ":move '<-2<CR>gv=gv", { desc = 'Move selection up' })
map('v', '<M-j>', ":move '>+1<CR>gv=gv", { desc = 'Move selection down' })

-- NOTE: Use native gu/gU/g~ operators directly - no custom mappings needed
-- Native usage: guiw (lowercase word), gUiw (uppercase word), g~iw (toggle case)
-- Visual: gu (lowercase), gU (uppercase), g~ (toggle case)

-- NOTE: Alignment removed - use direct vim commands
-- Use :'<,'>left, :'<,'>center, :'<,'>right directly when needed
-- This teaches native vim text formatting commands

-- NOTE: Search/replace removed - use native vim commands directly
-- Use :%s/old/new/gc for global replace with confirmation
-- Use * to search word under cursor, then :%s//new/gc to replace
-- This teaches proper vim search/replace workflow

-- NOTE: Redundant join mappings - use native J and gJ directly
-- Native J joins with spaces, gJ joins without spaces - no custom mapping needed

-- NOTE: Multi-cursor removed - use native vim workflow
-- Use * to search word, n/N to navigate, then use macros (qq...q @q)
-- This teaches proper vim macro workflow without custom functions

-- Enhanced macro workflow
map('n', 'Q', '@q', { desc = 'Replay macro q' })
map('v', 'Q', ':normal @q<CR>', { desc = 'Apply macro q to selection' })

-- Keep last yanked when pasting
map('v', 'p', '"_dP', { noremap = true, silent = true, desc = 'Paste the yanked content' })

-- Explicitly yank to system clipboard
map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = 'Yank line to system clipboard' })

-- Additional useful keymaps
map('n', '<C-u>', '<C-u>zz', { desc = 'Page up (centered)' })

-- Center cursor after search navigation
map('n', 'n', 'nzz', { desc = 'Next search result (centered)' })
map('n', 'N', 'Nzz', { desc = 'Previous search result (centered)' })

-- Better undo breakpoints in insert mode
map('i', ',', ',<C-g>u', { desc = 'Undo breakpoint at comma' })
map('i', '.', '.<C-g>u', { desc = 'Undo breakpoint at period' })
map('i', ';', ';<C-g>u', { desc = 'Undo breakpoint at semicolon' })

-- Built-in essential mappings
map('n', '<C-a>', 'ggVG', { desc = 'Select all content' })
map('n', '<leader>lz', '<CMD>Lazy<CR>', { desc = 'Open Lazy (plugin manager)' })

-- Git operations
map('n', '<leader>gg', '<CMD>LazyGit<CR>', { desc = 'Open LazyGit' })

-- Fuzzy Finding
map('n', '<leader>ff', '<CMD>FzfLua files<CR>', { desc = 'Find Files' })
map('n', '<leader>fw', '<CMD>FzfLua live_grep<CR>', { desc = 'Find the word' })
map('n', '<leader>fb', '<CMD>FzfLua buffers<CR>', { desc = 'Find the buffers' })

-- Terminal keymaps (using built-in terminal)
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<leader>et', '<CMD>split | terminal<CR>', { desc = 'Open terminal in split' })
map('n', '<leader>eT', '<CMD>vsplit | terminal<CR>', { desc = 'Open terminal in vertical split' })

-- File explorer (using oil.nvim)
map('n', '-', '<CMD>Oil<CR>', { desc = 'Open file explorer' })
-- map('n', '<leader>fE', '<CMD>vsplit | Oil<CR>', { desc = 'Open file explorer in vertical split' })

-- Org-Mode keymaps
map('n', '<leader>oc', '<cmd>lua require("orgmode").action("capture.prompt")<CR>', { desc = 'Org Capture' })
map('n', '<leader>ot', '<cmd>lua require("orgmode").action("capture.refile", {key = "t"})<CR>', { desc = 'Capture Task' })
map('n', '<leader>on', '<cmd>lua require("orgmode").action("capture.refile", {key = "n"})<CR>', { desc = 'Capture Note' })
map('n', '<leader>oa', '<cmd>lua require("orgmode").action("agenda.prompt")<CR>', { desc = 'Org Agenda' })
map('n', '<leader>ol', '<cmd>lua require("orgmode").action("agenda.agenda")<CR>', { desc = 'Agenda List' })

-- Org-Roam Integration
map('n', '<leader>rf', '<cmd>lua require("org-roam").capture_node()<CR>', { desc = 'Create Roam Note' })
map('n', '<leader>rn', '<cmd>lua require("org-roam").find_node()<CR>', { desc = 'Find Roam Node' })

-- Markdown/Obsidian keymaps
map('n', '<leader>mn', '<cmd>ObsidianNew<CR>', { desc = 'New Obsidian Note' })
map('n', '<leader>mf', '<cmd>ObsidianQuickSwitch<CR>', { desc = 'Quick Switch Notes' })
map('n', '<leader>ms', '<cmd>ObsidianSearch<CR>', { desc = 'Search Obsidian' })
map('n', '<leader>md', '<cmd>ObsidianToday<CR>', { desc = "Today's Daily Note" })
map('v', '<leader>ml', '<cmd>ObsidianLink<CR>', { desc = 'Link Selection' })

-- Checkbox toggle
map('n', '<leader>x', '<cmd>lua require("obsidian").util.toggle_checkbox()<CR>', { desc = 'Toggle Checkbox' })
