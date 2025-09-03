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
<<<<<<< HEAD
-- Simple built-in comment functionality using vim.api
local function toggle_comment()
  local line = vim.api.nvim_get_current_line()
  local comment_string = vim.bo.commentstring
  if comment_string == '' then comment_string = '# %s' end
  
  local comment_char = comment_string:match('^(.-)%%s'):gsub('%s*$', '')
  if comment_char == '' then comment_char = '#' end
  
  if line:match('^%s*' .. vim.pesc(comment_char)) then
    -- Uncomment
    local new_line = line:gsub('^(%s*)' .. vim.pesc(comment_char) .. '%s?', '%1')
    vim.api.nvim_set_current_line(new_line)
  else
    -- Comment
    local indent = line:match('^%s*')
    local new_line = indent .. comment_char .. ' ' .. line:sub(#indent + 1)
    vim.api.nvim_set_current_line(new_line)
  end
end

map('n', 'gcc', toggle_comment, { desc = 'Toggle comment line' })
map('n', '<C-/>', toggle_comment, { desc = 'Toggle comment line' })

-- Visual mode comment toggle
map('v', '<C-/>', function()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  for i = start_line, end_line do
    vim.api.nvim_win_set_cursor(0, {i, 0})
    toggle_comment()
  end
end, { desc = 'Toggle comment (visual)' })
=======
-- -- Comment
map('n', '<C-/>', 'gcc', { desc = 'Comment the lines', remap = true })
map('v', '<C-/>', 'gc', { desc = 'Comment the lines', remap = true })
-- save file without auto-formatting
-- [[ map('n', '<leader>sn', '<cmd>noautocmd w <CR>', {noremap=true,silent=true}) ]]
>>>>>>> refs/remotes/origin/main

-- quit file
map('n', '<C-q>', '<cmd> q <CR>', { noremap = true, silent = true, desc = 'Quit the IDE' })

-- delete single character without copying into register
map('n', 'x', '"_x', { noremap = true, silent = true, desc = 'Delete single character' })


-- Navigate buffers
map('n', '<Tab>', '<CMD>bnext<CR>', { noremap = true, silent = true, desc = 'Go to next Tab' })
map('n', '<S-Tab>', '<CMD>bprevious<CR>', { noremap = true, silent = true, desc = 'Go to previous tab' })
<<<<<<< HEAD
-- Note: Buffer management keymaps moved to <leader>b* prefix below (with legacy t* shortcuts)
=======
map('n', '<leader>tx', '<CMD>bdel<CR>', { remap = true, silent = true, desc = 'Close the current buffer' })
-- map('n', '<leader>1', "<cmd>lua require('bufferline').go_to_buffer(1)<CR>", opts)
-- map('n', '<leader>2', "<cmd>lua require('bufferline').go_to_buffer(2)<CR>", opts)
-- map('n', '<leader>3', "<cmd>lua require('bufferline').go_to_buffer(3)<CR>", opts)
-- map('n', '<leader>4', "<cmd>lua require('bufferline').go_to_buffer(4)<CR>", opts)
-- keymap('n', '<leader>5', "<cmd>lua require('bufferline').go_to_buffer(5)<CR>", opts)
-- map('n', '<leader>6', "<cmd>lua require('bufferline').go_to_buffer(6)<CR>", opts)
-- map('n', '<leader>7', "<cmd>lua require('bufferline').go_to_buffer(7)<CR>", opts)
-- map('n', '<leader>8', "<cmd>lua require('bufferline').go_to_buffer(8)<CR>", opts)
-- map('n', '<leader>9', "<cmd>lua require('bufferline').go_to_buffer(9)<CR>", opts)
>>>>>>> refs/remotes/origin/main

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

-- NOTE: Duplicate search and replace mapping - removed
-- Use <leader>S for search/replace functionality above

-- Explicitly yank to system clipboard (highlighted and entire row)
map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = 'Yank line to system clipboard' })

