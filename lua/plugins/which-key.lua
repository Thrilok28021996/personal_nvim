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
      { '<leader>c', group = 'Code/LSP' },
      { '<leader>d', group = 'Diagnostics/Debug' },
      { '<leader>f', group = 'Find/File' },
      { '<leader>g', group = 'Git' },
      { '<leader>h', group = 'Help' },
      { '<leader>i', group = 'Imports' },
      { '<leader>j', group = 'Jump' },
      { '<leader>l', group = 'Lazy/LSP' },
      { '<leader>m', group = 'Marks' },
      { '<leader>p', group = 'Python' },
      { '<leader>q', group = 'Quit/Macro' },
      { '<leader>r', group = 'Registers/Replace/Run' },
      { '<leader>s', group = 'Session/Search' },
      { '<leader>t', group = 'Toggle/Test/Terminal' },
      { '<leader>v', group = 'Split' },
      { '<leader>w', group = 'Window' },
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
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
