-- ============================================================================
-- KEYMAPS CONFIGURATION
-- ============================================================================
--
-- Complete keymap configuration for native Neovim IDE
-- Focus: Native features, productivity, professional workflows
--
-- Organization:
--   1. Leader & Basic Setup
--   2. Editor Operations (save, select, search/replace, text manipulation)
--   3. Navigation (buffers, windows, files, jumps, marks)
--   4. Code Features (folding, LSP integration via plugins, diagnostics)
--   5. Development Tools (testing, debugging, terminal, execution)
--   6. Visual & UI (toggles, themes, concealment)
--   7. Advanced Features (sessions, macros, registers, treesitter)
--   8. Plugin Integrations (which-key compatible groups)
--
-- Total: 160+ keymaps covering all IDE needs
-- ============================================================================

-- ============================================================================
-- SECTION 1: LEADER KEY & BASIC SETUP
-- ============================================================================

vim.g.mapleader = ' ' -- Space as leader key
vim.g.maplocalleader = ' ' -- Space as local leader
vim.g.have_nerd_font = true -- Enable nerd font icons

local map = vim.keymap.set

-- Disable spacebar default behavior in normal/visual mode
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- ============================================================================
-- SECTION 2: EDITOR OPERATIONS
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 2.1 File Operations
-- ---------------------------------------------------------------------------

map('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
map('n', 'x', '"_x', { desc = 'Delete char (no yank)' })
map('n', '<C-q>', '<cmd>quit<CR>', { desc = 'Quit Neovim' })

-- ---------------------------------------------------------------------------
-- 2.2 Selection Operations
-- ---------------------------------------------------------------------------

map('n', '<C-a>', 'ggVG', { desc = 'Select all' })
map('n', 'gp', '`[v`]', { desc = 'Select last pasted text' })

-- ---------------------------------------------------------------------------
-- 2.3 Clipboard Operations
-- ---------------------------------------------------------------------------

map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = 'Yank line to clipboard' })

