-- Core Neovim Options (Neovim 0.12+)

-- Prepend Mason bin to PATH early so LSP servers are found
vim.env.PATH = vim.fn.stdpath 'data' .. '/mason/bin:' .. vim.env.PATH

local augroup = vim.api.nvim_create_augroup('UserOptions', { clear = true })

-- ── Numbers & UI ─────────────────────────────────────────────────────────────
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.mouse          = 'a'
vim.opt.showmode       = false
vim.opt.termguicolors  = true
vim.opt.cursorline     = true
vim.opt.signcolumn     = 'yes'
vim.opt.scrolloff      = 10
vim.opt.sidescrolloff  = 8
vim.opt.winborder      = 'rounded'
vim.opt.statuscolumn   = '%s%=%{v:relnum?v:relnum:v:lnum} '
vim.opt.showtabline    = 2

-- ── Messages ──────────────────────────────────────────────────────────────────
vim.opt.messagesopt = 'hit-enter,history:500,progress:c'

-- ── Folding ───────────────────────────────────────────────────────────────────
vim.opt.foldmethod    = 'expr'
vim.opt.foldexpr      = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldcolumn    = '1'
vim.opt.foldlevel     = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable    = true
vim.opt.fillchars:append { foldinner = ' ' }

function _G.custom_foldtext()
  local line = vim.fn.getline(vim.v.foldstart)
  local count = vim.v.foldend - vim.v.foldstart + 1
  return string.format('  %s ... (%d lines)', line, count)
end
vim.opt.foldtext = 'v:lua.custom_foldtext()'

-- ── Native Completion ─────────────────────────────────────────────────────────
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup', 'nearest' }
vim.opt.autocomplete = true
vim.opt.pumborder    = 'rounded'
vim.opt.pummaxwidth  = 60

-- ── Command-line Completion ───────────────────────────────────────────────────
vim.opt.wildmenu       = true
vim.opt.wildmode       = 'longest:full,full'
vim.opt.wildoptions    = 'pum,fuzzy'
vim.opt.wildignorecase = true
vim.opt.wildignore     = {
  '*.o', '*.obj', '*~', '*.pyc', '*.class',
  '*/.git/*', '*/.hg/*', '*/.svn/*',
  '*/node_modules/*', '*/__pycache__/*',
  '*.swp', '*.swo', '*.bak',
}

-- ── Editing ───────────────────────────────────────────────────────────────────
vim.opt.breakindent  = true
vim.opt.smartindent  = true
vim.opt.expandtab    = true
vim.opt.shiftwidth   = 2
vim.opt.tabstop      = 2
vim.opt.autowrite    = true
vim.opt.autowriteall = true
vim.opt.autoread     = true

-- ── Undo & Backup ────────────────────────────────────────────────────────────
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup   = false

-- ── Search ────────────────────────────────────────────────────────────────────
vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.hlsearch   = true
vim.opt.incsearch  = true
vim.opt.grepprg    = 'rg --vimgrep --smart-case'
vim.opt.grepformat = '%f:%l:%c:%m'

-- ── Diff & Lists ─────────────────────────────────────────────────────────────
-- Note: 'diffopt' already includes "indent-heuristic" and "inline:char" by default in 0.12
vim.opt.chistory        = 20
vim.opt.lhistory        = 20
vim.opt.maxsearchcount  = 9999
vim.opt.jumpoptions:append 'view'

-- ── Performance & Splits ──────────────────────────────────────────────────────
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ── Display ───────────────────────────────────────────────────────────────────
vim.opt.list      = true
vim.opt.listchars = { tab = '│ ', leadtab = '│ ', trail = '·', extends = '›', precedes = '‹', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.wrap       = false
vim.opt.viewoptions = 'cursor,folds,slash,unix'

-- ── Clipboard (deferred to reduce startup time) ───────────────────────────────
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- ── Providers (disabled) ─────────────────────────────────────────────────────
vim.g.loaded_node_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider    = 0

-- ── Auto-cd to project root ───────────────────────────────────────────────────
vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup,
  callback = function()
    if vim.bo.buftype ~= '' or vim.fn.expand '%' == '' then return end
    local root = vim.fs.root(0, {
      { '.git' },
      { 'pyproject.toml', 'Cargo.toml', 'go.mod', 'package.json' },
      { 'Makefile', 'CMakeLists.txt', 'compile_commands.json', 'setup.py' },
    })
    if root and root ~= vim.uv.cwd() then vim.uv.chdir(root) end
  end,
})

-- ── Auto-reload files changed externally ──────────────────────────────────────
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  group = augroup,
  callback = function()
    if vim.fn.mode() ~= 'c' then vim.cmd 'silent! checktime' end
  end,
})

-- ── Auto-save on focus lost ───────────────────────────────────────────────────
vim.api.nvim_create_autocmd('FocusLost', {
  group = augroup,
  callback = function() vim.cmd 'silent! wa' end,
})

-- ── Persistent cursor position ────────────────────────────────────────────────
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

-- ── Persist fold state ────────────────────────────────────────────────────────
local function is_normal_file()
  return vim.bo.buftype == '' and vim.fn.expand '%' ~= ''
end

vim.api.nvim_create_autocmd('BufWinLeave', {
  group = augroup,
  callback = function() if is_normal_file() then vim.cmd 'silent! mkview' end end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = augroup,
  callback = function() if is_normal_file() then vim.cmd 'silent! loadview' end end,
})

-- ── Markdown settings ─────────────────────────────────────────────────────────
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'markdown',
  callback = function()
    vim.opt_local.spell        = true
    vim.opt_local.spelllang    = 'en_us'
    vim.opt_local.wrap         = true
    vim.opt_local.linebreak    = true
    vim.opt_local.textwidth    = 80
    vim.opt_local.conceallevel = 2
  end,
})

-- ── Terminal settings ─────────────────────────────────────────────────────────
vim.api.nvim_create_autocmd('TermOpen', {
  group = augroup,
  callback = function()
    vim.opt_local.number         = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn     = 'no'
    vim.opt_local.scrolloff      = 0
  end,
})

-- ── TODO highlights ───────────────────────────────────────────────────────────
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = augroup,
  callback = function()
    if vim.b.todo_highlights_added then return end
    vim.b.todo_highlights_added = true
    vim.fn.matchadd('DiagnosticWarn', [[\v<(TODO|FIXME|HACK|WARN|BUG|XXX):]])
    vim.fn.matchadd('DiagnosticInfo', [[\v<(NOTE|INFO|PERF|OPTIMIZE):]])
    vim.fn.matchadd('DiagnosticHint', [[\v<(TEST|TESTING):]])
  end,
})

-- ── Markdown TOC ─────────────────────────────────────────────────────────────
local function _md_anchor(title)
  return title:lower():gsub('%s+', '-'):gsub('[^%w%-]', ''):gsub('%-%-+', '-')
end

local function _collect_headings()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local result, in_code = {}, false
  for _, line in ipairs(lines) do
    if line:match '^```' then in_code = not in_code end
    if not in_code then
      local level, title = line:match '^(#+)%s+(.+)'
      if level then
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
  local s, e
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

vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  pattern = '*.md',
  callback = function()
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, 100, false)) do
      if line == '<!-- TOC -->' then vim.cmd 'UpdateToc' return end
    end
  end,
})

-- ── Native image paste (requires: brew install pngpaste) ─────────────────────
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
