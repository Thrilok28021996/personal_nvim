return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- Removed 'icon' column to eliminate mini.icons dependency
    -- Using native file type indicators instead
    columns = {
      'size',
    },
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
    -- Disable default keymaps (use explicit keymaps only)
    keymaps = {
      ['g?'] = 'actions.show_help',
      ['<CR>'] = 'actions.select',
      ['<C-v>'] = 'actions.select_vsplit',
      ['<C-s>'] = 'actions.select_split',
      ['<C-t>'] = 'actions.select_tab',
      ['<C-p>'] = 'actions.preview',
      ['<C-c>'] = 'actions.close',
      ['<C-l>'] = 'actions.refresh',
      ['-'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      ['`'] = 'actions.cd',
      ['~'] = 'actions.tcd',
      ['gs'] = 'actions.change_sort',
      ['gx'] = 'actions.open_external',
      ['g.'] = 'actions.toggle_hidden',
      ['g\\'] = 'actions.toggle_trash',
    },
  },
  -- Removed mini.icons dependency - using native file type detection
  lazy = false,
}
