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
--   4. Code Features (folding, diagnostics, quickfix, spell, refactoring)
--   5. Development Tools (testing, debugging, terminal, execution)
--   6. Visual & UI Toggles
--   7. Sessions & Project Management
--   8. Plugin Integrations (LSP, AI, git, formatting, etc.)
--
-- Total: 180+ keymaps covering all IDE needs
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

-- Search word in project (fzf-lua)
map('n', '<leader>*', '<cmd>FzfLua grep_cword<cr>', { desc = 'Search word in project' })

-- Search in current buffer (fzf-lua)
map('n', '<leader>/', '<cmd>FzfLua grep_curbuf<cr>', { desc = 'Search in current buffer' })

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
map('n', ']<Space>', 'o<Esc>', { desc = 'Insert line below' })
map('n', '[<Space>', 'O<Esc>', { desc = 'Insert line above' })

-- Join lines (keep cursor position)
map('n', 'J', 'mzJ`z', { desc = 'Join lines (keep cursor)' })

-- Increment/decrement numbers
map('n', '+', '<C-a>', { desc = 'Increment number' })
-- Note: '-' is mapped to Oil (open parent directory) in Section 3.3

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
map('n', '<leader>wv', '<C-w>v', { desc = 'Split vertical' })
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

-- Fuzzy file finding (fzf-lua)
map('n', '<leader>ff', '<cmd>FzfLua files<cr>', { desc = 'Find files' })
map('n', '<leader>fw', '<cmd>FzfLua live_grep<cr>', { desc = 'Find word in files' })
map('n', '<leader>fb', '<cmd>FzfLua buffers<cr>', { desc = 'Find buffers' })
map('n', '<leader>fr', '<cmd>FzfLua oldfiles<cr>', { desc = 'Find recent files' })

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
map('n', "<leader>'", '<cmd>FzfLua marks<cr>', { desc = 'Browse marks' })
map('n', '<leader>M', '<cmd>delmarks!<CR>', { desc = 'Delete all marks' })
map('n', 'dm', '<cmd>delmarks ', { desc = 'Delete specific mark' })

-- Registers
map('n', '<leader>"', '<cmd>FzfLua registers<cr>', { desc = 'Browse registers' })
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
-- Note: Core LSP keymaps are in Section 8.7 (LspAttach callback)
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