-- Additional useful keymaps
-- Note: <C-d> conflicts with multi-cursor mapping above, so using different keys
map('n', '<C-u>', '<C-u>zz', { desc = 'Page up (centered)' })
-- Removed <C-d> page down to avoid conflict with multi-cursor workflow

<<<<<<< HEAD
-- Center cursor after search navigation
map('n', 'n', 'nzz', { desc = 'Next search result (centered)' })
map('n', 'N', 'Nzz', { desc = 'Previous search result (centered)' })

-- NOTE: Removed custom J mapping - use native J command directly
-- Native J joins lines perfectly fine without cursor position complexity

-- NOTE: Visual J/K conflicts with native commands - use <M-j>/<M-k> instead
-- Native J joins lines in visual mode, K looks up words - don't override

-- Better undo breakpoints in insert mode
map('i', ',', ',<C-g>u', { desc = 'Undo breakpoint at comma' })
map('i', '.', '.<C-g>u', { desc = 'Undo breakpoint at period' })
map('i', ';', ';<C-g>u', { desc = 'Undo breakpoint at semicolon' })

-- Built-in essential mappings
map('n', '<C-a>', 'ggVG', { desc = 'Select all content' })
map('n', '<leader>lz', '<CMD>Lazy<CR>', { desc = 'Open Lazy (plugin manager)' })
map('n', '-', '<CMD>Oil<CR>', { desc = 'Open directory explorer (oil.nvim)' })
-- NOTE: Oil.nvim allows editing filesystem like a buffer - you can create/delete/rename files

-- NOTE: Custom keymap viewer removed - use built-in :map command
-- Use :map, :nmap, :vmap, :imap to view keymaps natively

-- Built-in file operations (direct vim commands)
map('n', '<leader>ff', ':<C-u>find ', { desc = 'Find files by name (builtin)' })

-- NOTE: File explorer available via - key (Oil.nvim)
-- Alternative: For builtin netrw (if you prefer), enable netrw and use: <CMD>Explore<CR>
map('n', '<leader>fb', '<CMD>buffers<CR>', { desc = 'List all buffers (builtin)' })
map('n', '<leader>fr', '<CMD>browse oldfiles<CR>', { desc = 'Recent files (builtin)' })

-- Content searching (direct vim commands)
map('n', '<leader>fw', ':<C-u>grep -r "" .<Left><Left>', { desc = 'Grep in project (builtin)' })

map('n', '<leader>fc', '/', { desc = 'Find in current buffer (builtin)' })
map('n', '<leader>fs', ':<C-u>/', { desc = 'Search word in current file' })

-- Help and command finding (direct vim commands)
map('n', '<leader>fh', ':<C-u>help ', { desc = 'Find help topics' })

-- NOTE: Keymap discovery now handled by which-key plugin
-- Press <leader> and wait to see available keymaps organized by category
map('n', '<leader>?', function() 
  require("which-key").show({ global = false })
end, { desc = 'Show all keymaps (which-key)' })

-- Advanced grep operations (built-in commands)
map('n', '<leader>fg', ':<C-u>grep -r "<C-r><C-w>" .<CR>', { desc = 'Grep word under cursor' })

-- Add quickfix navigation
map('n', '<C-n>', '<CMD>cnext<CR>', { desc = 'Next quickfix item' })
map('n', '<C-p>', '<CMD>cprev<CR>', { desc = 'Previous quickfix item' })

-- NOTE: Diagnostic navigation is handled in LSP setup function (buffer-local)
-- Global navigation removed to avoid conflicts with buffer-local LSP mappings

-- Diagnostic severity navigation
map('n', ']e', function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys('zz', 'n', false)
end, { desc = 'Next error' })

map('n', '[e', function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  vim.api.nvim_feedkeys('zz', 'n', false)
end, { desc = 'Previous error' })

map('n', ']w', function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
  vim.api.nvim_feedkeys('zz', 'n', false)
end, { desc = 'Next warning' })

