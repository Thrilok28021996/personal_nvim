return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    plugins = {
      marks = true, -- shows marks
      registers = true, -- shows registers
      spelling = {
        enabled = true, -- z= to show spelling suggestions
        suggestions = 20,
      },
      presets = {
        operators = true, -- operators like d, y, c
        motions = true, -- motions like w, b, e
        text_objects = true, -- text objects like iw, i(, i"
        windows = true, -- window commands
        nav = true, -- navigation
        z = true, -- z commands (folds)
        g = true, -- g commands
      },
    },
    -- Key mappings groups
    spec = {
      { '<leader>b', group = 'Buffer' },
      { '<leader>c', group = 'Code/AI' },
      { '<leader>d', group = 'Diagnostics/Debug' },
      { '<leader>f', group = 'Find/File' },
      { '<leader>g', group = 'Git/Diff' },
      { '<leader>h', group = 'Hunk/Help' },
      { '<leader>i', group = 'Imports' },
      { '<leader>j', group = 'Jump' },
      { '<leader>l', group = 'Line/LazyGit' },
      { '<leader>m', group = 'Markdown' },
      { '<leader>o', group = 'Overseer' },
      { '<leader>p', group = 'Project' },
      { '<leader>q', group = 'Macro' },
      { '<leader>r', group = 'Replace/Run' },
      { '<leader>s', group = 'Session/Search' },
      { '<leader>t', group = 'Toggle/Terminal' },
      { '<leader>v', group = 'Visual/Terminal' },
      { '<leader>w', group = 'Window/Split' },
      { '<leader>x', group = 'Diagnostics/Quickfix' },
    },
    win = {
      border = 'rounded',
      padding = { 1, 2 },
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = 'left',
    },
    show_help = true,
    show_keys = true,
    triggers = {
      { '<auto>', mode = 'nxso' },
    },
  },
  -- Keymaps are in lua/core/keymaps.lua (Section 8.14)
}