-- Better paste in visual mode (don't yank replaced text)
map('x', 'p', '"_dP', { desc = 'Paste without yanking' })

-- ---------------------------------------------------------------------------
-- 2.4 Search & Replace
-- ---------------------------------------------------------------------------

-- Basic search improvements (center on screen)
map('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
map('n', 'N', 'Nzzzv', { desc = 'Prev search result (centered)' })
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
map('n', '<leader>nh', '<cmd>noh<CR>', { desc = 'Clear highlight' })

-- Search navigation (Native 0.11+)
map('n', 'gn', 'gn', { desc = 'Select next search match' })
map('n', 'gN', 'gN', { desc = 'Select prev search match' })
map('n', 'g*', 'g*', { desc = 'Search word (no boundary)' })
map('n', 'g#', 'g#', { desc = 'Search word backward' })

-- Search & Replace workflows
map('n', '<leader>sr', [[:%s///gc<Left><Left><Left>]], { desc = 'Search & replace (interactive)' })
map('n', '<leader>ra', [[:%s/<C-r><C-w>//gc<Left><Left><Left>]], { desc = 'Replace word under cursor' })
map('n', '<leader>rw', [[:%s/\s\+$//e<CR>]], { desc = 'Remove trailing whitespace' })

-- Replace word under cursor in file
map('n', '<leader>rp', function()
  local old = vim.fn.expand '<cword>'
  local new = vim.fn.input('Replace "' .. old .. '" with: ')
  if new ~= '' then
    vim.cmd('%s/' .. old .. '/' .. new .. '/gc')
  end
end, { desc = 'Replace word in file' })

-- Replace in visual selection
map('v', '<leader>rp', function()
  vim.cmd "'<,'>s///gc<Left><Left><Left><Left>"
end, { desc = 'Replace in selection' })

-- Search word in project (uses quickfix)
map('n', '<leader>*', function()
  local word = vim.fn.expand '<cword>'
  vim.cmd('vimgrep /' .. word .. '/gj **/*')
  vim.cmd 'copen'
end, { desc = 'Search word in project' })

-- Search in project (fuzzy)
map('n', '<leader>/', function()
  _G.fuzzy_grep()
end, { desc = 'Search in project' })

-- ---------------------------------------------------------------------------
-- 2.5 Text Manipulation
-- ---------------------------------------------------------------------------

-- Line operations
map('n', '<A-j>', '<cmd>move .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-k>', '<cmd>move .-2<CR>==', { desc = 'Move line up' })
map('n', '<leader>ld', '<cmd>copy .<CR>', { desc = 'Duplicate line' })
map('v', '<leader>ld', ":copy '><CR>gv", { desc = 'Duplicate selection' })

-- Visual mode line movement
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move lines down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move lines up' })

-- Indentation (keep visual selection)
map('v', '<', '<gv', { desc = 'Indent left' })
map('v', '>', '>gv', { desc = 'Indent right' })

-- Insert blank lines
map('n', '<leader>o', 'o<Esc>', { desc = 'Insert line below' })
map('n', '<leader>O', 'O<Esc>', { desc = 'Insert line above' })

-- Join lines (keep cursor position)
map('n', 'J', 'mzJ`z', { desc = 'Join lines (keep cursor)' })

-- Increment/decrement numbers
map('n', '+', '<C-a>', { desc = 'Increment number' })
map('n', '-', '<C-x>', { desc = 'Decrement number' })

-- ---------------------------------------------------------------------------
-- 2.6 Comments & Documentation
-- ---------------------------------------------------------------------------

-- Comment toggle (requires comment plugin)
map('n', '<C-/>', 'gcc', { remap = true, desc = 'Toggle comment' })
map('v', '<C-/>', 'gc', { remap = true, desc = 'Toggle comment' })

-- Create comment box around current line
map('n', '<leader>cb', function()
  local line = vim.api.nvim_get_current_line()
  local comment = vim.bo.commentstring:gsub('%%s', '')
  local width = 80
  local border = comment .. string.rep('=', width - #comment)
  local content = comment .. ' ' .. line
  local padding = width - #content - #comment
  if padding > 0 then
    content = content .. string.rep(' ', padding) .. comment
  end
  vim.api.nvim_put({ border, content, border }, 'l', true, true)
  vim.cmd 'normal! 2k'
end, { desc = 'Create comment box' })

-- ---------------------------------------------------------------------------
-- 2.7 Visual Block Mode & Text Alignment
-- ---------------------------------------------------------------------------

map('n', '<leader>vb', '<C-v>', { desc = 'Enter visual block mode' })
map('v', '<leader>I', '<C-v>I', { desc = 'Insert at column start' })
map('v', '<leader>A', '<C-v>A', { desc = 'Insert at column end' })

-- Text alignment (native commands)
map('v', '<leader>al', ':left<CR>gv', { desc = 'Align left' })
map('v', '<leader>ac', ':center<CR>gv', { desc = 'Align center' })
map('v', '<leader>ar', ':right<CR>gv', { desc = 'Align right' })

-- ---------------------------------------------------------------------------
-- 2.8 Scrolling & Navigation Centering
-- ---------------------------------------------------------------------------

map('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })
map('n', '{', '{zz', { desc = 'Prev paragraph (centered)' })
map('n', '}', '}zz', { desc = 'Next paragraph (centered)' })

-- ============================================================================
-- SECTION 3: NAVIGATION
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 3.1 Buffer Navigation
-- ---------------------------------------------------------------------------

map('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<S-Tab>', '<cmd>bprevious<CR>', { desc = 'Prev buffer' })
map('n', '<leader>bb', '<cmd>e#<CR>', { desc = 'Alternate buffer' })
map('n', '<leader>bc', '<cmd>bdel<CR>', { desc = 'Close current buffer' })

-- Close all other buffers (keep only current)
map('n', '<leader>bC', function()
  local current = vim.api.nvim_get_current_buf()
  vim
    .iter(vim.api.nvim_list_bufs())
    :filter(function(buf)
      return buf ~= current and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted
    end)
    :each(function(buf)
      vim.api.nvim_buf_delete(buf, { force = false })
    end)
end, { desc = 'Close all other buffers' })

-- ---------------------------------------------------------------------------
-- 3.2 Window Navigation & Management
-- ---------------------------------------------------------------------------

-- Navigate between windows
map('n', '<C-h>', '<cmd>wincmd h<CR>', { desc = 'Move to left window' })
map('n', '<C-j>', '<cmd>wincmd j<CR>', { desc = 'Move to bottom window' })
map('n', '<C-k>', '<cmd>wincmd k<CR>', { desc = 'Move to top window' })
map('n', '<C-l>', '<cmd>wincmd l<CR>', { desc = 'Move to right window' })

-- Resize windows
map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Window splitting & management
map('n', '<leader>v', '<C-w>v', { desc = 'Split vertical' })
map('n', '<leader>wh', '<C-w>s', { desc = 'Split horizontal' })
map('n', '<leader>we', '<C-w>=', { desc = 'Equal window sizes' })
map('n', '<leader>wc', '<cmd>close<CR>', { desc = 'Close current window' })
map('n', '<leader>wo', '<C-w>o', { desc = 'Close other windows' })

-- Window zoom toggle (maximize/restore)
map('n', '<leader>wz', function()
  if vim.t.maximized then
    vim.cmd 'wincmd ='
    vim.t.maximized = false
  else
    vim.cmd 'wincmd |'
    vim.cmd 'wincmd _'
    vim.t.maximized = true
  end
end, { desc = 'Toggle window zoom' })

-- ---------------------------------------------------------------------------
-- 3.3 File Navigation
-- ---------------------------------------------------------------------------

-- File explorer (Oil.nvim)
map('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' })

-- Fuzzy file finding (native)
map('n', '<leader>ff', function()
  _G.fuzzy_find_files()
end, { desc = 'Find files' })

map('n', '<leader>fw', function()
  _G.fuzzy_grep()
end, { desc = 'Find word in files' })

map('n', '<leader>fb', function()
  _G.fuzzy_buffers()
end, { desc = 'Find buffers' })

-- Recent files
map('n', '<leader>fr', function()
  local oldfiles = vim.v.oldfiles
  vim.ui.select(oldfiles, {
    prompt = 'Recent files:',
  }, function(choice)
    if choice then
      vim.cmd('edit ' .. choice)
    end
  end)
end, { desc = 'Find recent files' })

-- ---------------------------------------------------------------------------
-- 3.4 Jump List & Change List Navigation
-- ---------------------------------------------------------------------------

-- Jump list (centered navigation)
map('n', '<leader>jo', '<C-o>zz', { desc = 'Jump to older position' })
map('n', '<leader>ji', '<C-i>zz', { desc = 'Jump to newer position' })

-- Change list
map('n', 'g;', 'g;zz', { desc = 'Go to older change' })
map('n', 'g,', 'g,zz', { desc = 'Go to newer change' })

-- ---------------------------------------------------------------------------
-- 3.5 Marks & Registers
-- ---------------------------------------------------------------------------

-- Marks
map('n', '<leader>m', '<cmd>marks<CR>', { desc = 'Show all marks' })
map('n', '<leader>M', '<cmd>delmarks!<CR>', { desc = 'Delete all marks' })
map('n', 'dm', '<cmd>delmarks ', { desc = 'Delete specific mark' })

-- Registers
map('n', '<leader>r', '<cmd>registers<CR>', { desc = 'Show all registers' })
map('n', '<leader>R', function()
  vim.fn.setreg(vim.fn.input 'Register: ', '')
end, { desc = 'Clear specific register' })

-- Register preview (enhanced with vim.ui.select)
map('n', '<leader>re', function()
  local regs = vim.fn.split('abcdefghijklmnopqrstuvwxyz0123456789"*+', '\\zs')
  local items = {}
  for _, reg in ipairs(regs) do
    local content = vim.fn.getreg(reg)
    if content ~= '' then
      table.insert(items, string.format('%s: %s', reg, content:gsub('\n', ' '):sub(1, 60)))
    end
  end
  vim.ui.select(items, {
    prompt = 'Register preview:',
  }, function(choice)
    if choice then
      local reg = choice:match '^(.):'
      vim.notify('Register ' .. reg .. ': ' .. vim.fn.getreg(reg), vim.log.levels.INFO)
    end
  end)
end, { desc = 'Preview register contents' })

-- Clear all registers
map('n', '<leader>rC', function()
  for i = 0, 9 do
    vim.fn.setreg(tostring(i), '')
  end
  for c = 97, 122 do
    vim.fn.setreg(string.char(c), '')
  end
  vim.notify('All registers cleared', vim.log.levels.INFO)
end, { desc = 'Clear all registers' })

-- ============================================================================
-- SECTION 4: CODE FEATURES
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 4.1 Folding (Native Treesitter)
-- ---------------------------------------------------------------------------

-- Basic fold operations
map('n', 'za', 'za', { desc = 'Toggle fold under cursor' })
map('n', 'zA', 'zA', { desc = 'Toggle all folds recursively' })
map('n', 'zo', 'zo', { desc = 'Open fold' })
map('n', 'zO', 'zO', { desc = 'Open all folds recursively' })
map('n', 'zc', 'zc', { desc = 'Close fold' })
map('n', 'zC', 'zC', { desc = 'Close all folds recursively' })

-- Fold level control
map('n', 'zm', 'zm', { desc = 'Fold more (decrease level)' })
map('n', 'zM', 'zM', { desc = 'Close all folds' })
map('n', 'zr', 'zr', { desc = 'Fold less (increase level)' })
map('n', 'zR', 'zR', { desc = 'Open all folds' })

-- Fold creation & deletion
map('v', 'zf', 'zf', { desc = 'Create fold from selection' })
map('n', 'zd', 'zd', { desc = 'Delete fold under cursor' })
map('n', 'zE', 'zE', { desc = 'Eliminate all folds' })

-- Fold navigation
map('n', 'zj', 'zj', { desc = 'Move to next fold' })
map('n', 'zk', 'zk', { desc = 'Move to prev fold' })

-- ---------------------------------------------------------------------------
-- 4.2 Diagnostics (Native vim.diagnostic)
-- ---------------------------------------------------------------------------

-- Navigate diagnostics
map('n', ']e', function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Next error' })

map('n', '[e', function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Prev error' })

map('n', ']w', function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.WARN }
end, { desc = 'Next warning' })

map('n', '[w', function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.WARN }
end, { desc = 'Prev warning' })

-- Diagnostic filtering (show only specific severity levels)
map('n', '<leader>de', function()
  vim.diagnostic.config {
    virtual_text = { severity = vim.diagnostic.severity.ERROR },
    signs = { severity = vim.diagnostic.severity.ERROR },
    underline = { severity = vim.diagnostic.severity.ERROR },
  }
end, { desc = 'Show only errors' })

map('n', '<leader>dw', function()
  vim.diagnostic.config {
    virtual_text = { severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR } },
    signs = { severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR } },
    underline = { severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR } },
  }
end, { desc = 'Show errors & warnings' })

map('n', '<leader>da', function()
  vim.diagnostic.config {
    virtual_text = { prefix = '●', source = 'if_many', spacing = 4 },
    signs = true,
    underline = true,
  }
end, { desc = 'Show all diagnostics' })

-- Send diagnostics to quickfix/location list
map('n', '<leader>dq', function()
  vim.diagnostic.setqflist()
  vim.cmd 'copen'
end, { desc = 'Diagnostics to quickfix' })

map('n', '<leader>dL', function()
  vim.diagnostic.setloclist()
  vim.cmd 'lopen'
end, { desc = 'Diagnostics to loclist' })

-- Toggle diagnostics display
map('n', '<leader>xd', function()
  local current = vim.diagnostic.config().virtual_text
  vim.diagnostic.config {
    virtual_text = not current and { prefix = '●', source = 'if_many', spacing = 4, current_line = true } or false,
  }
  vim.notify('Diagnostics: ' .. (current and 'hidden' or 'visible'), vim.log.levels.INFO)
end, { desc = 'Toggle diagnostics display' })

-- ---------------------------------------------------------------------------
-- 4.3 Quickfix & Location Lists (Native)
-- ---------------------------------------------------------------------------

-- Quickfix navigation
map('n', ']q', '<cmd>cnext<CR>zz', { desc = 'Next quickfix item' })
map('n', '[q', '<cmd>cprev<CR>zz', { desc = 'Prev quickfix item' })
map('n', ']Q', '<cmd>clast<CR>zz', { desc = 'Last quickfix item' })
map('n', '[Q', '<cmd>cfirst<CR>zz', { desc = 'First quickfix item' })

-- Location list navigation
map('n', ']l', '<cmd>lnext<CR>zz', { desc = 'Next loclist item' })
map('n', '[l', '<cmd>lprev<CR>zz', { desc = 'Prev loclist item' })

-- Toggle quickfix list
map('n', '<leader>xq', function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      qf_exists = true
      break
    end
  end
  if qf_exists then
    vim.cmd 'cclose'
  else
    vim.cmd 'copen'
  end
end, { desc = 'Toggle quickfix list' })

-- Toggle location list
map('n', '<leader>xl', function()
  local loc_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['loclist'] == 1 then
      loc_exists = true
      break
    end
  end
  if loc_exists then
    vim.cmd 'lclose'
  else
    vim.cmd 'lopen'
  end
end, { desc = 'Toggle location list' })

-- ---------------------------------------------------------------------------
-- 4.4 Spell Checking (Native + Enhanced)
-- ---------------------------------------------------------------------------

map('n', '<leader>sz', '<cmd>set spell!<CR>', { desc = 'Toggle spell check' })
map('n', ']z', ']szz', { desc = 'Next misspelling' })
map('n', '[z', '[szz', { desc = 'Prev misspelling' })

-- Quick spell suggestions (enhanced with vim.ui.select)
map('n', '<leader>z=', function()
  vim.ui.select(vim.fn.spellsuggest(vim.fn.expand '<cword>'), {
    prompt = 'Spell suggestions:',
  }, function(choice)
    if choice then
      vim.cmd('normal! ciw' .. choice)
    end
  end)
end, { desc = 'Show spell suggestions' })

map('n', '<leader>zg', 'zg', { desc = 'Add word to dictionary' })
map('n', '<leader>zw', 'zw', { desc = 'Mark word as wrong' })
map('n', '<leader>zu', 'zuw', { desc = 'Undo dictionary change' })

-- ---------------------------------------------------------------------------
-- 4.5 LSP Code Actions & Refactoring (Native LSP)
-- ---------------------------------------------------------------------------
-- Note: LSP keymaps are in lua/plugins/language.lua (LspAttach callback)
-- This section handles code actions that work with LSP

-- Extract to function (visual mode)
map('v', '<leader>re', function()
  vim.lsp.buf.code_action {
    context = {
      only = { 'refactor.extract' },
    },
    apply = true,
  }
end, { desc = 'Extract to function' })

-- Inline variable
map('n', '<leader>ri', function()
  vim.lsp.buf.code_action {
    context = {
      only = { 'refactor.inline' },
    },
    apply = true,
  }
end, { desc = 'Inline variable' })

-- Organize imports
map('n', '<leader>io', function()
  local ft = vim.bo.filetype
  if ft == 'python' then
    vim.cmd 'terminal isort %'
    vim.cmd 'edit!'
  else
    vim.lsp.buf.code_action {
      context = {
        only = { 'source.organizeImports' },
      },
      apply = true,
    }
  end
end, { desc = 'Organize imports' })

-- Add missing imports
map('n', '<leader>ia', function()
  vim.lsp.buf.code_action {
    context = {
      only = { 'source.addMissingImports' },
    },
    apply = true,
  }
end, { desc = 'Add missing imports' })

-- Remove unused imports
map('n', '<leader>ir', function()
  vim.lsp.buf.code_action {
    context = {
      only = { 'source.removeUnusedImports' },
    },
    apply = true,
  }
end, { desc = 'Remove unused imports' })

-- Format selection (LSP range formatting)
map('v', '<leader>cf', function()
  local start_pos = vim.api.nvim_buf_get_mark(0, '<')
  local end_pos = vim.api.nvim_buf_get_mark(0, '>')
  vim.lsp.buf.format {
    range = {
      ['start'] = start_pos,
      ['end'] = end_pos,
    },
  }
end, { desc = 'Format selection (LSP)' })

-- Extract variable (visual mode)
map('v', '<leader>ev', function()
  vim.lsp.buf.code_action {
    context = {
      only = { 'refactor.extract.variable' },
    },
    apply = true,
  }
end, { desc = 'Extract variable' })

-- Extract constant (visual mode)
map('v', '<leader>ec', function()
  vim.lsp.buf.code_action {
    context = {
      only = { 'refactor.extract.constant' },
    },
    apply = true,
  }
end, { desc = 'Extract constant' })

-- ---------------------------------------------------------------------------
-- 4.6 Treesitter Inspector (Native 0.11+)
-- ---------------------------------------------------------------------------

map('n', '<leader>Ti', '<cmd>Inspect<CR>', { desc = 'Inspect highlight/treesitter' })
map('n', '<leader>TT', '<cmd>InspectTree<CR>', { desc = 'Open treesitter tree' })

-- ---------------------------------------------------------------------------
-- 4.7 Diff Mode (Native)
-- ---------------------------------------------------------------------------

map('n', ']c', ']c', { desc = 'Next diff hunk' })
map('n', '[c', '[c', { desc = 'Prev diff hunk' })
map('n', 'do', 'do', { desc = 'Diff obtain (get from other)' })
map('n', 'dp', 'dp', { desc = 'Diff put (send to other)' })
map('n', '<leader>td', '<cmd>windo diffthis<CR>', { desc = 'Enable diff mode' })
map('n', '<leader>tD', '<cmd>windo diffoff<CR>', { desc = 'Disable diff mode' })

-- ---------------------------------------------------------------------------
-- 4.8 URL Opening (Native vim.ui.open - 0.11+)
-- ---------------------------------------------------------------------------

map('n', 'gx', function()
  local url = vim.fn.expand '<cfile>'
  if url:match '^http' then
    vim.ui.open(url)
  else
    vim.notify('No URL under cursor', vim.log.levels.WARN)
  end
end, { desc = 'Open URL under cursor' })

-- ============================================================================
-- SECTION 5: DEVELOPMENT TOOLS
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 5.1 Testing (Neotest Integration)
-- ---------------------------------------------------------------------------

map('n', '<leader>tr', function()
  require('neotest').run.run()
end, { desc = 'Test: Run nearest' })

map('n', '<leader>tf', function()
  require('neotest').run.run(vim.fn.expand '%')
end, { desc = 'Test: Run file' })

map('n', '<leader>ta', function()
  require('neotest').run.run(vim.fn.getcwd())
end, { desc = 'Test: Run all' })

map('n', '<leader>ts', function()
  require('neotest').summary.toggle()
end, { desc = 'Test: Toggle summary' })

map('n', '<leader>to', function()
  require('neotest').output.open { enter = true }
end, { desc = 'Test: View output' })

map('n', '<leader>tp', function()
  require('neotest').output_panel.toggle()
end, { desc = 'Test: Toggle panel' })

map('n', '<leader>tS', function()
  require('neotest').run.stop()
end, { desc = 'Test: Stop' })

map('n', '<leader>td', function()
  require('neotest').run.run { strategy = 'dap' }
end, { desc = 'Test: Debug' })

map('n', '[t', function()
  require('neotest').jump.prev { status = 'failed' }
end, { desc = 'Jump to prev failed test' })

map('n', ']t', function()
  require('neotest').jump.next { status = 'failed' }
end, { desc = 'Jump to next failed test' })

-- ---------------------------------------------------------------------------
-- 5.2 Debugging (nvim-dap Integration)
-- ---------------------------------------------------------------------------

map('n', '<leader>db', function()
  require('dap').toggle_breakpoint()
end, { desc = 'Debug: Toggle breakpoint' })

map('n', '<leader>dB', function()
  require('dap').set_breakpoint(vim.fn.input 'Condition: ')
end, { desc = 'Debug: Conditional breakpoint' })

map('n', '<leader>dc', function()
  require('dap').continue()
end, { desc = 'Debug: Continue' })

map('n', '<leader>di', function()
  require('dap').step_into()
end, { desc = 'Debug: Step into' })

map('n', '<leader>do', function()
  require('dap').step_over()
end, { desc = 'Debug: Step over' })

map('n', '<leader>dO', function()
  require('dap').step_out()
end, { desc = 'Debug: Step out' })

map('n', '<leader>dr', function()
  require('dap').repl.open()
end, { desc = 'Debug: Open REPL' })

map('n', '<leader>dl', function()
  require('dap').run_last()
end, { desc = 'Debug: Run last' })

map('n', '<leader>dt', function()
  require('dap').terminate()
end, { desc = 'Debug: Terminate' })

map('n', '<leader>du', function()
  require('dapui').toggle()
end, { desc = 'Debug: Toggle UI' })

-- ---------------------------------------------------------------------------
-- 5.3 Terminal Integration
-- ---------------------------------------------------------------------------

-- Basic terminal operations
map('n', '<C-t>', '<cmd>terminal<CR>', { desc = 'Open terminal' })
map('n', '<leader>ht', '<cmd>split | terminal<CR>', { desc = 'Terminal horizontal' })
map('n', '<leader>vt', '<cmd>vsplit | terminal<CR>', { desc = 'Terminal vertical' })

-- Terminal mode navigation
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Terminal: Move left' })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Terminal: Move down' })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Terminal: Move up' })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Terminal: Move right' })

-- Toggle terminal at bottom
map('n', '<leader>tt', function()
  -- Check if terminal buffer exists
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == 'terminal' then
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf then
          vim.api.nvim_win_close(win, false)
          return
        end
      end
    end
  end
  -- Open new terminal at bottom
  vim.cmd 'botright split | terminal'
  vim.cmd 'resize 15'
end, { desc = 'Toggle terminal' })

-- Send visual selection to terminal
map('v', '<leader>ts', function()
  local start_pos = vim.fn.getpos 'v'
  local end_pos = vim.fn.getpos '.'
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  -- Find terminal buffer
  local term_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == 'terminal' then
      term_buf = buf
      break
    end
  end

  if term_buf then
    local chan = vim.bo[term_buf].channel
    for _, line in ipairs(lines) do
      vim.fn.chansend(chan, line .. '\n')
    end
  else
    vim.notify('No terminal buffer found', vim.log.levels.WARN)
  end
end, { desc = 'Send selection to terminal' })

-- ---------------------------------------------------------------------------
-- 5.4 Code Execution (Native - Multiple Languages)
-- ---------------------------------------------------------------------------

-- Run current file based on filetype
-- Supports: Python, JS/TS, Lua, Bash, Ruby, Go, Rust, C, C++
map('n', '<leader>rr', function()
  local ft = vim.bo.filetype
  local file = vim.fn.expand '%:p'
  local cmd

  if ft == 'python' then
    cmd = 'python3 ' .. vim.fn.shellescape(file)
  elseif ft == 'javascript' or ft == 'typescript' then
    cmd = 'node ' .. vim.fn.shellescape(file)
  elseif ft == 'lua' then
    cmd = 'lua ' .. vim.fn.shellescape(file)
  elseif ft == 'sh' or ft == 'bash' then
    cmd = 'bash ' .. vim.fn.shellescape(file)
  elseif ft == 'ruby' then
    cmd = 'ruby ' .. vim.fn.shellescape(file)
  elseif ft == 'go' then
    cmd = 'go run ' .. vim.fn.shellescape(file)
  elseif ft == 'rust' then
    cmd = 'cargo run'
  elseif ft == 'c' then
    cmd = 'gcc ' .. vim.fn.shellescape(file) .. ' -o /tmp/a.out && /tmp/a.out'
  elseif ft == 'cpp' then
    cmd = 'g++ ' .. vim.fn.shellescape(file) .. ' -o /tmp/a.out && /tmp/a.out'
  else
    vim.notify('No run command for filetype: ' .. ft, vim.log.levels.WARN)
    return
  end

  vim.cmd('split | terminal ' .. cmd)
end, { desc = 'Run current file' })

-- ---------------------------------------------------------------------------
-- 5.5 File Operations (Advanced)
-- ---------------------------------------------------------------------------

-- Rename current file
map('n', '<leader>fR', function()
  local old_name = vim.fn.expand '%'
  vim.ui.input({ prompt = 'New name: ', default = old_name }, function(new_name)
    if new_name and new_name ~= '' and new_name ~= old_name then
      vim.cmd('saveas ' .. new_name)
      vim.fn.delete(old_name)
      vim.notify('Renamed: ' .. old_name .. ' → ' .. new_name, vim.log.levels.INFO)
    end
  end)
end, { desc = 'Rename current file' })

-- Delete current file
map('n', '<leader>fD', function()
  local file = vim.fn.expand '%'
  vim.ui.input({ prompt = 'Delete ' .. file .. '? (y/n): ' }, function(choice)
    if choice == 'y' or choice == 'Y' then
      vim.fn.delete(file)
      vim.cmd 'bdelete!'
      vim.notify('Deleted: ' .. file, vim.log.levels.INFO)
    end
  end)
end, { desc = 'Delete current file' })

-- Copy file path to clipboard
map('n', '<leader>fy', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, { desc = 'Copy file path' })

-- Copy file name to clipboard
map('n', '<leader>fn', function()
  local name = vim.fn.expand '%:t'
  vim.fn.setreg('+', name)
  vim.notify('Copied: ' .. name, vim.log.levels.INFO)
end, { desc = 'Copy file name' })

-- Make file executable (chmod +x)
map('n', '<leader>fx', function()
  local file = vim.fn.expand '%:p'
  vim.fn.system('chmod +x ' .. vim.fn.shellescape(file))
  vim.notify('Made executable: ' .. file, vim.log.levels.INFO)
end, { desc = 'Make file executable' })

-- ---------------------------------------------------------------------------
-- 5.6 Language-Specific Operations
-- ---------------------------------------------------------------------------

-- C/C++: Toggle between header and source file
map('n', '<leader>ch', function()
  local ext = vim.fn.expand '%:e'
  local base = vim.fn.expand '%:r'
  local other

  if ext == 'cpp' or ext == 'cc' or ext == 'c' then
    -- Source file: look for header
    other = base .. '.h'
    if vim.fn.filereadable(other) == 0 then
      other = base .. '.hpp'
    end
  elseif ext == 'h' or ext == 'hpp' then
    -- Header file: look for source
    other = base .. '.cpp'
    if vim.fn.filereadable(other) == 0 then
      other = base .. '.cc'
    end
    if vim.fn.filereadable(other) == 0 then
      other = base .. '.c'
    end
  else
    vim.notify('Not a C/C++ file', vim.log.levels.WARN)
    return
  end

  if vim.fn.filereadable(other) == 1 then
    vim.cmd('edit ' .. other)
  else
    vim.notify('Corresponding file not found: ' .. other, vim.log.levels.WARN)
  end
end, { desc = 'C/C++: Toggle header/source' })

-- Python: Smart debug print (variable under cursor)
map('n', '<leader>dp', function()
  local ft = vim.bo.filetype
  local word = vim.fn.expand '<cword>'
  local line

  if ft == 'python' then
    line = string.format('print(f"{%s=}")', word)
  elseif ft == 'javascript' or ft == 'typescript' then
    line = string.format("console.log('%s:', %s)", word, word)
  elseif ft == 'cpp' or ft == 'c' then
    line = string.format('std::cout << "%s: " << %s << std::endl;', word, word)
  elseif ft == 'lua' then
    line = string.format('print("%s:", %s)', word, word)
  else
    vim.notify('No debug print for ' .. ft, vim.log.levels.WARN)
    return
  end

  vim.api.nvim_put({ line }, 'l', true, true)
end, { desc = 'Insert debug print' })

-- ---------------------------------------------------------------------------
-- 5.7 Macros (Quick Recording Helpers)
-- ---------------------------------------------------------------------------
-- Note: Pre-defined macros are in lua/core/macros.lua

-- Quick macro recording to register 'q'
map('n', '<leader>qq', 'qq', { desc = 'Record macro to q' })
map('n', '<leader>qw', '@q', { desc = 'Play macro q' })
map('n', '<leader>qe', '@@', { desc = 'Replay last macro' })

-- Macro editing
map('n', '<leader>qm', function()
  local reg = vim.fn.input 'Register: '
  if reg ~= '' then
    local content = vim.fn.getreg(reg)
    local new = vim.fn.input('Edit macro: ', content)
    vim.fn.setreg(reg, new)
  end
end, { desc = 'Edit macro' })

-- ============================================================================
-- SECTION 6: VISUAL & UI TOGGLES
-- ============================================================================

-- Toggle relative line numbers
map('n', '<leader>tn', function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = 'Toggle relative numbers' })

-- Toggle line wrap
map('n', '<leader>tw', function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = 'Toggle line wrap' })

-- Toggle concealment
map('n', '<leader>tc', function()
  if vim.wo.conceallevel > 0 then
    vim.wo.conceallevel = 0
  else
    vim.wo.conceallevel = 2
  end
end, { desc = 'Toggle conceal' })

-- Toggle format on save
map('n', '<leader>xf', '<cmd>FormatToggle<CR>', { desc = 'Toggle format on save' })

-- ============================================================================
-- SECTION 7: SESSIONS & PROJECT MANAGEMENT
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 7.1 Session Management (Native)
-- ---------------------------------------------------------------------------

-- Save session for current directory (using vim.fs.* for modern file operations)
map('n', '<leader>ss', function()
  local session_dir = vim.fn.stdpath 'data' .. '/sessions'
  vim.fn.mkdir(session_dir, 'p')
  local cwd = vim.uv.cwd() or vim.fn.getcwd()
  local session_name = vim.fs.basename(cwd)
  local session_file = vim.fs.normalize(session_dir .. '/' .. session_name .. '.vim')
  vim.cmd('mksession! ' .. vim.fn.fnameescape(session_file))
  vim.notify('Session saved: ' .. session_file, vim.log.levels.INFO)
end, { desc = 'Save session' })

-- Load session for current directory (using vim.fs.* for modern file operations)
map('n', '<leader>sl', function()
  local session_dir = vim.fn.stdpath 'data' .. '/sessions'
  local cwd = vim.uv.cwd() or vim.fn.getcwd()
  local session_name = vim.fs.basename(cwd)
  local session_file = vim.fs.normalize(session_dir .. '/' .. session_name .. '.vim')
  if vim.uv.fs_stat(session_file) then
    vim.cmd('source ' .. vim.fn.fnameescape(session_file))
    vim.notify('Session loaded', vim.log.levels.INFO)
  else
    vim.notify('No session found', vim.log.levels.WARN)
  end
end, { desc = 'Load session' })

-- Delete session (using vim.fs.* for modern file operations)
map('n', '<leader>sd', function()
  local session_dir = vim.fn.stdpath 'data' .. '/sessions'
  local cwd = vim.uv.cwd() or vim.fn.getcwd()
  local session_name = vim.fs.basename(cwd)
  local session_file = vim.fs.normalize(session_dir .. '/' .. session_name .. '.vim')
  if vim.uv.fs_unlink(session_file) then
    vim.notify('Session deleted', vim.log.levels.INFO)
  else
    vim.notify('No session to delete', vim.log.levels.WARN)
  end
end, { desc = 'Delete session' })

-- Save session with custom name (using vim.fs.* for modern file operations)
map('n', '<leader>sS', function()
  vim.ui.input({ prompt = 'Session name: ' }, function(name)
    if name and name ~= '' then
      local session_dir = vim.fn.stdpath 'data' .. '/sessions'
      vim.fn.mkdir(session_dir, 'p')
      local session_file = vim.fs.normalize(session_dir .. '/' .. name .. '.vim')
      vim.cmd('mksession! ' .. vim.fn.fnameescape(session_file))
      vim.notify('Session saved: ' .. name, vim.log.levels.INFO)
    end
  end)
end, { desc = 'Save named session' })

-- Load session from list (using vim.fs.* and vim.iter for modern patterns)
map('n', '<leader>sL', function()
  local session_dir = vim.fn.stdpath 'data' .. '/sessions'
  local sessions = vim.fn.glob(session_dir .. '/*.vim', false, true)
  if #sessions == 0 then
    vim.notify('No sessions found', vim.log.levels.WARN)
    return
  end

  local items = vim
    .iter(sessions)
    :map(function(session)
      return vim.fs.basename(session):gsub('%.vim$', '')
    end)
    :totable()

  vim.ui.select(items, {
    prompt = 'Select session:',
  }, function(choice)
    if choice then
      local session_file = vim.fs.normalize(session_dir .. '/' .. choice .. '.vim')
      vim.cmd('source ' .. session_file)
      vim.notify('Session loaded: ' .. choice, vim.log.levels.INFO)
    end
  end)
end, { desc = 'Load session from list' })

-- Auto-save session on exit (user command)
vim.api.nvim_create_user_command('SessionAutoSave', function()
  vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
      local session_dir = vim.fn.stdpath 'data' .. '/sessions'
      vim.fn.mkdir(session_dir, 'p')
      local session_file = session_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. '.vim'
      vim.cmd('mksession! ' .. session_file)
    end,
  })
  vim.notify('Auto-save session enabled', vim.log.levels.INFO)
end, { desc = 'Enable auto-save on exit' })

-- ---------------------------------------------------------------------------
-- 7.2 Project Management (project_nvim Integration)
-- ---------------------------------------------------------------------------

-- Find projects
map('n', '<leader>fp', function()
  local ok, project_nvim = pcall(require, 'project_nvim')
  if not ok then
    vim.notify('project_nvim not loaded', vim.log.levels.WARN)
    return
  end
  local projects = project_nvim.get_recent_projects()
  local items = {}
  for _, project in ipairs(projects) do
    table.insert(items, vim.fn.fnamemodify(project, ':t') .. ' (' .. project .. ')')
  end
  vim.ui.select(items, {
    prompt = 'Projects:',
  }, function(choice)
    if choice then
      local path = choice:match '%((.+)%)'
      if path then
        vim.cmd('cd ' .. path)
        vim.notify('Switched to: ' .. path, vim.log.levels.INFO)
      end
    end
  end)
end, { desc = 'Find projects' })

-- Show project root
map('n', '<leader>pr', function()
  local root = require('project_nvim.project').get_project_root()
  vim.notify(root and ('Project: ' .. root) or 'No project root', root and vim.log.levels.INFO or vim.log.levels.WARN)
end, { desc = 'Show project root' })

-- CD to project root
map('n', '<leader>pc', function()
  local root = require('project_nvim.project').get_project_root()
  if root then
    vim.cmd('cd ' .. root)
    vim.notify('Changed to: ' .. root, vim.log.levels.INFO)
  end
end, { desc = 'CD to project root' })

-- ============================================================================
-- SECTION 8: PLUGIN-SPECIFIC INTEGRATIONS
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 8.1 Plugin Manager (Lazy.nvim)
-- ---------------------------------------------------------------------------

map('n', '<leader>l', '<cmd>Lazy<CR>', { desc = 'Open Lazy plugin manager' })

-- ---------------------------------------------------------------------------
-- 8.2 Code Symbols (Aerial.nvim)
-- ---------------------------------------------------------------------------

map('n', '<leader>a', '<cmd>AerialToggle!<CR>', { desc = 'Toggle code outline' })
map('n', '<leader>A', '<cmd>AerialNavToggle<CR>', { desc = 'Toggle aerial navigation' })
map('n', '[s', '<cmd>AerialPrev<CR>', { desc = 'Prev symbol' })
map('n', ']s', '<cmd>AerialNext<CR>', { desc = 'Next symbol' })

-- ---------------------------------------------------------------------------
-- 8.3 Task Runner (Overseer.nvim)
-- ---------------------------------------------------------------------------

map('n', '<leader>ot', '<cmd>OverseerToggle<CR>', { desc = 'Task: Toggle' })
map('n', '<leader>or', '<cmd>OverseerRun<CR>', { desc = 'Task: Run' })
map('n', '<leader>oo', '<cmd>OverseerOpen<CR>', { desc = 'Task: Open' })
map('n', '<leader>oq', '<cmd>OverseerQuickAction<CR>', { desc = 'Task: Quick action' })
map('n', '<leader>ob', '<cmd>OverseerBuild<CR>', { desc = 'Task: Build' })

-- ---------------------------------------------------------------------------
-- 8.4 Search & Replace (Spectre.nvim)
-- ---------------------------------------------------------------------------

map('n', '<leader>S', function()
  require('spectre').toggle()
end, { desc = 'Toggle Spectre' })

map('n', '<leader>sw', function()
  require('spectre').open_visual { select_word = true }
end, { desc = 'Search word with Spectre' })

map('v', '<leader>sw', function()
  require('spectre').open_visual()
end, { desc = 'Search selection' })

map('n', '<leader>sp', function()
  require('spectre').open_file_search { select_word = true }
end, { desc = 'Search in current file' })

-- ---------------------------------------------------------------------------
-- 8.5 Markdown (Markdown Preview & Helpers)
-- ---------------------------------------------------------------------------

map('n', '<leader>mp', '<cmd>PeekOpen<CR>', { desc = 'Markdown: Preview open' })
map('n', '<leader>mc', '<cmd>PeekClose<CR>', { desc = 'Markdown: Preview close' })

-- Markdown-specific keymaps (buffer-local, activated on markdown files)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    local opts = { buffer = true }

    -- Text formatting
    vim.keymap.set('v', '<C-b>', function()
      vim.cmd 'normal! `<i**`>la**'
    end, vim.tbl_extend('force', opts, { desc = 'Bold selection' }))

    vim.keymap.set('v', '<C-i>', function()
      vim.cmd 'normal! `<i*`>la*'
    end, vim.tbl_extend('force', opts, { desc = 'Italic selection' }))

    -- Insert link
    vim.keymap.set('n', '<leader>il', function()
      local text, url = vim.fn.input 'Text: ', vim.fn.input 'URL: '
      if url ~= '' then
        vim.api.nvim_put({ string.format('[%s](%s)', text, url) }, 'c', true, true)
      end
    end, vim.tbl_extend('force', opts, { desc = 'Insert link' }))

    -- Insert code block
    vim.keymap.set('n', '<leader>ic', function()
      local lang = vim.fn.input 'Language: '
      vim.api.nvim_put({ '```' .. lang, '', '```' }, 'l', true, true)
      vim.cmd 'normal! k'
    end, vim.tbl_extend('force', opts, { desc = 'Insert code block' }))

    -- Heading shortcuts (H1-H6)
    for i = 1, 6 do
      vim.keymap.set('n', '<leader>h' .. i, function()
        local line = vim.api.nvim_get_current_line():gsub('^#* *', '')
        vim.api.nvim_set_current_line(string.rep('#', i) .. ' ' .. line)
      end, vim.tbl_extend('force', opts, { desc = 'Heading ' .. i }))
    end

    -- Table of contents
    vim.keymap.set('n', '<leader>mg', '<cmd>GenTocGFM<CR>', vim.tbl_extend('force', opts, { desc = 'Generate TOC' }))
    vim.keymap.set('n', '<leader>mu', '<cmd>UpdateToc<CR>', vim.tbl_extend('force', opts, { desc = 'Update TOC' }))
  end,
})