-- Note: Format buffer/selection is handled by Conform (Section 8.13)

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
map('n', '<leader>gd', '<cmd>windo diffthis<CR>', { desc = 'Enable diff mode' })
map('n', '<leader>gD', '<cmd>windo diffoff<CR>', { desc = 'Disable diff mode' })

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
-- 5.1 Debugging (nvim-dap Integration)
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
map('n', '<leader>fX', function()
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

-- C/C++: Toggle between header and source file (using vim.fs.find)
map('n', '<leader>ch', function()
  local ext = vim.fn.expand '%:e'
  local name = vim.fn.expand '%:t:r'
  local dir = vim.fn.expand '%:p:h'
  local candidates

  if ext == 'cpp' or ext == 'cc' or ext == 'c' then
    candidates = { name .. '.h', name .. '.hpp' }
  elseif ext == 'h' or ext == 'hpp' then
    candidates = { name .. '.cpp', name .. '.cc', name .. '.c' }
  else
    vim.notify('Not a C/C++ file', vim.log.levels.WARN)
    return
  end

  local found = vim.fs.find(candidates, { path = dir, upward = true, limit = 1 })
  if #found > 0 then
    vim.cmd('edit ' .. found[1])
  else
    vim.notify('Corresponding file not found', vim.log.levels.WARN)
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

-- Toggle zen mode
map('n', '<leader>tz', '<cmd>ZenMode<cr>', { desc = 'Toggle Zen Mode' })

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
-- 7.2 Project Management (Native vim.fs.root - 0.10+)
-- ---------------------------------------------------------------------------

local _root_patterns = { '.git', 'Makefile', 'package.json', 'setup.py', 'pyproject.toml', 'Cargo.toml', 'go.mod', 'CMakeLists.txt', 'compile_commands.json' }

-- Show project root
map('n', '<leader>pr', function()
  local root = vim.fs.root(0, _root_patterns)
  vim.notify(root and ('Project: ' .. root) or 'No project root', root and vim.log.levels.INFO or vim.log.levels.WARN)
end, { desc = 'Show project root' })

-- CD to project root
map('n', '<leader>pc', function()
  local root = vim.fs.root(0, _root_patterns)
  if root then
    vim.uv.chdir(root)
    vim.notify('Changed to: ' .. root, vim.log.levels.INFO)
  end
end, { desc = 'CD to project root' })

-- Browse recent project roots (derived from oldfiles via vim.fs.root)
map('n', '<leader>fp', function()
  local seen, dirs = {}, {}
  for _, file in ipairs(vim.v.oldfiles) do
    local root = vim.fs.root(file, _root_patterns)
    if root and not seen[root] and vim.uv.fs_stat(root) then
      seen[root] = true
      table.insert(dirs, root)
    end
    if #dirs >= 20 then break end
  end
  if #dirs == 0 then
    vim.notify('No recent projects', vim.log.levels.WARN)
    return
  end
  vim.ui.select(dirs, { prompt = 'Projects:' }, function(choice)
    if choice then
      vim.uv.chdir(choice)
      vim.notify('Switched to: ' .. choice, vim.log.levels.INFO)
    end
  end)
end, { desc = 'Find recent projects' })

-- ============================================================================
-- SECTION 8: PLUGIN-SPECIFIC INTEGRATIONS
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 8.1 Plugin Manager (Lazy.nvim)
-- ---------------------------------------------------------------------------

map('n', '<leader>L', '<cmd>Lazy<CR>', { desc = 'Open Lazy plugin manager' })

-- ---------------------------------------------------------------------------
-- 8.3 Task Runner (Overseer.nvim)
-- ---------------------------------------------------------------------------

map('n', '<leader>ot', '<cmd>OverseerToggle<CR>', { desc = 'Task: Toggle' })
map('n', '<leader>or', '<cmd>OverseerRun<CR>', { desc = 'Task: Run' })
map('n', '<leader>oo', '<cmd>OverseerOpen<CR>', { desc = 'Task: Open' })
map('n', '<leader>oc', '<cmd>OverseerClose<CR>', { desc = 'Task: Close' })
map('n', '<leader>oq', '<cmd>OverseerQuickAction<CR>', { desc = 'Task: Quick action' })
map('n', '<leader>oa', '<cmd>OverseerTaskAction<CR>', { desc = 'Task: Actions' })
map('n', '<leader>ob', '<cmd>OverseerBuild<CR>', { desc = 'Task: Build' })
map('n', '<leader>oi', '<cmd>OverseerInfo<CR>', { desc = 'Task: Info' })

-- ---------------------------------------------------------------------------
-- 8.5 Markdown (Markdown Preview & Helpers)
-- ---------------------------------------------------------------------------

map('n', '<leader>mp', '<cmd>PeekOpen<CR>', { desc = 'Markdown: Preview open' })
map('n', '<leader>mc', '<cmd>PeekClose<CR>', { desc = 'Markdown: Preview close' })
map('n', '<leader>mi', '<cmd>PasteImage<cr>', { desc = 'Markdown: Paste image' })

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

-- ---------------------------------------------------------------------------
-- 8.7 LSP Setup (Buffer-local keymaps & features via LspAttach)
-- ---------------------------------------------------------------------------
-- Single LspAttach callback for all buffer-local LSP setup:
-- keymaps, inlay hints, code lens auto-refresh, semantic tokens.
-- Server configs and diagnostics are in lua/plugins/language.lua.

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspSetup', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf
    if not client then
      return
    end

    -- Native LSP completion (Neovim 0.11+ - replaces blink.cmp)
    vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })

    local opts = { buffer = buf, silent = true }

    -- Navigation (fzf-lua pickers for multi-result LSP queries)
    map('n', 'gd', function()
      require('fzf-lua').lsp_definitions()
    end, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
    map('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))
    map('n', 'gy', function()
      require('fzf-lua').lsp_typedefs()
    end, vim.tbl_extend('force', opts, { desc = 'Go to type definition' }))
    map('n', 'gO', function()
      require('fzf-lua').lsp_document_symbols()
    end, vim.tbl_extend('force', opts, { desc = 'Document symbols' }))
    map('n', 'grr', function()
      require('fzf-lua').lsp_references()
    end, vim.tbl_extend('force', opts, { desc = 'Find references' }))
    map('n', 'gri', function()
      require('fzf-lua').lsp_implementations()
    end, vim.tbl_extend('force', opts, { desc = 'Go to implementation' }))

    -- Diagnostics
    map('n', '<leader>dd', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'Show diagnostics float' }))
    map('n', '<leader>ql', vim.diagnostic.setloclist, vim.tbl_extend('force', opts, { desc = 'Diagnostics to loclist' }))

    -- Workspace & Call Hierarchy (fzf-lua pickers)
    map('n', '<leader>ws', function()
      require('fzf-lua').lsp_workspace_symbols()
    end, vim.tbl_extend('force', opts, { desc = 'Workspace symbols' }))
    map('n', '<leader>cI', function()
      require('fzf-lua').lsp_incoming_calls()
    end, vim.tbl_extend('force', opts, { desc = 'Incoming calls' }))
    map('n', '<leader>co', function()
      require('fzf-lua').lsp_outgoing_calls()
    end, vim.tbl_extend('force', opts, { desc = 'Outgoing calls' }))

    -- Signature help in insert mode
    map('i', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature help' }))

    -- Toggle inlay hints
    map('n', '<leader>ih', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf }, { bufnr = buf })
    end, vim.tbl_extend('force', opts, { desc = 'Toggle inlay hints' }))

    -- Auto-enable inlay hints (if supported)
    if client:supports_method 'textDocument/inlayHint' then
      vim.lsp.inlay_hint.enable(true, { bufnr = buf })
    end

    -- Code Lens: keymaps + auto-refresh (if supported)
    if client:supports_method 'textDocument/codeLens' then
      map('n', '<leader>cl', vim.lsp.codelens.run, vim.tbl_extend('force', opts, { desc = 'Run code lens' }))
      map('n', '<leader>cL', vim.lsp.codelens.refresh, vim.tbl_extend('force', opts, { desc = 'Refresh code lens' }))
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        buffer = buf,
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })
    end

    -- Semantic Tokens (Neovim 0.11+)
    if client:supports_method 'textDocument/semanticTokens' then
      vim.lsp.semantic_tokens.start(buf, client.id)
    end
  end,
})