map('n', '[w', function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
  vim.api.nvim_feedkeys('zz', 'n', false)
end, { desc = 'Previous warning' })

-- Built-in TODO navigation (direct vim commands)
map('n', ']t', '/\v(TODO|FIXME|HACK|NOTE|BUG)<CR>', { desc = 'Next TODO comment' })
map('n', '[t', '?\v(TODO|FIXME|HACK|NOTE|BUG)<CR>', { desc = 'Previous TODO comment' })
map('n', '<leader>ft', ':<C-u>grep -r "TODO\\|FIXME\\|HACK\\|NOTE\\|BUG" .<CR>', { desc = 'Find all TODO comments' })

-- Terminal keymaps (consolidated)
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<leader>et', '<CMD>terminal<CR>', { desc = 'Open terminal' })

-- ============================================================================
-- PURE BUILT-IN VIM COMMANDS FOR REFERENCE
-- ============================================================================
-- These work on ANY vim installation without plugins:
-- 
-- FILE & BUFFER MANAGEMENT:
-- :find {pattern}     - Find files recursively (use * wildcards)
-- :grep {pattern} .   - Search in project with ripgrep/grep
-- :ls                 - List all buffers
-- :buffer {name/num}  - Switch to buffer by name or number
-- :bdelete            - Close current buffer
-- :bnext/:bprev       - Navigate buffers
-- :buffers            - Show buffer list
-- :oldfiles           - Recent files
-- 
-- SEARCH & NAVIGATION:
-- *                   - Search word under cursor forward
-- #                   - Search word under cursor backward  
-- /pattern            - Search forward
-- ?pattern            - Search backward
-- n/N                 - Next/previous search result
-- :noh                - Clear search highlights
-- :%s/old/new/gc      - Search and replace with confirmation
-- 
-- HELP & DISCOVERY:
-- :help {topic}       - Built-in help system
-- :map                - Show all keymaps
-- :commands           - Available commands
-- :jumps              - Jump list  
-- :marks              - Mark list
-- :registers          - Register contents
-- 
-- WINDOW MANAGEMENT:
-- <C-w>hjkl           - Navigate splits
-- <C-w>v/<C-w>s       - Create vertical/horizontal splits
-- <C-w>=              - Make splits equal size
-- <C-w>c              - Close current split
-- <C-w>o              - Close all other splits
-- 
-- TEXT EDITING:
-- gu/gU/g~            - Change case (lowercase/uppercase/toggle)
-- J/gJ                - Join lines (with/without spaces)
-- >>/<< (visual)      - Indent/unindent selection
-- =                   - Auto-indent
-- 
-- Use these NATIVE commands instead of custom functions!

-- Note: LSP keymaps are set up per buffer in the LSP on_attach function

-- Note: ToggleTerm uses <C-t> mapping configured in its own setup

-- ============================================================================
-- PLUGIN-SPECIFIC KEYMAPS (REQUIRE PLUGINS TO WORK)
-- ============================================================================
-- WARNING: These keymaps depend on specific plugins being installed
-- Remove or comment out keymaps for plugins you don't want to use

