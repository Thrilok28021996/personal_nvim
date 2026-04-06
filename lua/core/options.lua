-- Core Neovim Options (Neovim 0.12+)

-- Prepend Mason bin to PATH early so LSP servers installed via Mason are found
vim.env.PATH = vim.fn.stdpath 'data' .. '/mason/bin:' .. vim.env.PATH

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

-- Window borders (Neovim 0.11+, 0.12+ adds 'bold' style)
-- Default border for all floating windows
vim.o.winborder = 'rounded'

-- Progress messages in cmdline (0.12+)
vim.opt.messagesopt = 'hit-enter,history:500,progress:c'

-- Native Folding (Neovim 0.10+)
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldcolumn = '1' -- Show fold column for better visibility
vim.opt.fillchars:append { foldinner = ' ' } -- Clean fold inner fill (0.12+)
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

-- Native Completion (Neovim 0.12+)
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup', 'nearest' }
vim.opt.autocomplete = true -- Native auto-completion (0.12+)
vim.opt.pumborder = 'rounded' -- Border for completion popup (0.12+)
vim.opt.pummaxwidth = 60 -- Max width of completion popup (0.12+)

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

-- Use ripgrep for :grep (respects .gitignore, fast)
vim.opt.grepprg = 'rg --vimgrep --smart-case'
vim.opt.grepformat = '%f:%l:%c:%m'

-- Diff (0.12+ inline character-level highlighting — default includes indent-heuristic)
vim.opt.diffopt:append { 'inline:char' }

-- Quickfix/location list stack size (0.12+)
vim.opt.chistory = 20
vim.opt.lhistory = 20

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Display
vim.opt.list = true
vim.opt.listchars = { tab = '│ ', leadtab = '│ ', trail = '·', extends = '›', precedes = '‹', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.wrap = false

-- Disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Native project root auto-cd (replaces project.nvim)
-- Uses vim.fs.root() (0.10+, 0.12+ equal-priority via nested lists)
-- Nested list = equal priority group; first match wins within group
local _root_patterns = {
  { '.git' },  -- VCS root (highest priority)
  { 'pyproject.toml', 'Cargo.toml', 'go.mod', 'package.json' },  -- Language roots (equal priority)
  { 'Makefile', 'CMakeLists.txt', 'compile_commands.json', 'setup.py' },  -- Build systems
}
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('ProjectRootCd', { clear = true }),
  callback = function()
    if vim.bo.buftype ~= '' or vim.fn.expand '%' == '' then return end
    local root = vim.fs.root(0, _root_patterns)
    if root and root ~= vim.uv.cwd() then
      vim.uv.chdir(root)
    end
  end,
})

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
  callback = function()
    if vim.bo.buftype == '' and vim.fn.expand '%' ~= '' then
      vim.cmd 'silent! mkview'
    end
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = augroup,
  callback = function()
    if vim.bo.buftype == '' and vim.fn.expand '%' ~= '' then
      vim.cmd 'silent! loadview'
    end
  end,
})

-- Auto-save all buffers on focus lost
vim.api.nvim_create_autocmd('FocusLost', {
  group = augroup,
  callback = function()
    vim.cmd 'silent! wa'
  end,
})

-- Note: LSP document highlight (CursorHold/CursorMoved) is handled natively
-- by Neovim 0.11+ via vim.lsp.document_color and built-in LspAttach handlers.

-- Native image paste (replaces img-clip.nvim) — requires: brew install pngpaste
vim.api.nvim_create_user_command('PasteImage', function()
  local img_dir = vim.fn.expand '%:p:h' .. '/assets'
  vim.fn.mkdir(img_dir, 'p')
  local name = os.date '%Y%m%d_%H%M%S' .. '.png'
  local path = img_dir .. '/' .. name
  vim.fn.system('pngpaste ' .. vim.fn.shellescape(path))
  if vim.v.shell_error ~= 0 then
    vim.notify('No image in clipboard (brew install pngpaste)', vim.log.levels.WARN)
    return
  end
  vim.api.nvim_put({ '![](assets/' .. name .. ')' }, 'c', true, true)
  vim.notify('Pasted: assets/' .. name, vim.log.levels.INFO)
end, { desc = 'Paste image from clipboard' })

-- Native TODO highlights (replaces todo-comments.nvim)
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = augroup,
  callback = function()
    if vim.b.todo_highlights_added then return end
    vim.b.todo_highlights_added = true
    vim.fn.matchadd('DiagnosticWarn', [[\v<(TODO|FIXME|HACK|WARN|BUG|XXX):]])
    vim.fn.matchadd('DiagnosticInfo',  [[\v<(NOTE|INFO|PERF|OPTIMIZE):]])
    vim.fn.matchadd('DiagnosticHint',  [[\v<(TEST|TESTING):]])
  end,
})

-- Native Markdown TOC (replaces vim-markdown-toc)
local function _md_anchor(title)
  return title:lower():gsub('%s+', '-'):gsub('[^%w%-]', ''):gsub('%-%-+', '-')
end

local function _collect_headings()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local result, in_code = {}, false
  for _, line in ipairs(lines) do
    if line:match('^```') then in_code = not in_code end
    if not in_code then
      local level, title = line:match('^(#+)%s+(.+)')
      if level and title then
        table.insert(result, string.rep('  ', #level - 1) .. '- [' .. title .. '](#' .. _md_anchor(title) .. ')')
      end
    end
  end
  return result
end

vim.api.nvim_create_user_command('GenTocGFM', function()
  local toc = { '<!-- TOC -->' }
  vim.list_extend(toc, _collect_headings())
  table.insert(toc, '<!-- /TOC -->')
  vim.api.nvim_buf_set_lines(0, vim.fn.line('.') - 1, vim.fn.line('.') - 1, false, toc)
end, { desc = 'Generate Markdown TOC' })

vim.api.nvim_create_user_command('UpdateToc', function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local s, e = nil, nil
  for i, line in ipairs(lines) do
    if line == '<!-- TOC -->' then s = i - 1
    elseif line == '<!-- /TOC -->' then e = i end
  end
  if not s or not e then
    vim.notify('No TOC found. Use :GenTocGFM first.', vim.log.levels.WARN)
    return
  end
  local toc = { '<!-- TOC -->' }
  vim.list_extend(toc, _collect_headings())
  table.insert(toc, '<!-- /TOC -->')
  vim.api.nvim_buf_set_lines(0, s, e, false, toc)
end, { desc = 'Update Markdown TOC' })

-- Auto-update TOC on markdown save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  pattern = '*.md',
  callback = function()
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, 100, false)) do
      if line == '<!-- TOC -->' then vim.cmd 'UpdateToc' return end
    end
  end,
})