-- ---------------------------------------------------------------------------
-- 8.8 AI Assistant (CodeCompanion)
-- ---------------------------------------------------------------------------

map({ 'n', 'v' }, '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'AI: Toggle Chat' })
map({ 'n', 'v' }, '<leader>ca', '<cmd>CodeCompanionActions<cr>', { desc = 'AI: Actions' })
map({ 'n', 'v' }, '<leader>ci', '<cmd>CodeCompanion<cr>', { desc = 'AI: Inline Prompt' })
map('v', '<leader>cx', '<cmd>CodeCompanionChat Add<cr>', { desc = 'AI: Add to Chat' })

-- Command abbreviation: type :cc in command mode to expand to CodeCompanion
vim.cmd [[cab cc CodeCompanion]]

-- ---------------------------------------------------------------------------
-- 8.9 Git (LazyGit)
-- ---------------------------------------------------------------------------

map('n', '<leader>lg', function()
  local buf = vim.api.nvim_create_buf(false, true)
  local w = math.floor(vim.o.columns * 0.92)
  local h = math.floor(vim.o.lines * 0.88)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor', style = 'minimal', border = 'rounded',
    width = w, height = h,
    row = math.floor((vim.o.lines - h) / 2),
    col = math.floor((vim.o.columns - w) / 2),
  })
  vim.fn.termopen('lazygit', {
    on_exit = function()
      if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    end,
  })
  vim.cmd 'startinsert'
end, { desc = 'LazyGit' })

-- ---------------------------------------------------------------------------
-- 8.11 Git Links (Native - replaces gitlinker.nvim)
-- ---------------------------------------------------------------------------

local function git_permalink(open, blame)
  local cwd = vim.fn.expand '%:p:h'
  local root = vim.fn.system('git -C ' .. vim.fn.shellescape(cwd) .. ' rev-parse --show-toplevel'):gsub('%s+$', '')
  if vim.v.shell_error ~= 0 then
    vim.notify('Not in a git repo', vim.log.levels.WARN)
    return
  end
  local commit = vim.fn.system('git -C ' .. vim.fn.shellescape(root) .. ' rev-parse HEAD'):gsub('%s+$', '')
  local remote = vim.fn.system('git -C ' .. vim.fn.shellescape(root) .. ' remote get-url origin'):gsub('%s+$', '')
  remote = remote:gsub('git@([^:]+):', 'https://%1/')
  remote = remote:gsub('%.git$', '')
  local rel = vim.fn.expand('%:p'):sub(#root + 2)
  local line1, line2 = vim.fn.line 'v', vim.fn.line '.'
  if line1 > line2 then line1, line2 = line2, line1 end
  local line_ref = line1 == line2 and ('#L' .. line1) or ('#L' .. line1 .. '-L' .. line2)
  local url = remote .. (blame and '/blame/' or '/blob/') .. commit .. '/' .. rel .. line_ref
  if open then
    vim.ui.open(url)
  else
    vim.fn.setreg('+', url)
    vim.notify('Copied: ' .. url, vim.log.levels.INFO)
  end
end

map({ 'n', 'v' }, '<leader>gy', function() git_permalink(false, false) end, { desc = 'Yank git permalink' })
map({ 'n', 'v' }, '<leader>gY', function() git_permalink(true, false) end, { desc = 'Open git permalink' })
map({ 'n', 'v' }, '<leader>gb', function() git_permalink(false, true) end, { desc = 'Yank git blame link' })
map({ 'n', 'v' }, '<leader>gB', function() git_permalink(true, true) end, { desc = 'Open git blame' })

-- ---------------------------------------------------------------------------
-- 8.12 TODO Comments (Native - replaces todo-comments.nvim)
-- ---------------------------------------------------------------------------

local _todo_pat = [[\v<(TODO|FIXME|HACK|WARN|BUG|NOTE|PERF|TEST):]]
map('n', ']T', function() vim.fn.search(_todo_pat, 'W') end, { desc = 'Next TODO' })
map('n', '[T', function() vim.fn.search(_todo_pat, 'Wb') end, { desc = 'Prev TODO' })
map('n', '<leader>ft', '<cmd>FzfLua grep { search = "TODO:|FIXME:|HACK:|WARN:|PERF:|NOTE:|TEST:" }<CR>', { desc = 'Find TODOs (fzf)' })

-- ---------------------------------------------------------------------------
-- 8.13 Autoformat (Conform)
-- ---------------------------------------------------------------------------

map({ 'n', 'v' }, '<leader>cf', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = 'Format buffer' })

