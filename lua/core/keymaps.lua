-- Keymaps (Neovim 0.12+)
--
-- Native defaults NOT remapped here:
--   Folding : za zA zo zO zc zC zm zM zr zR zf zd
--   Diff    : ]c [c do dp
--   Search  : gn gN g* g#
--   Spell   : zg zw
--   URL     : gx
--   LSP     : grn grr gri gra grt grx K <C-S> [d ]d
--   TS      : v_an v_in v_]n v_[n
--   0.12.2  : ZR (restart nvim)

vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

local map = vim.keymap.set
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- ── File ──────────────────────────────────────────────────────────────────────
map('n', '<C-s>', '<cmd>w<CR>',    { desc = 'Save file' })
map('n', '<C-q>', '<cmd>quit<CR>', { desc = 'Quit' })
map('n', 'x',    '"_x',           { desc = 'Delete char (no yank)' })

-- ── Selection & Clipboard ────────────────────────────────────────────────────
map('n', '<C-a>', 'ggVG',  { desc = 'Select all' })
map('n', 'gp',    '`[v`]', { desc = 'Select last pasted' })

map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map('n',           '<leader>Y', [["+Y]], { desc = 'Yank line to clipboard' })
map('x', 'p', '"_dP', { desc = 'Paste without yanking' })

-- ── Search & Replace ─────────────────────────────────────────────────────────
map('n', 'n',          'nzzzv',                                             { desc = 'Next result (centered)' })
map('n', 'N',          'Nzzzv',                                             { desc = 'Prev result (centered)' })
map('n', '<Esc>',      '<cmd>nohlsearch<CR>',                               { desc = 'Clear highlight' })
map('n', '<leader>sr', [[:%s///gc<Left><Left><Left>]],                      { desc = 'Search & replace' })
map('n', '<leader>ra', [[:%s/<C-r><C-w>//gc<Left><Left><Left>]],            { desc = 'Replace word under cursor' })
map('n', '<leader>*',  '<cmd>FzfLua grep_cword<cr>',                        { desc = 'Search word in project' })
map('n', '<leader>/',  '<cmd>FzfLua grep_curbuf<cr>',                       { desc = 'Search in buffer' })

-- ── Text Manipulation ────────────────────────────────────────────────────────
map('n', '<A-j>',      '<cmd>move .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-k>',      '<cmd>move .-2<CR>==', { desc = 'Move line up' })
map('n', '<leader>ld', '<cmd>copy .<CR>',     { desc = 'Duplicate line' })
map('v', '<leader>ld', ":copy '><CR>gv",      { desc = 'Duplicate selection' })
map('v', 'J',          ":m '>+1<CR>gv=gv",   { desc = 'Move lines down' })
map('v', 'K',          ":m '<-2<CR>gv=gv",   { desc = 'Move lines up' })
map('v', '<',          '<gv',                 { desc = 'Indent left' })
map('v', '>',          '>gv',                 { desc = 'Indent right' })
map('n', ']<Space>',   'o<Esc>',              { desc = 'Insert line below' })
map('n', '[<Space>',   'O<Esc>',              { desc = 'Insert line above' })
map('n', 'J',          'mzJ`z',               { desc = 'Join lines (keep cursor)' })
map('n', '<leader>lu', '<cmd>uniq<CR>',        { desc = 'Deduplicate lines' })

-- ── Comments ─────────────────────────────────────────────────────────────────
map('n', '<C-/>', 'gcc', { remap = true, desc = 'Toggle comment' })
map('v', '<C-/>', 'gc',  { remap = true, desc = 'Toggle comment' })

map('n', '<leader>cb', function()
  local line    = vim.api.nvim_get_current_line()
  local comment = vim.bo.commentstring:gsub('%%s', '')
  local width   = 80
  local border  = comment .. string.rep('=', width - #comment)
  local content = comment .. ' ' .. line
  local padding = width - #content - #comment
  if padding > 0 then content = content .. string.rep(' ', padding) .. comment end
  vim.api.nvim_put({ border, content, border }, 'l', true, true)
  vim.cmd 'normal! 2k'
end, { desc = 'Create comment box' })

-- ── Scrolling ────────────────────────────────────────────────────────────────
map('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })
map('n', '{',     '{zz',     { desc = 'Prev paragraph (centered)' })
map('n', '}',     '}zz',     { desc = 'Next paragraph (centered)' })

-- ── Buffers ──────────────────────────────────────────────────────────────────
map('n', '<Tab>',      '<cmd>bnext<CR>',     { desc = 'Next buffer' })
map('n', '<S-Tab>',    '<cmd>bprevious<CR>', { desc = 'Prev buffer' })
map('n', '<leader>bb', '<cmd>e#<CR>',        { desc = 'Alternate buffer' })
map('n', '<leader>bc', '<cmd>bdel<CR>',      { desc = 'Close buffer' })

map('n', '<leader>bC', function()
  local cur = vim.api.nvim_get_current_buf()
  vim.iter(vim.api.nvim_list_bufs())
    :filter(function(b) return b ~= cur and vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted end)
    :each(function(b) vim.api.nvim_buf_delete(b, { force = false }) end)
end, { desc = 'Close other buffers' })

-- ── Windows ──────────────────────────────────────────────────────────────────
map('n', '<C-h>', '<cmd>wincmd h<CR>', { desc = 'Window left' })
map('n', '<C-j>', '<cmd>wincmd j<CR>', { desc = 'Window down' })
map('n', '<C-k>', '<cmd>wincmd k<CR>', { desc = 'Window up' })
map('n', '<C-l>', '<cmd>wincmd l<CR>', { desc = 'Window right' })

map('n', '<C-Up>',    '<cmd>resize +2<CR>',          { desc = 'Increase height' })
map('n', '<C-Down>',  '<cmd>resize -2<CR>',          { desc = 'Decrease height' })
map('n', '<C-Left>',  '<cmd>vertical resize -2<CR>', { desc = 'Decrease width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase width' })

map('n', '<leader>wv', '<C-w>v',          { desc = 'Split vertical' })
map('n', '<leader>wh', '<C-w>s',          { desc = 'Split horizontal' })
map('n', '<leader>we', '<C-w>=',          { desc = 'Equal sizes' })
map('n', '<leader>wc', '<cmd>close<CR>',  { desc = 'Close window' })
map('n', '<leader>wo', '<C-w>o',          { desc = 'Close others' })

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

-- ── File Navigation ───────────────────────────────────────────────────────────
map('n', '-',           '<cmd>Oil<CR>',              { desc = 'File explorer' })
map('n', '<leader>ff',  '<cmd>FzfLua files<cr>',     { desc = 'Find files' })
map('n', '<leader>fw',  '<cmd>FzfLua live_grep<cr>', { desc = 'Live grep' })
map('n', '<leader>fb',  '<cmd>FzfLua buffers<cr>',   { desc = 'Find buffers' })
map('n', '<leader>fr',  '<cmd>FzfLua oldfiles<cr>',  { desc = 'Recent files' })

-- ── Change List ───────────────────────────────────────────────────────────────
map('n', 'g;', 'g;zz', { desc = 'Older change' })
map('n', 'g,', 'g,zz', { desc = 'Newer change' })

-- ── Marks & Registers ────────────────────────────────────────────────────────
map('n', "<leader>'", '<cmd>FzfLua marks<cr>',     { desc = 'Browse marks' })
map('n', '<leader>M',  '<cmd>delmarks!<CR>',        { desc = 'Delete all marks' })
map('n', '<leader>"',  '<cmd>FzfLua registers<cr>', { desc = 'Browse registers' })

map('n', '<leader>rC', function()
  for i = 0, 9 do vim.fn.setreg(tostring(i), '') end
  for c = 97, 122 do vim.fn.setreg(string.char(c), '') end
  vim.notify('All registers cleared', vim.log.levels.INFO)
end, { desc = 'Clear all registers' })

-- ── Diagnostics ───────────────────────────────────────────────────────────────
local E = vim.diagnostic.severity
local function diag_filter(severity)
  return { virtual_text = { severity = severity }, signs = { severity = severity }, underline = { severity = severity } }
end

map('n', ']e', function() vim.diagnostic.goto_next { severity = E.ERROR } end, { desc = 'Next error' })
map('n', '[e', function() vim.diagnostic.goto_prev { severity = E.ERROR } end, { desc = 'Prev error' })
map('n', ']w', function() vim.diagnostic.goto_next { severity = E.WARN }  end, { desc = 'Next warning' })
map('n', '[w', function() vim.diagnostic.goto_prev { severity = E.WARN }  end, { desc = 'Prev warning' })

map('n', '<leader>de', function() vim.diagnostic.config(diag_filter(E.ERROR)) end,                        { desc = 'Show only errors' })
map('n', '<leader>dw', function() vim.diagnostic.config(diag_filter { min = E.WARN, max = E.ERROR }) end, { desc = 'Show errors & warnings' })
map('n', '<leader>da', function()
  vim.diagnostic.config { virtual_text = { prefix = '●', source = 'if_many', spacing = 4, current_line = true }, signs = true, underline = true }
end, { desc = 'Show all diagnostics' })

map('n', '<leader>dq', function()
  vim.diagnostic.setqflist()
  vim.cmd 'copen'
end, { desc = 'Diagnostics to quickfix' })

map('n', '<leader>xd', function()
  local cur = vim.diagnostic.config().virtual_text
  vim.diagnostic.config {
    virtual_text = not cur and { prefix = '●', source = 'if_many', spacing = 4, current_line = true } or false,
  }
  vim.notify('Diagnostics: ' .. (cur and 'hidden' or 'visible'), vim.log.levels.INFO)
end, { desc = 'Toggle diagnostics' })

-- ── Quickfix & Loclist ────────────────────────────────────────────────────────
map('n', ']q', '<cmd>cnext<CR>zz',  { desc = 'Next quickfix' })
map('n', '[q', '<cmd>cprev<CR>zz',  { desc = 'Prev quickfix' })
map('n', ']Q', '<cmd>clast<CR>zz',  { desc = 'Last quickfix' })
map('n', '[Q', '<cmd>cfirst<CR>zz', { desc = 'First quickfix' })
map('n', ']l', '<cmd>lnext<CR>zz',  { desc = 'Next loclist' })
map('n', '[l', '<cmd>lprev<CR>zz',  { desc = 'Prev loclist' })

local function toggle_list(key, open_cmd, close_cmd)
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win[key] == 1 then vim.cmd(close_cmd) return end
  end
  vim.cmd(open_cmd)
end
map('n', '<leader>xq', function() toggle_list('quickfix', 'copen', 'cclose') end, { desc = 'Toggle quickfix' })
map('n', '<leader>xl', function() toggle_list('loclist',  'lopen', 'lclose') end, { desc = 'Toggle loclist' })

-- ── Spell ─────────────────────────────────────────────────────────────────────
map('n', '<leader>sz', '<cmd>set spell!<CR>', { desc = 'Toggle spell' })
map('n', ']z',         ']szz',                { desc = 'Next misspelling' })
map('n', '[z',         '[szz',                { desc = 'Prev misspelling' })

map('n', '<leader>z=', function()
  vim.ui.select(vim.fn.spellsuggest(vim.fn.expand '<cword>'), { prompt = 'Spell suggestions:' }, function(choice)
    if choice then vim.cmd('normal! ciw' .. choice) end
  end)
end, { desc = 'Spell suggestions' })

-- ── Refactoring ───────────────────────────────────────────────────────────────
map('v', '<leader>re', function() vim.lsp.buf.code_action { context = { only = { 'refactor.extract' } },          apply = true } end, { desc = 'Extract to function' })
map('n', '<leader>ri', function() vim.lsp.buf.code_action { context = { only = { 'refactor.inline' } },           apply = true } end, { desc = 'Inline variable' })
map('v', '<leader>ev', function() vim.lsp.buf.code_action { context = { only = { 'refactor.extract.variable' } }, apply = true } end, { desc = 'Extract variable' })
map('v', '<leader>ec', function() vim.lsp.buf.code_action { context = { only = { 'refactor.extract.constant' } }, apply = true } end, { desc = 'Extract constant' })

-- ── Imports ───────────────────────────────────────────────────────────────────
map('n', '<leader>io', function() vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } },      apply = true } end, { desc = 'Organize imports' })
map('n', '<leader>ia', function() vim.lsp.buf.code_action { context = { only = { 'source.addMissingImports' } },    apply = true } end, { desc = 'Add missing imports' })
map('n', '<leader>ir', function() vim.lsp.buf.code_action { context = { only = { 'source.removeUnusedImports' } },  apply = true } end, { desc = 'Remove unused imports' })

-- ── Inspector ─────────────────────────────────────────────────────────────────
map('n', '<leader>Ti', '<cmd>Inspect<CR>',     { desc = 'Inspect highlights' })
map('n', '<leader>TT', '<cmd>InspectTree<CR>', { desc = 'Treesitter tree' })

-- ── Diff ──────────────────────────────────────────────────────────────────────
map('n', '<leader>gd', '<cmd>windo diffthis<CR>', { desc = 'Enable diff mode' })
map('n', '<leader>gD', '<cmd>windo diffoff<CR>',  { desc = 'Disable diff mode' })

-- ── Debugging ────────────────────────────────────────────────────────────────
local function _dap_setup() if _G._dap_ensure_setup then _G._dap_ensure_setup() end end
map('n', '<leader>db', function() _dap_setup(); require('dap').toggle_breakpoint() end,                        { desc = 'Debug: Toggle breakpoint' })
map('n', '<leader>dB', function() _dap_setup(); require('dap').set_breakpoint(vim.fn.input 'Condition: ') end, { desc = 'Debug: Conditional breakpoint' })
map('n', '<leader>dc', function() _dap_setup(); require('dap').continue() end,                                 { desc = 'Debug: Continue' })
map('n', '<leader>di', function() _dap_setup(); require('dap').step_into() end,                                { desc = 'Debug: Step into' })
map('n', '<leader>do', function() _dap_setup(); require('dap').step_over() end,                                { desc = 'Debug: Step over' })
map('n', '<leader>dO', function() _dap_setup(); require('dap').step_out() end,                                 { desc = 'Debug: Step out' })
map('n', '<leader>dr', function() _dap_setup(); require('dap').repl.open() end,                                { desc = 'Debug: REPL' })
map('n', '<leader>dl', function() _dap_setup(); require('dap').run_last() end,                                 { desc = 'Debug: Run last' })
map('n', '<leader>dt', function() _dap_setup(); require('dap').terminate() end,                                { desc = 'Debug: Terminate' })
map('n', '<leader>du', function() _dap_setup(); require('dapui').toggle() end,                                 { desc = 'Debug: Toggle UI' })

-- ── Terminal ──────────────────────────────────────────────────────────────────
map('n', '<C-t>',      '<cmd>terminal<CR>',          { desc = 'Open terminal' })
map('n', '<leader>ht', '<cmd>split | terminal<CR>',  { desc = 'Terminal (horizontal)' })
map('n', '<leader>vt', '<cmd>vsplit | terminal<CR>', { desc = 'Terminal (vertical)' })

map('t', '<Esc>', '<C-\\><C-n>',        { desc = 'Exit terminal mode' })
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Terminal: window left' })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Terminal: window down' })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Terminal: window up' })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Terminal: window right' })

map('n', '<leader>tt', function()
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
  vim.cmd 'botright split | terminal'
  vim.cmd 'resize 15'
end, { desc = 'Toggle terminal' })

map('v', '<leader>ts', function()
  local start_pos = vim.fn.getpos 'v'
  local end_pos   = vim.fn.getpos '.'
  local lines     = vim.fn.getline(start_pos[2], end_pos[2])
  local term_buf
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == 'terminal' then term_buf = buf break end
  end
  if term_buf then
    local chan = vim.bo[term_buf].channel
    for _, line in ipairs(lines) do vim.fn.chansend(chan, line .. '\n') end
  else
    vim.notify('No terminal buffer', vim.log.levels.WARN)
  end
end, { desc = 'Send selection to terminal' })

-- ── Code Execution ────────────────────────────────────────────────────────────
map('n', '<leader>rr', function()
  local ft   = vim.bo.filetype
  local file = vim.fn.expand '%:p'
  local runners = {
    python = 'python3 ', javascript = 'node ',    typescript = 'node ',
    lua    = 'lua ',     sh         = 'bash ',    bash       = 'bash ',
    ruby   = 'ruby ',    go         = 'go run ',  rust       = 'cargo run',
    c      = 'gcc %s -o /tmp/a.out && /tmp/a.out',
    cpp    = 'g++ %s -o /tmp/a.out && /tmp/a.out',
  }
  local runner = runners[ft]
  if not runner then vim.notify('No runner for: ' .. ft, vim.log.levels.WARN) return end
  local cmd = runner:find '%%s' and runner:format(vim.fn.shellescape(file))
    or (runner == 'cargo run' and runner or runner .. vim.fn.shellescape(file))
  vim.cmd('split | terminal ' .. cmd)
end, { desc = 'Run current file' })

-- ── File Operations ───────────────────────────────────────────────────────────
map('n', '<leader>fR', function()
  local old = vim.fn.expand '%'
  vim.ui.input({ prompt = 'New name: ', default = old }, function(new)
    if new and new ~= '' and new ~= old then
      vim.cmd('saveas ' .. new)
      vim.fn.delete(old)
      vim.notify('Renamed: ' .. old .. ' → ' .. new, vim.log.levels.INFO)
    end
  end)
end, { desc = 'Rename file' })

map('n', '<leader>fX', function()
  local file = vim.fn.expand '%'
  vim.ui.input({ prompt = 'Delete ' .. file .. '? (y/n): ' }, function(choice)
    if choice == 'y' or choice == 'Y' then
      vim.fn.delete(file)
      vim.cmd 'bdelete!'
      vim.notify('Deleted: ' .. file, vim.log.levels.INFO)
    end
  end)
end, { desc = 'Delete file' })

map('n', '<leader>fy', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, { desc = 'Copy file path' })

map('n', '<leader>fn', function()
  local name = vim.fn.expand '%:t'
  vim.fn.setreg('+', name)
  vim.notify('Copied: ' .. name, vim.log.levels.INFO)
end, { desc = 'Copy file name' })

map('n', '<leader>fx', function()
  local file = vim.fn.expand '%:p'
  vim.fn.system('chmod +x ' .. vim.fn.shellescape(file))
  vim.notify('Made executable: ' .. file, vim.log.levels.INFO)
end, { desc = 'Make executable' })

-- ── C/C++ Header Toggle ───────────────────────────────────────────────────────
map('n', '<leader>ch', function()
  local ext  = vim.fn.expand '%:e'
  local name = vim.fn.expand '%:t:r'
  local dir  = vim.fn.expand '%:p:h'
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
  if #found > 0 then vim.cmd('edit ' .. found[1])
  else vim.notify('Corresponding file not found', vim.log.levels.WARN) end
end, { desc = 'Toggle header/source' })

-- ── Debug Print ───────────────────────────────────────────────────────────────
map('n', '<leader>dp', function()
  local ft   = vim.bo.filetype
  local word = vim.fn.expand '<cword>'
  local templates = {
    python     = 'print(f"{%s=}")',
    javascript = "console.log('%s:', %s)",
    typescript = "console.log('%s:', %s)",
    c          = 'printf("%s: %%d\\n", %s);',
    cpp        = 'std::cout << "%s: " << %s << std::endl;',
    lua        = 'print("%s:", %s)',
  }
  local tmpl = templates[ft]
  if not tmpl then vim.notify('No debug print for: ' .. ft, vim.log.levels.WARN) return end
  vim.api.nvim_put({ tmpl:format(word, word) }, 'l', true, true)
end, { desc = 'Insert debug print' })

-- ── Macros ────────────────────────────────────────────────────────────────────
map('n', '<leader>qm', function()
  local reg = vim.fn.input 'Register: '
  if reg ~= '' then
    vim.fn.setreg(reg, vim.fn.input('Edit macro: ', vim.fn.getreg(reg)))
  end
end, { desc = 'Edit macro' })

-- ── UI Toggles ────────────────────────────────────────────────────────────────
map('n', '<leader>tn', function() vim.wo.relativenumber = not vim.wo.relativenumber end,        { desc = 'Toggle relative numbers' })
map('n', '<leader>tw', function() vim.wo.wrap = not vim.wo.wrap end,                             { desc = 'Toggle wrap' })
map('n', '<leader>tc', function() vim.wo.conceallevel = vim.wo.conceallevel > 0 and 0 or 2 end, { desc = 'Toggle conceal' })
map('n', '<leader>xf', '<cmd>FormatToggle<CR>', { desc = 'Toggle format on save' })
map('n', '<leader>tu', '<cmd>Undotree<CR>',     { desc = 'Toggle undo tree' })
map('n', '<leader>tD', '<cmd>DiffTool<CR>',     { desc = 'Diff tool' })

local _zen = { active = false }
map('n', '<leader>tz', function()
  if _zen.active then
    vim.wo.number         = _zen.number
    vim.wo.relativenumber = _zen.relnumber
    vim.wo.signcolumn     = _zen.signcolumn
    vim.wo.foldcolumn     = _zen.foldcolumn
    vim.wo.cursorline     = _zen.cursorline
    vim.wo.list           = _zen.list
    vim.o.laststatus      = _zen.laststatus
    vim.o.showtabline     = _zen.showtabline
    vim.cmd 'wincmd ='
    _zen.active = false
  else
    _zen = {
      active      = true,
      number      = vim.wo.number,      relnumber  = vim.wo.relativenumber,
      signcolumn  = vim.wo.signcolumn,  foldcolumn = vim.wo.foldcolumn,
      cursorline  = vim.wo.cursorline,  list       = vim.wo.list,
      laststatus  = vim.o.laststatus,   showtabline = vim.o.showtabline,
    }
    vim.wo.number         = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn     = 'no'
    vim.wo.foldcolumn     = '0'
    vim.wo.cursorline     = false
    vim.wo.list           = false
    vim.o.laststatus      = 0
    vim.o.showtabline     = 0
    vim.cmd 'wincmd |'
    vim.cmd 'wincmd _'
  end
end, { desc = 'Toggle zen mode' })

-- ── Sessions ──────────────────────────────────────────────────────────────────
local function session_path(name)
  local dir = vim.fn.stdpath 'data' .. '/sessions'
  vim.fn.mkdir(dir, 'p')
  return vim.fs.normalize(dir .. '/' .. (name or vim.fs.basename(vim.uv.cwd() or vim.fn.getcwd())) .. '.vim')
end

map('n', '<leader>ss', function()
  local path = session_path()
  vim.cmd('mksession! ' .. vim.fn.fnameescape(path))
  vim.notify('Session saved: ' .. path, vim.log.levels.INFO)
end, { desc = 'Save session' })

map('n', '<leader>sl', function()
  local path = session_path()
  if vim.uv.fs_stat(path) then
    vim.cmd('source ' .. vim.fn.fnameescape(path))
    vim.notify('Session loaded', vim.log.levels.INFO)
  else
    vim.notify('No session found', vim.log.levels.WARN)
  end
end, { desc = 'Load session' })

map('n', '<leader>sd', function()
  if vim.uv.fs_unlink(session_path()) then
    vim.notify('Session deleted', vim.log.levels.INFO)
  else
    vim.notify('No session to delete', vim.log.levels.WARN)
  end
end, { desc = 'Delete session' })

map('n', '<leader>sS', function()
  vim.ui.input({ prompt = 'Session name: ' }, function(name)
    if name and name ~= '' then
      local path = session_path(name)
      vim.cmd('mksession! ' .. vim.fn.fnameescape(path))
      vim.notify('Session saved: ' .. name, vim.log.levels.INFO)
    end
  end)
end, { desc = 'Save named session' })

map('n', '<leader>sL', function()
  local dir      = vim.fn.stdpath 'data' .. '/sessions'
  local sessions = vim.fn.glob(dir .. '/*.vim', false, true)
  if #sessions == 0 then vim.notify('No sessions found', vim.log.levels.WARN) return end
  local items = vim.iter(sessions)
    :map(function(s) return vim.fs.basename(s):gsub('%.vim$', '') end)
    :totable()
  vim.ui.select(items, { prompt = 'Select session:' }, function(choice)
    if choice then
      vim.cmd('source ' .. vim.fs.normalize(dir .. '/' .. choice .. '.vim'))
      vim.notify('Session loaded: ' .. choice, vim.log.levels.INFO)
    end
  end)
end, { desc = 'Load named session' })

vim.api.nvim_create_user_command('SessionAutoSave', function()
  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = vim.api.nvim_create_augroup('AutoSessionSave', { clear = true }),
    callback = function() vim.cmd('mksession! ' .. session_path()) end,
  })
  vim.notify('Auto-save session enabled', vim.log.levels.INFO)
end, { desc = 'Enable session auto-save on exit' })

-- ── Project ───────────────────────────────────────────────────────────────────
local _root_patterns = {
  { '.git' },
  { 'pyproject.toml', 'Cargo.toml', 'go.mod', 'package.json' },
  { 'Makefile', 'CMakeLists.txt', 'compile_commands.json', 'setup.py' },
}

map('n', '<leader>pr', function()
  local root = vim.fs.root(0, _root_patterns)
  vim.notify(root and ('Project: ' .. root) or 'No project root', root and vim.log.levels.INFO or vim.log.levels.WARN)
end, { desc = 'Show project root' })

map('n', '<leader>pc', function()
  local root = vim.fs.root(0, _root_patterns)
  if root then vim.uv.chdir(root); vim.notify('Changed to: ' .. root, vim.log.levels.INFO) end
end, { desc = 'CD to project root' })

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
  if #dirs == 0 then vim.notify('No recent projects', vim.log.levels.WARN) return end
  vim.ui.select(dirs, { prompt = 'Projects:' }, function(choice)
    if choice then vim.uv.chdir(choice); vim.notify('Switched to: ' .. choice, vim.log.levels.INFO) end
  end)
end, { desc = 'Recent projects' })

map('n', '<leader>li', '<cmd>lsp<CR>',  { desc = 'LSP manager' })

-- ── Tasks ─────────────────────────────────────────────────────────────────────
map('n', '<leader>om', '<cmd>make<CR>',       { desc = 'Make' })
map('n', '<leader>ob', '<cmd>make build<CR>', { desc = 'Make build' })
map('n', '<leader>ot', '<cmd>make test<CR>',  { desc = 'Make test' })

-- ── Markdown ──────────────────────────────────────────────────────────────────
map('n', '<leader>mp', function()
  local file = vim.fn.expand '%:p'
  if file == '' then vim.notify('No file', vim.log.levels.WARN) return end
  local buf    = vim.api.nvim_create_buf(false, true)
  local width  = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  vim.api.nvim_open_win(buf, true, {
    relative = 'editor', style = 'minimal', border = 'rounded',
    width = width, height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
  })
  vim.fn.termopen('glow ' .. vim.fn.shellescape(file))
  map('n', 'q', '<cmd>close<CR>', { buffer = buf, desc = 'Close preview' })
end, { desc = 'Markdown preview (glow)' })

map('n', '<leader>mi', '<cmd>PasteImage<cr>', { desc = 'Paste image' })

vim.api.nvim_create_autocmd('FileType', {
  group   = vim.api.nvim_create_augroup('MarkdownKeymaps', { clear = true }),
  pattern = 'markdown',
  callback = function()
    local opts = { buffer = true }
    local bmap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', opts, { desc = desc }))
    end

    bmap('v', '<C-b>', function() vim.cmd 'normal! `<i**`>la**' end, 'Bold')
    bmap('v', '<C-i>', function() vim.cmd 'normal! `<i*`>la*' end,   'Italic')

    bmap('n', '<leader>il', function()
      local text = vim.fn.input 'Text: '
      local url  = vim.fn.input 'URL: '
      if url ~= '' then vim.api.nvim_put({ ('[%s](%s)'):format(text, url) }, 'c', true, true) end
    end, 'Insert link')

    bmap('n', '<leader>ic', function()
      local lang = vim.fn.input 'Language: '
      vim.api.nvim_put({ '```' .. lang, '', '```' }, 'l', true, true)
      vim.cmd 'normal! k'
    end, 'Insert code block')

    for i = 1, 6 do
      bmap('n', '<leader>h' .. i, function()
        local line = vim.api.nvim_get_current_line():gsub('^#* *', '')
        vim.api.nvim_set_current_line(string.rep('#', i) .. ' ' .. line)
      end, 'Heading ' .. i)
    end

    bmap('n', '<leader>mg', '<cmd>GenTocGFM<CR>', 'Generate TOC')
    bmap('n', '<leader>mu', '<cmd>UpdateToc<CR>', 'Update TOC')
  end,
})

-- ── Snippets ──────────────────────────────────────────────────────────────────
map({ 'i', 's' }, '<Tab>', function()
  if vim.snippet.active { direction = 1 } then return '<cmd>lua vim.snippet.jump(1)<CR>' end
  if vim.fn.pumvisible() == 1 then return '<C-n>' end
  if vim.api.nvim_get_mode().mode == 's' then return '<Ignore>' end
  return '<Tab>'
end, { expr = true, desc = 'Snippet/completion next' })

map({ 'i', 's' }, '<S-Tab>', function()
  if vim.snippet.active { direction = -1 } then return '<cmd>lua vim.snippet.jump(-1)<CR>' end
  if vim.fn.pumvisible() == 1 then return '<C-p>' end
  if vim.api.nvim_get_mode().mode == 's' then return '<Ignore>' end
  return '<S-Tab>'
end, { expr = true, desc = 'Snippet/completion prev' })

-- ── LSP ───────────────────────────────────────────────────────────────────────
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspSetup', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf    = args.buf
    if not client then return end

    if client:supports_method 'textDocument/completion' then
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { buffer = buf, desc = 'Trigger completion' })
    end

    local opts = { buffer = buf, silent = true }
    local lmap = function(mode, lhs, rhs, desc)
      map(mode, lhs, rhs, vim.tbl_extend('force', opts, { desc = desc }))
    end

    lmap('n', 'gd',  function() require('fzf-lua').lsp_definitions() end,     'Go to definition')
    lmap('n', 'gD',  vim.lsp.buf.declaration,                                  'Go to declaration')
    lmap('n', 'gy',  function() require('fzf-lua').lsp_typedefs() end,         'Go to type definition')
    lmap('n', 'gO',  function() require('fzf-lua').lsp_document_symbols() end, 'Document symbols')
    lmap('n', 'grr', function() require('fzf-lua').lsp_references() end,       'References')
    lmap('n', 'gri', function() require('fzf-lua').lsp_implementations() end,  'Implementations')

    lmap('n', '<leader>dd', vim.diagnostic.open_float, 'Diagnostics float')
    lmap('n', '<leader>ql', vim.diagnostic.setloclist, 'Diagnostics to loclist')

    if client:supports_method 'workspace/diagnostic' then
      lmap('n', '<leader>dW', vim.lsp.buf.workspace_diagnostics, 'Workspace diagnostics')
    end

    lmap('n', '<leader>ws', function() require('fzf-lua').lsp_workspace_symbols() end, 'Workspace symbols')
    lmap('n', '<leader>cI', function() require('fzf-lua').lsp_incoming_calls() end,    'Incoming calls')
    lmap('n', '<leader>co', function() require('fzf-lua').lsp_outgoing_calls() end,    'Outgoing calls')

    lmap('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')

    lmap('n', '<leader>ih', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf }, { bufnr = buf })
    end, 'Toggle inlay hints')
    if client:supports_method 'textDocument/inlayHint' then
      vim.lsp.inlay_hint.enable(true, { bufnr = buf })
    end

    if client:supports_method 'textDocument/codeLens' then
      lmap('n', '<leader>cl', vim.lsp.codelens.run,     'Run code lens')
      lmap('n', '<leader>cL', vim.lsp.codelens.refresh, 'Refresh code lens')
      vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
        buf = buf, callback = vim.lsp.codelens.refresh,
      })
    end

    if client:supports_method 'textDocument/documentColor' then
      vim.lsp.document_color.enable(true, buf)
    end

    if client:supports_method 'textDocument/linkedEditingRange' then
      vim.lsp.linked_editing_range.enable(true, buf)
    end
  end,
})