-- Obsidian keymaps
map('n', '<leader>oo', '<cmd>ObsidianOpen<cr>', { desc = 'Open Obsidian App' })
map('n', '<leader>on', '<cmd>ObsidianNew<cr>', { desc = 'Create New Note' })
map('n', '<leader>oq', '<cmd>ObsidianQuickSwitch<cr>', { desc = 'Quick Switch Notes' })
map('n', '<leader>os', '<cmd>ObsidianSearch<cr>', { desc = 'Search Notes' })
map('n', '<leader>ot', '<cmd>ObsidianToday<cr>', { desc = "Open Today's Note" })
map('n', '<leader>oy', '<cmd>ObsidianYesterday<cr>', { desc = "Open Yesterday's Note" })
map('n', '<leader>om', '<cmd>ObsidianTomorrow<cr>', { desc = "Open Tomorrow's Note" })
map('n', '<leader>ob', '<cmd>ObsidianBacklinks<cr>', { desc = 'Show Backlinks' })
map('n', '<leader>oL', '<cmd>ObsidianLinks<cr>', { desc = 'Show Links' })
map('n', '<leader>oT', '<cmd>ObsidianTemplate<cr>', { desc = 'Insert Template' })
map('n', '<leader>op', '<cmd>ObsidianPasteImg<cr>', { desc = 'Paste Image' })
map('n', '<leader>or', '<cmd>ObsidianRename<cr>', { desc = 'Rename Note' })
map('n', '<leader>od', '<cmd>ObsidianDailies<cr>', { desc = 'Open Daily Notes' })
map('n', '<leader>ow', '<cmd>ObsidianWorkspace<cr>', { desc = 'Switch Workspace' })
-- Visual mode mappings for Obsidian
map('v', '<leader>ol', '<cmd>ObsidianLink<cr>', { desc = 'Create Link from Selection' })
map('v', '<leader>oN', '<cmd>ObsidianLinkNew<cr>', { desc = 'Create New Note from Selection' })
-- Obsidian checkbox toggle (moved from plugin config to avoid duplication)
map('n', '<leader>oc', function() require('obsidian').util.toggle_checkbox() end, { desc = 'Toggle Checkbox' })
-- NOTE: To enable Obsidian templates, create a 'templates' folder in your workspace

-- Render Markdown keymaps
map('n', '<leader>rm', function() require('render-markdown').toggle() end, { desc = 'Toggle Render Markdown' })
map('n', '<leader>rM', function() require('render-markdown').enable() end, { desc = 'Enable Render Markdown' })
map('n', '<leader>rd', function() require('render-markdown').disable() end, { desc = 'Disable Render Markdown' })

-- Markdown Preview (using external tools)
map('n', '<leader>mp', '<cmd>!open -a "Markdown Editor" %<cr>', { desc = 'Markdown: Open in external editor' })
-- NOTE: For builtin markdown viewing, use render-markdown toggle (<leader>rm)
-- For external preview: :!open % (macOS) or :!xdg-open % (Linux)

-- Treesitter keymaps
map('n', '<leader>tc', '<cmd>TSContextToggle<CR>', { desc = 'Toggle Treesitter Context' })
map('n', '<leader>th', '<cmd>TSHighlightCapturesUnderCursor<CR>', { desc = 'Show TS Highlight Groups' })
map('n', '<leader>tg', '<cmd>TSPlaygroundToggle<CR>', { desc = 'Toggle TS Playground' })
-- Note: Treesitter swap keymaps (<leader>tsn/tsf/tsp/tsF) are configured in tree-sitter.lua
-- Note: Treesitter peek keymaps (<leader>pf/pc) are configured in tree-sitter.lua

-- Image Clip keymaps
map('n', '<leader>ip', '<cmd>PasteImage<cr>', { desc = 'Paste image from system clipboard' })