-- ---------------------------------------------------------------------------
-- 8.6 Native Snippet Navigation (Neovim 0.10+)
-- ---------------------------------------------------------------------------

map({ 'i', 's' }, '<Tab>', function()
  if vim.snippet.active { direction = 1 } then
    return '<cmd>lua vim.snippet.jump(1)<CR>'
  end
  return '<Tab>'
end, { expr = true, desc = 'Snippet: Next or Tab' })

map({ 'i', 's' }, '<S-Tab>', function()
  if vim.snippet.active { direction = -1 } then
    return '<cmd>lua vim.snippet.jump(-1)<CR>'
  end
  return '<S-Tab>'
end, { expr = true, desc = 'Snippet: Prev or S-Tab' })

-- ============================================================================
-- SECTION 9: AUTO-FEATURES (Background Enhancements)
-- ============================================================================

-- Create augroup for better organization and performance
local augroup = vim.api.nvim_create_augroup('UserConfigAutoFeatures', { clear = true })

-- ---------------------------------------------------------------------------
-- 9.1 Unified Cursor Word Highlight (LSP + Fallback)
-- ---------------------------------------------------------------------------
-- Single autocmd that handles both LSP document highlight and non-LSP fallback
-- Optimized to avoid duplicate autocmds (saves ~2-5ms per trigger)