-- ---------------------------------------------------------------------------
-- 8.15 Fuzzy Finder (fzf-lua)
-- ---------------------------------------------------------------------------

map('n', '<leader>fh', '<cmd>FzfLua helptags<cr>', { desc = 'Search help tags' })
map('n', '<leader>fk', '<cmd>FzfLua keymaps<cr>', { desc = 'Search keymaps' })
map('n', '<leader>fd', function()
  require('fzf-lua').diagnostics_document()
end, { desc = 'Search diagnostics (file)' })
map('n', '<leader>fD', function()
  require('fzf-lua').diagnostics_workspace()
end, { desc = 'Search diagnostics (workspace)' })
map('n', '<leader>fs', function()
  require('fzf-lua').lsp_document_symbols()
end, { desc = 'Search symbols (file)' })
map('n', '<leader>fS', function()
  require('fzf-lua').lsp_workspace_symbols()
end, { desc = 'Search symbols (workspace)' })
map('n', '<leader>fg', '<cmd>FzfLua git_status<cr>', { desc = 'Git changed files' })
map('n', '<leader>f/', '<cmd>FzfLua search_history<cr>', { desc = 'Search history' })
map('n', '<leader>fc', '<cmd>FzfLua command_history<cr>', { desc = 'Command history' })
map('v', '<leader>*', '<cmd>FzfLua grep_visual<cr>', { desc = 'Grep visual selection' })

-- ---------------------------------------------------------------------------
-- 8.16 Gitsigns (buffer-local, set via on_attach)
-- ---------------------------------------------------------------------------
-- Called by gitsigns on_attach — keymaps only exist in git-tracked buffers.

function _G.gitsigns_on_attach(bufnr)
  local gs = require 'gitsigns'
  local function bmap(mode, l, r, desc)
    map(mode, l, r, { buffer = bufnr, desc = desc })
  end

  -- Navigation
  bmap('n', ']h', gs.next_hunk, 'Next hunk')
  bmap('n', '[h', gs.prev_hunk, 'Prev hunk')

  -- Actions
  bmap({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', 'Stage hunk')
  bmap({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', 'Reset hunk')
  bmap('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
  bmap('n', '<leader>hu', gs.undo_stage_hunk, 'Undo stage hunk')
  bmap('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
  bmap('n', '<leader>hb', function() gs.blame_line { full = true } end, 'Blame line')
  bmap('n', '<leader>hd', gs.diffthis, 'Diff this')
  bmap('n', '<leader>hB', function() gs.toggle_current_line_blame() end, 'Toggle line blame')
end

-- ---------------------------------------------------------------------------
-- 8.17 Linting (nvim-lint)
-- ---------------------------------------------------------------------------

map('n', '<leader>xL', function()
  require('lint').try_lint()
end, { desc = 'Lint current file' })

-- ============================================================================
-- END OF KEYMAPS
-- ============================================================================
--
-- All keymaps centralized here (single source of truth).
-- Auto-features (cursor highlight, auto-save, project root) are in lua/core/options.lua.
-- Pre-defined macros are in lua/core/macros.lua.
-- LSP server configs and diagnostics are in lua/plugins/language.lua.
-- Treesitter text objects are in lua/notemd/tree-sitter.lua.
-- Plugin-internal keymaps (Oil, Overseer, DAP UI, mkdnflow
-- buffers) stay in their respective plugin files.
-- Gitsigns on_attach keymaps are defined here (Section 8.16) and referenced
-- from lua/plugins/git-signs.lua.
-- vim-visual-multi config (vim.g.VM_maps) is in lua/plugins/multicursor.lua.
--
-- Native Neovim 0.11+ defaults (no custom keymaps needed):
--   grn  → Rename symbol       grr  → Find references
--   gri  → Go to implementation gra  → Code action
--   K    → Hover docs          <C-S> → Signature help
--   [d / ]d → Prev/next diagnostic
--
-- ============================================================================