-- LazyGit keymaps
map('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })

-- Git keymaps (using builtin commands where possible)
map('n', '<leader>gd', '<cmd>!git diff<cr>', { desc = 'Git: Show diff (builtin)' })
map('n', '<leader>gs', '<cmd>!git status<cr>', { desc = 'Git: Show status (builtin)' })
map('n', '<leader>gl', '<cmd>!git log --oneline -10<cr>', { desc = 'Git: Show log (builtin)' })
map('n', '<leader>gb', '<cmd>!git blame %<cr>', { desc = 'Git: Blame current file (builtin)' })
-- NOTE: Advanced git operations removed - use native git commands in terminal
-- Use :!git diff, :!git log, :!git blame for native git functionality
-- For advanced UI: LazyGit (<leader>lg) or external git tools

-- Debugging keymaps
map('n', '<F5>', function() require('dap').continue() end, { desc = 'Debug: Start/Continue' })
map('n', '<F1>', function() require('dap').step_into() end, { desc = 'Debug: Step Into' })
map('n', '<F2>', function() require('dap').step_over() end, { desc = 'Debug: Step Over' })
map('n', '<F3>', function() require('dap').step_out() end, { desc = 'Debug: Step Out' })
map('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
map('n', '<leader>B', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Debug: Set Conditional Breakpoint' })
map('n', '<F7>', function() require('dapui').toggle() end, { desc = 'Debug: See last session result.' })
map('n', '<leader>dr', function() require('dap').repl.open() end, { desc = 'Debug: Open REPL' })
map('n', '<leader>dl', function() require('dap').run_last() end, { desc = 'Debug: Run Last' })
map({'n', 'v'}, '<leader>dh', function() require('dap.ui.widgets').hover() end, { desc = 'Debug: Hover Variables' })
map({'n', 'v'}, '<leader>dp', function() require('dap.ui.widgets').preview() end, { desc = 'Debug: Preview Variables' })
map('n', '<leader>dF', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, { desc = 'Debug: Show Frames' })
map('n', '<leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, { desc = 'Debug: Show Scopes' })

-- Testing keymaps
map('n', '<leader>tr', function() require('neotest').run.run() end, { desc = 'Test: Run Nearest' })
map('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, { desc = 'Test: Run File' })
map('n', '<leader>td', function() require('neotest').run.run({strategy = 'dap'}) end, { desc = 'Test: Debug Nearest' })
map('n', '<leader>ts', function() require('neotest').summary.toggle() end, { desc = 'Test: Toggle Summary' })
map('n', '<leader>to', function() require('neotest').output.open({ enter = true, auto_close = true }) end, { desc = 'Test: Show Output' })
map('n', '<leader>tO', function() require('neotest').output_panel.toggle() end, { desc = 'Test: Toggle Output Panel' })
map('n', '<leader>tS', function() require('neotest').run.stop() end, { desc = 'Test: Stop' })
map('n', '<leader>tw', function() require('neotest').watch.toggle(vim.fn.expand('%')) end, { desc = 'Test: Toggle Watch' })

-- Code Intelligence keymaps
map('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { desc = 'Trouble: Toggle' })
map('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { desc = 'Trouble: Workspace Diagnostics' })
map('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', { desc = 'Trouble: Document Diagnostics' })
map('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', { desc = 'Trouble: Quickfix' })
map('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', { desc = 'Trouble: Location List' })
map('n', '<leader>xr', '<cmd>TroubleToggle lsp_references<cr>', { desc = 'Trouble: LSP References' })
map('n', '<leader>as', '<cmd>AerialToggle!<cr>', { desc = 'Aerial: Toggle Outline' })
map('n', '<leader>an', '<cmd>AerialNext<cr>', { desc = 'Aerial: Next Symbol' })
map('n', '<leader>ap', '<cmd>AerialPrev<cr>', { desc = 'Aerial: Previous Symbol' })
map('n', '<leader>ao', '<cmd>AerialOpen<cr>', { desc = 'Aerial: Open Outline' })
map('n', '<leader>ac', '<cmd>AerialClose<cr>', { desc = 'Aerial: Close Outline' })
map('n', '<leader>at', '<cmd>AerialTreeToggle<cr>', { desc = 'Aerial: Toggle Tree View' })

-- NOTE: Text manipulation plugin keymaps removed - using built-in alternatives
-- Use built-in J/gJ for line joining, gu/gU/g~ for case changes, :%s//gc for search/replace

-- Session Management (using builtin vim commands)
map('n', '<leader>qs', '<cmd>mksession! Session.vim<cr>', { desc = 'Session: Save current session' })
map('n', '<leader>ql', '<cmd>source Session.vim<cr>', { desc = 'Session: Load session' })
map('n', '<leader>qw', '<cmd>wall<cr>', { desc = 'Save all files' })
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

-- ============================================================================
-- MARKDOWN-SPECIFIC KEYMAPS (will be set up via autocmd for markdown files)
-- ============================================================================

-- Simplified markdown keymaps using pure vim commands  
local function setup_markdown_keymaps()
  -- NOTE: Use <leader>oc for checkbox toggle (consistent with Obsidian)
  -- NOTE: These use built-in :substitute command - no plugins needed
  map('n', '<leader>mh', ':<C-u>s/^/# /<CR>', { desc = 'Add heading', buffer = true })
  map('n', '<leader>mH', ':<C-u>s/^#\\+ //g<CR>', { desc = 'Remove heading', buffer = true })
end

-- Set up autocmd to apply markdown keymaps
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = setup_markdown_keymaps,
  desc = 'Set up markdown-specific keymaps'
})

-- ============================================================================
-- LSP KEYMAPS FUNCTION (to be called from LSP on_attach)
-- ============================================================================

-- Function to set up LSP keymaps (exported for use in language.lua)
function _G.setup_lsp_keymaps(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  
  -- Go to definition/declaration/implementation/references
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts) -- definition
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts) -- declaration
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts) -- implementation
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts) -- references

  -- Type information
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, vim.tbl_extend('force', bufopts, { desc = 'Go to type definition' }))

  -- Hover docs and signature help
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  
  -- Additional LSP keymaps
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, vim.tbl_extend('force', bufopts, { desc = 'Show diagnostic float' }))
  
  -- LSP workspace management  
  vim.keymap.set('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, vim.tbl_extend('force', bufopts, { desc = 'Add workspace folder' }))
  vim.keymap.set('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, vim.tbl_extend('force', bufopts, { desc = 'Remove workspace folder' }))
  vim.keymap.set('n', '<leader>lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, vim.tbl_extend('force', bufopts, { desc = 'List workspace folders' }))

  -- Format document or selection
  vim.keymap.set({'n', 'v'}, '<leader>cf', function()
    vim.lsp.buf.format({ async = true })
  end, vim.tbl_extend('force', bufopts, { desc = 'Format code' }))

  -- Improved diagnostic keymaps (buffer-local versions)
  vim.keymap.set('n', '[d', function()
    vim.diagnostic.goto_prev({ buffer = bufnr })
    vim.api.nvim_feedkeys('zz', 'n', false)
  end, vim.tbl_extend('force', bufopts, { desc = 'Previous diagnostic' }))
  
  vim.keymap.set('n', ']d', function()
    vim.diagnostic.goto_next({ buffer = bufnr })
    vim.api.nvim_feedkeys('zz', 'n', false)
  end, vim.tbl_extend('force', bufopts, { desc = 'Next diagnostic' }))
end
=======
-- Fuzzy Finding
map('n', '<leader>ff', '<CMD>FzfLua files<CR>', { desc = 'Find Files' })
map('n', '<leader>fw', '<CMD>FzfLua live_grep<CR>', { desc = 'Find the word' })
map('n', '<leader>fb', '<CMD>FzfLua buffers<CR>', { desc = 'Find the buffers' })

-- Org-Mode Productivity Keymaps
-- Quick Capture
map('n', '<leader>oc', '<cmd>lua require("orgmode").action("capture.prompt")<CR>', { desc = 'Org Capture' })
map('n', '<leader>ot', '<cmd>lua require("orgmode").action("capture.refile", {key = "t"})<CR>', { desc = 'Capture Task' })
map('n', '<leader>on', '<cmd>lua require("orgmode").action("capture.refile", {key = "n"})<CR>', { desc = 'Capture Note' })
map('n', '<leader>oj', '<cmd>lua require("orgmode").action("capture.refile", {key = "j"})<CR>', { desc = 'Journal Entry' })
map('n', '<leader>op', '<cmd>lua require("orgmode").action("capture.refile", {key = "p"})<CR>', { desc = 'New Project' })
map('n', '<leader>om', '<cmd>lua require("orgmode").action("capture.refile", {key = "m"})<CR>', { desc = 'Meeting Notes' })
map('n', '<leader>oi', '<cmd>lua require("orgmode").action("capture.refile", {key = "i"})<CR>', { desc = 'Capture Idea' })
map('n', '<leader>or', '<cmd>lua require("orgmode").action("capture.refile", {key = "r"})<CR>', { desc = 'Add Reference' })

-- Agenda and Navigation
map('n', '<leader>oa', '<cmd>lua require("orgmode").action("agenda.prompt")<CR>', { desc = 'Org Agenda' })
map('n', '<leader>ol', '<cmd>lua require("orgmode").action("agenda.agenda")<CR>', { desc = 'Agenda List' })
map('n', '<leader>os', '<cmd>lua require("orgmode").action("agenda.tags")<CR>', { desc = 'Search by Tags' })

-- File Navigation
map('n', '<leader>of', '<cmd>e ~/Documents/orgfiles/<CR>', { desc = 'Open Org Files Directory' })
map('n', '<leader>oT', '<cmd>e ~/Documents/orgfiles/tasks.org<CR>', { desc = 'Open Tasks' })
map('n', '<leader>oN', '<cmd>e ~/Documents/orgfiles/notes.org<CR>', { desc = 'Open Notes' })
map('n', '<leader>oJ', '<cmd>e ~/Documents/orgfiles/journal.org<CR>', { desc = 'Open Journal' })
map('n', '<leader>oP', '<cmd>e ~/Documents/orgfiles/projects.org<CR>', { desc = 'Open Projects' })
map('n', '<leader>oM', '<cmd>e ~/Documents/orgfiles/meetings.org<CR>', { desc = 'Open Meetings' })
map('n', '<leader>oI', '<cmd>e ~/Documents/orgfiles/ideas.org<CR>', { desc = 'Open Ideas' })
map('n', '<leader>oR', '<cmd>e ~/Documents/orgfiles/references.org<CR>', { desc = 'Open References' })

-- Org-Roam Integration
map('n', '<leader>rf', '<cmd>lua require("org-roam").capture_node()<CR>', { desc = 'Create Roam Note' })
map('n', '<leader>rt', '<cmd>lua require("org-roam").toggle()<CR>', { desc = 'Toggle Roam Buffer' })
map('n', '<leader>rn', '<cmd>lua require("org-roam").find_node()<CR>', { desc = 'Find Roam Node' })
map('n', '<leader>ri', '<cmd>lua require("org-roam").insert_node()<CR>', { desc = 'Insert Roam Link' })

-- Markdown/Obsidian Productivity Keymaps
-- Quick Note Creation
map('n', '<leader>mn', '<cmd>ObsidianNew<CR>', { desc = 'New Obsidian Note' })
map('n', '<leader>mt', '<cmd>ObsidianTemplate task-template<CR>', { desc = 'New Task' })
map('n', '<leader>mp', '<cmd>ObsidianTemplate project-template<CR>', { desc = 'New Project' })
map('n', '<leader>mm', '<cmd>ObsidianTemplate meeting-template<CR>', { desc = 'New Meeting Note' })
map('n', '<leader>mi', '<cmd>ObsidianTemplate idea-template<CR>', { desc = 'New Idea' })
map('n', '<leader>mc', '<cmd>ObsidianTemplate person-template<CR>', { desc = 'New Contact' })
map('n', '<leader>mb', '<cmd>ObsidianTemplate book-template<CR>', { desc = 'New Book Note' })
map('n', '<leader>ma', '<cmd>ObsidianTemplate area-template<CR>', { desc = 'New Area' })

-- Daily Notes
map('n', '<leader>md', '<cmd>ObsidianToday<CR>', { desc = "Today's Daily Note" })
map('n', '<leader>my', '<cmd>ObsidianYesterday<CR>', { desc = "Yesterday's Daily Note" })
map('n', '<leader>mD', '<cmd>ObsidianDailies<CR>', { desc = 'Browse Daily Notes' })

-- Navigation and Search
map('n', '<leader>mf', '<cmd>ObsidianQuickSwitch<CR>', { desc = 'Quick Switch Notes' })
map('n', '<leader>ms', '<cmd>ObsidianSearch<CR>', { desc = 'Search Obsidian' })
map('n', '<leader>mw', '<cmd>ObsidianWorkspace<CR>', { desc = 'Switch Workspace' })
map('n', '<leader>mg', '<cmd>ObsidianFollowLink<CR>', { desc = 'Follow Link' })
map('n', '<leader>mB', '<cmd>ObsidianBacklinks<CR>', { desc = 'Show Backlinks' })
map('n', '<leader>mT', '<cmd>ObsidianTags<CR>', { desc = 'Browse Tags' })

-- Link Management
map('n', '<leader>ml', '<cmd>ObsidianLink<CR>', { desc = 'Link Selection' })
map('n', '<leader>mL', '<cmd>ObsidianLinkNew<CR>', { desc = 'Link to New Note' })
map('v', '<leader>ml', '<cmd>ObsidianLink<CR>', { desc = 'Link Selection' })
map('v', '<leader>mL', '<cmd>ObsidianLinkNew<CR>', { desc = 'Link to New Note' })

-- Markdown Utilities
map('n', '<leader>mr', '<cmd>ObsidianRename<CR>', { desc = 'Rename Note' })
map('n', '<leader>me', '<cmd>ObsidianExtractNote<CR>', { desc = 'Extract to New Note' })
map('n', '<leader>mo', '<cmd>ObsidianOpen<CR>', { desc = 'Open in Obsidian App' })

-- Markdown Preview
map('n', '<leader>mvp', '<cmd>MarkdownPreviewToggle<CR>', { desc = 'Toggle Markdown Preview' })
map('n', '<leader>mvs', '<cmd>MarkdownPreview<CR>', { desc = 'Start Markdown Preview' })
map('n', '<leader>mvx', '<cmd>MarkdownPreviewStop<CR>', { desc = 'Stop Markdown Preview' })

-- Table Mode
map('n', '<leader>mtt', '<cmd>TableModeToggle<CR>', { desc = 'Toggle Table Mode' })
map('n', '<leader>mtr', '<cmd>TableModeRealign<CR>', { desc = 'Realign Table' })
map('n', '<leader>mtd', '<cmd>Tableize<CR>', { desc = 'Create Table from Delimiter' })

-- Image Paste
map('n', '<leader>mip', '<cmd>PasteImage<CR>', { desc = 'Paste Image' })
map('v', '<leader>mip', '<cmd>PasteImage<CR>', { desc = 'Paste Image' })

-- File Navigation (Obsidian Vault)
map('n', '<leader>mof', '<cmd>e ~/Documents/obsidian/<CR>', { desc = 'Open Obsidian Vault' })
map('n', '<leader>mot', '<cmd>e ~/Documents/obsidian/templates/<CR>', { desc = 'Open Templates' })
map('n', '<leader>mod', '<cmd>e ~/Documents/obsidian/daily/<CR>', { desc = 'Open Daily Notes' })

-- Quick Markdown Formatting (in insert mode)
map('i', '<C-b>', '****<Left><Left>', { desc = 'Bold Text' })
map('i', '<C-i>', '**<Left>', { desc = 'Italic Text' })
map('i', '<C-u>', '<Esc>yypVr=A<CR>', { desc = 'Underline Header' })

-- Checkbox toggles
map('n', '<leader>x', '<cmd>lua require("obsidian").util.toggle_checkbox()<CR>', { desc = 'Toggle Checkbox' })
>>>>>>> refs/remotes/origin/main