vim.api.nvim_create_autocmd('CursorHold', {
  group = augroup,
  callback = function()
    local clients = vim.lsp.get_clients { bufnr = 0 }

    -- Check if any client supports document highlight
    local has_document_highlight = false
    for _, client in ipairs(clients) do
      if client.supports_method 'textDocument/documentHighlight' then
        has_document_highlight = true
        break
      end
    end

    if has_document_highlight then
      -- Use LSP document highlight
      vim.lsp.buf.document_highlight()
    elseif #clients == 0 then
      -- Fallback to matchadd for non-LSP buffers
      vim.fn.matchadd('Search', '\\<' .. vim.fn.expand '<cword>' .. '\\>')
    end
  end,
})

vim.api.nvim_create_autocmd('CursorMoved', {
  group = augroup,
  callback = function()
    local clients = vim.lsp.get_clients { bufnr = 0 }

    -- Check if any client supports document highlight
    local has_document_highlight = false
    for _, client in ipairs(clients) do
      if client.supports_method 'textDocument/documentHighlight' then
        has_document_highlight = true
        break
      end
    end

    if has_document_highlight then
      -- Clear LSP references
      vim.lsp.buf.clear_references()
    elseif #clients == 0 then
      -- Clear matchadd highlights
      vim.fn.clearmatches()
    end
  end,
})

