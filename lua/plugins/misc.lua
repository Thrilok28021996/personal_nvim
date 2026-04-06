-- Native alternatives: statusline, tabline, auto-pairs, indent guides
-- Loaded directly via require 'plugins.misc' in init.lua (before lazy.setup)

-- ============================================================================
-- 1. STATUSLINE (uses 0.12+ vim.diagnostic.status / vim.ui.progress_status)
-- ============================================================================

function _G.statusline()
  local mode_map = {
    n = 'NORMAL', i = 'INSERT', v = 'VISUAL', V = 'V-LINE',
    ['\22'] = 'V-BLOCK', c = 'COMMAND', s = 'SELECT', S = 'S-LINE',
    ['\19'] = 'S-BLOCK', R = 'REPLACE', r = 'PROMPT', ['!'] = 'SHELL', t = 'TERMINAL',
  }

  local mode     = mode_map[vim.api.nvim_get_mode().mode] or 'UNKNOWN'
  local filename = vim.fn.expand '%:t' ~= '' and vim.fn.expand '%:t' or '[No Name]'
  local modified = vim.bo.modified and ' [+]' or ''
  local readonly = vim.bo.readonly and ' [RO]' or ''
  local filetype = vim.bo.filetype ~= '' and ' [' .. vim.bo.filetype .. ']' or ''

  -- Diagnostics (0.12+ vim.diagnostic.status)
  local diag = vim.diagnostic.status and vim.diagnostic.status() or ''
  if diag == '' then
    -- Fallback: manual count
    local counts = vim.diagnostic.count(0)
    local errors = counts[vim.diagnostic.severity.ERROR] or 0
    local warns  = counts[vim.diagnostic.severity.WARN] or 0
    if errors > 0 or warns > 0 then
      diag = string.format(' E:%d W:%d', errors, warns)
    end
  else
    diag = ' ' .. diag
  end

  -- Git branch + diff stats (via gitsigns)
  local branch = ''
  local gs = vim.b.gitsigns_status_dict
  if gs and gs.head and gs.head ~= '' then
    local a, c, r = gs.added or 0, gs.changed or 0, gs.removed or 0
    local diff = (a > 0 or c > 0 or r > 0) and string.format(' +%d ~%d -%d', a, c, r) or ''
    branch = ' ' .. gs.head .. diff
  end

  -- LSP client name
  local lsp     = ''
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if #clients > 0 then lsp = ' LSP:' .. clients[1].name end

  -- Progress status (0.12+ — shows LSP indexing, etc.)
  local progress = vim.ui.progress_status and vim.ui.progress_status() or ''
  if progress ~= '' then progress = ' ' .. progress end

  -- Python venv
  local venv  = vim.env.VIRTUAL_ENV and (' ' .. vim.fs.basename(vim.env.VIRTUAL_ENV)) or ''
  local line  = vim.fn.line '.'
  local col   = vim.fn.col '.'
  local total = vim.fn.line '$'

  return string.format(
    ' %s │ %s%s%s%s%s%s%s%s%s │ %d:%d │ %d%% ',
    mode, filename, modified, readonly, filetype, diag, branch, lsp, progress, venv,
    line, col, math.floor(line / total * 100)
  )
end

vim.opt.statusline = '%{%v:lua.statusline()%}'

-- ============================================================================
-- 2. TABLINE (cached — rebuilt only on buffer list changes)
-- ============================================================================

local _tabline_cache = ''

local function _build_tabline()
  local cur = vim.api.nvim_get_current_buf()
  local tabs = vim.iter(vim.api.nvim_list_bufs())
    :filter(function(b) return vim.fn.buflisted(b) == 1 end)
    :map(function(b)
      local name = vim.fn.bufname(b)
      name = name ~= '' and vim.fn.fnamemodify(name, ':t') or '[No Name]'
      local hl = b == cur and '%#TabLineSel#' or '%#TabLine#'
      return hl .. ' ' .. b .. ':' .. name .. ' '
    end)
    :totable()
  _tabline_cache = table.concat(tabs) .. '%#TabLineFill#'
end

function _G.tabline() return _tabline_cache end

vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete', 'BufEnter', 'BufModifiedSet' }, {
  callback = _build_tabline,
})
_build_tabline()

vim.opt.tabline = '%{%v:lua.tabline()%}'

-- ============================================================================
-- 3. AUTO-PAIRS
-- ============================================================================

local function setup_autopairs()
  local pairs_map = {
    ['('] = ')', ['['] = ']', ['{'] = '}',
    ['"'] = '"', ["'"] = "'", ['`'] = '`',
  }

  for open, close in pairs(pairs_map) do
    vim.keymap.set('i', open, function()
      return open .. close .. '<Left>'
    end, { expr = true, silent = true })

    if open ~= close then
      -- Brackets: skip closing char if already present
      vim.keymap.set('i', close, function()
        local col  = vim.fn.col '.'
        local line = vim.api.nvim_get_current_line()
        return line:sub(col, col) == close and '<Right>' or close
      end, { expr = true, silent = true })
    else
      -- Quotes: skip if next char matches; insert pair only when not after a word char
      vim.keymap.set('i', close, function()
        local col     = vim.fn.col '.'
        local line    = vim.api.nvim_get_current_line()
        local next_ch = line:sub(col, col)
        local prev_ch = line:sub(col - 1, col - 1)
        if next_ch == close then return '<Right>' end
        if prev_ch:match '[%w]' then return close end
        return close .. close .. '<Left>'
      end, { expr = true, silent = true })
    end
  end

  -- <BS>: delete the matching pair when cursor is between them
  vim.keymap.set('i', '<BS>', function()
    local col     = vim.fn.col '.'
    local line    = vim.api.nvim_get_current_line()
    local prev_ch = line:sub(col - 1, col - 1)
    local next_ch = line:sub(col, col)
    for open, close in pairs(pairs_map) do
      if prev_ch == open and next_ch == close then return '<BS><Del>' end
    end
    return '<BS>'
  end, { expr = true, silent = true })

  -- <CR>: confirm selected completion, or expand pair, or plain newline
  vim.keymap.set('i', '<CR>', function()
    if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
      return '<C-y>'
    end
    local col     = vim.fn.col '.'
    local line    = vim.api.nvim_get_current_line()
    local prev_ch = line:sub(col - 1, col - 1)
    local next_ch = line:sub(col, col)
    if (prev_ch == '{' and next_ch == '}')
    or (prev_ch == '[' and next_ch == ']')
    or (prev_ch == '(' and next_ch == ')') then
      return '<CR><Esc>O'
    end
    return '<CR>'
  end, { expr = true, silent = true })
end

setup_autopairs()

-- ============================================================================
-- 4. INDENT GUIDES
-- ============================================================================

vim.fn.matchadd('Whitespace', [[\(^\s\+\)]], 10)
