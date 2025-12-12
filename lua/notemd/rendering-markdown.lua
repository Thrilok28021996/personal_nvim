return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  lazy = true,
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  config = function()
    require('render-markdown').setup {
      render_modes = true,
      -- Disable latex support (not needed, removes 3 warnings)
      latex = { enabled = false },
    }
  end,
}