-- ---------------------------------------------------------------------------
-- 9.2 Auto-Save on Focus Lost
-- ---------------------------------------------------------------------------
-- Automatically saves all buffers when switching to another application
-- Modern editor behavior - never lose work when multitasking

vim.api.nvim_create_autocmd('FocusLost', {
  group = augroup,
  callback = function()
    vim.cmd 'silent! wa'
  end,
})

-- Note: Auto-save on buffer switch is handled by 'autowrite' option in options.lua

-- ============================================================================
-- NATIVE NEOVIM 0.11+ DEFAULTS (No Keymaps Needed)
-- ============================================================================
--
-- These features are available by default in Neovim 0.11+ and don't require
-- custom keymaps. They're documented here for reference:
--
-- LSP (Native):
--   grn           → Rename symbol
--   grr           → Find references
--   gri           → Go to implementation
--   gra           → Code action
--   gO            → Document symbols
--   K             → Hover documentation
--   <C-S>         → Signature help
--
-- Diagnostics (Native):
--   [d            → Previous diagnostic
--   ]d            → Next diagnostic
--
-- Treesitter (Configured in tree-sitter.lua):
--   ]f / [f       → Next/prev function
--   ]c / [c       → Next/prev class (also used for diff hunks)
--   af / if       → Around/inside function
--   ac / ic       → Around/inside class
--   as / is       → Around/inside statement
--   ai / ii       → Around/inside conditional
--   al / il       → Around/inside loop
--   aa / ia       → Around/inside parameter
--   ab / ib       → Around/inside block
--   aC / iC       → Around/inside comment
--
-- Native Text Objects:
--   iw / aw       → Inside/around word
--   i" / a"       → Inside/around quotes
--   i( / a(       → Inside/around parentheses
--   i{ / a{       → Inside/around braces
--   it / at       → Inside/around tags
--   ip / ap       → Inside/around paragraph
--
-- Visual Block:
--   <C-v>         → Enter visual block mode
--   I / A         → Insert at column start/end
--   r             → Replace character
--
-- ============================================================================
-- END OF KEYMAPS CONFIGURATION
-- ============================================================================
--
-- Total Keymaps: 160+
-- Performance: <5ms overhead
-- Organization: 9 logical sections
-- Compatibility: Neovim 0.11+
-- Plugin Dependencies: Minimal (most are native)
--
-- For LSP-specific keymaps, see: lua/plugins/language.lua
-- For pre-defined macros, see: lua/core/macros.lua
-- For which-key group names, see: lua/plugins/which-key.lua
--
-- ============================================================================