-- ── AI (CodeCompanion — chat/refactor) ───────────────────────────────────────
map({ 'n', 'v' }, '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'AI: Chat' })
map({ 'n', 'v' }, '<leader>ca', '<cmd>CodeCompanionActions<cr>',     { desc = 'AI: Actions' })
map({ 'n', 'v' }, '<leader>ci', '<cmd>CodeCompanion<cr>',            { desc = 'AI: Inline' })
map('v',           '<leader>cx', '<cmd>CodeCompanionChat Add<cr>',   { desc = 'AI: Add to chat' })
map('n',           '<leader>cn', '<cmd>CodeCompanionChat<cr>',       { desc = 'AI: New chat' })
vim.cmd [[cab cc CodeCompanion]]

-- ── AI (Minuet — ghost-text completions) ─────────────────────────────────────
-- Accept/cycle/dismiss are set in minuet opts (virtualtext.keymap):
--   <A-a>  accept whole   <A-l> accept line   <A-n> accept N lines
--   <A-]>  next candidate  <A-[>  prev         <A-e> dismiss
map('n', '<leader>tm', '<cmd>Minuet virtualtext toggle<cr>', { desc = 'Toggle AI ghost-text' })

-- ── Git (LazyGit) ─────────────────────────────────────────────────────────────
map('n', '<leader>lg', function()
  local buf = vim.api.nvim_create_buf(false, true)
  local w   = math.floor(vim.o.columns * 0.92)
  local h   = math.floor(vim.o.lines * 0.88)
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

-- ── Git Links ─────────────────────────────────────────────────────────────────
local function git_permalink(open, blame)
  local cwd  = vim.fn.expand '%:p:h'
  local root = vim.fn.system('git -C ' .. vim.fn.shellescape(cwd) .. ' rev-parse --show-toplevel'):gsub('%s+$', '')
  if vim.v.shell_error ~= 0 then vim.notify('Not in a git repo', vim.log.levels.WARN) return end
  local commit = vim.fn.system('git -C ' .. vim.fn.shellescape(root) .. ' rev-parse HEAD'):gsub('%s+$', '')
  local remote = vim.fn.system('git -C ' .. vim.fn.shellescape(root) .. ' remote get-url origin'):gsub('%s+$', '')
  remote = remote:gsub('git@([^:]+):', 'https://%1/'):gsub('%.git$', '')
  local rel  = vim.fn.expand('%:p'):sub(#root + 2)
  local l1, l2 = vim.fn.line 'v', vim.fn.line '.'
  if l1 > l2 then l1, l2 = l2, l1 end
  local line_ref = l1 == l2 and ('#L' .. l1) or ('#L' .. l1 .. '-L' .. l2)
  local url = remote .. (blame and '/blame/' or '/blob/') .. commit .. '/' .. rel .. line_ref
  if open then vim.ui.open(url)
  else vim.fn.setreg('+', url); vim.notify('Copied: ' .. url, vim.log.levels.INFO) end
end

map({ 'n', 'v' }, '<leader>gy', function() git_permalink(false, false) end, { desc = 'Yank permalink' })
map({ 'n', 'v' }, '<leader>gY', function() git_permalink(true,  false) end, { desc = 'Open permalink' })
map({ 'n', 'v' }, '<leader>gb', function() git_permalink(false, true)  end, { desc = 'Yank blame link' })
map({ 'n', 'v' }, '<leader>gB', function() git_permalink(true,  true)  end, { desc = 'Open blame' })

-- ── TODO Navigation ───────────────────────────────────────────────────────────
local _todo_pat = [[\v<(TODO|FIXME|HACK|WARN|BUG|NOTE|PERF|TEST):]]
map('n', ']T',         function() vim.fn.search(_todo_pat, 'W')  end, { desc = 'Next TODO' })
map('n', '[T',         function() vim.fn.search(_todo_pat, 'Wb') end, { desc = 'Prev TODO' })
map('n', '<leader>ft', '<cmd>FzfLua grep { search = "TODO:|FIXME:|HACK:|WARN:|PERF:|NOTE:|TEST:" }<CR>', { desc = 'Find TODOs' })

-- ── Format ────────────────────────────────────────────────────────────────────
map({ 'n', 'v' }, '<leader>cf', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { desc = 'Format buffer' })

-- ── Fuzzy Finder ──────────────────────────────────────────────────────────────
map('n', '<leader>fh', '<cmd>FzfLua helptags<cr>',                               { desc = 'Help tags' })
map('n', '<leader>fk', '<cmd>FzfLua keymaps<cr>',                                { desc = 'Keymaps' })
map('n', '<leader>fd', function() require('fzf-lua').diagnostics_document()  end, { desc = 'Diagnostics (file)' })
map('n', '<leader>fD', function() require('fzf-lua').diagnostics_workspace() end, { desc = 'Diagnostics (workspace)' })
map('n', '<leader>fg', '<cmd>FzfLua git_status<cr>',                             { desc = 'Git status' })
map('n', '<leader>f/', '<cmd>FzfLua search_history<cr>',                         { desc = 'Search history' })
map('n', '<leader>fc', '<cmd>FzfLua command_history<cr>',                        { desc = 'Command history' })
map('v', '<leader>*',  '<cmd>FzfLua grep_visual<cr>',                            { desc = 'Grep selection' })

-- ── Gitsigns ──────────────────────────────────────────────────────────────────
function _G.gitsigns_on_attach(bufnr)
  local gs = require 'gitsigns'
  local function bmap(mode, l, r, desc)
    map(mode, l, r, { buffer = bufnr, desc = desc })
  end
  bmap('n',          ']h',         gs.next_hunk,                              'Next hunk')
  bmap('n',          '[h',         gs.prev_hunk,                              'Prev hunk')
  bmap({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>',               'Stage hunk')
  bmap({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>',               'Reset hunk')
  bmap('n',          '<leader>hS', gs.stage_buffer,                           'Stage buffer')
  bmap('n',          '<leader>hu', gs.undo_stage_hunk,                        'Undo stage hunk')
  bmap('n',          '<leader>hp', gs.preview_hunk,                           'Preview hunk')
  bmap('n',          '<leader>hb', function() gs.blame_line { full = true } end, 'Blame line')
  bmap('n',          '<leader>hd', gs.diffthis,                               'Diff this')
  bmap('n',          '<leader>hB', gs.toggle_current_line_blame,              'Toggle line blame')
end
