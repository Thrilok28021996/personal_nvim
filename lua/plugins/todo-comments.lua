return {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = true,
    keywords = {
      FIX = { icon = ' ', color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } },
      TODO = { icon = ' ', color = 'info' },
      HACK = { icon = ' ', color = 'warning' },
      WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
      PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
      NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
      TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
    },
    highlight = {
      multiline = true,
      before = '',
      keyword = 'wide',
      after = 'fg',
      pattern = [[.*<(KEYWORDS)\s*:]],
    },
    search = {
      command = 'rg',
      args = { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column' },
      pattern = [[\b(KEYWORDS):]],
    },
  },
  -- Keymaps are in lua/core/keymaps.lua (Section 8.12)
}
