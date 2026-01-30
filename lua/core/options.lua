-- Core Neovim Options

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Mouse & UI
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Window borders (Neovim 0.11+)
-- Default border for all floating windows
vim.o.winborder = 'rounded'

-- Native Folding (Neovim 0.10+)
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldcolumn = '1' -- Show fold column for better visibility
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Custom foldtext for better fold display (0.11+)
function _G.custom_foldtext()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  return string.format('  %s ... (%d lines)', line, line_count)
end
vim.opt.foldtext = 'v:lua.custom_foldtext()'

-- Native Completion (Neovim 0.11+)
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'fuzzy' }

-- Command-line completion enhancements (0.11+)
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildoptions = 'pum,fuzzy' -- Popup menu with fuzzy matching
vim.opt.wildignorecase = true
vim.opt.wildignore = {
  '*.o', '*.obj', '*~', '*.pyc', '*.class',
  '*/.git/*', '*/.hg/*', '*/.svn/*',
  '*/node_modules/*', '*/__pycache__/*',
  '*.swp', '*.swo', '*.bak',
}

-- Auto-save on buffer switch/window leave (0.11+)
vim.opt.autowrite = true
vim.opt.autowriteall = false -- Don't save on suspend

-- Status column for unified left-side UI (0.11+)
-- Shows line numbers, fold markers, and signs in one column
vim.opt.statuscolumn = '%s%=%{v:relnum?v:relnum:v:lnum} '

-- Clipboard (scheduled to reduce startup time)
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Indentation
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Undo & Backup
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.lazyredraw = true -- Improves performance during macros/commands

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Display
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.wrap = false

-- Disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Create augroup for better organization
local augroup = vim.api.nvim_create_augroup('UserConfigOptions', { clear = true })

-- Markdown-specific settings
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'markdown',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 80
    vim.opt_local.conceallevel = 2
  end,
})

-- Terminal improvements (Neovim 0.11+)
vim.api.nvim_create_autocmd('TermOpen', {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.scrolloff = 0
  end,
})

-- Persistent cursor position and folds (native)
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-save views for folds
vim.opt.viewoptions = 'cursor,folds,slash,unix'
vim.api.nvim_create_autocmd('BufWinLeave', {
  group = augroup,
  pattern = '*.*',
  callback = function()
    if vim.bo.buftype == '' and vim.fn.expand '%' ~= '' then
      vim.cmd 'silent! mkview'
    end
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = augroup,
  pattern = '*.*',
  callback = function()
    if vim.bo.buftype == '' and vim.fn.expand '%' ~= '' then
      vim.cmd 'silent! loadview'
    end
  end,
})
