return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  ft = { 'markdown', 'norg', 'rmd', 'org' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    -- Enable/disable the plugin
    enabled = true,
    -- Log level ('off', 'error', 'warn', 'info', 'debug', 'trace')
    log_level = 'error',
  },

  -- Note: Keymaps are defined in core/keymaps.lua

  -- Configuration function
  config = function(_, opts)
    require('render-markdown').setup(opts)

    -- Additional autocommands for markdown files
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        -- Set up markdown-specific options (centralized)
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.conceallevel = 2  -- Changed from 3 to 2 for better compatibility
        vim.opt_local.concealcursor = 'n'
        vim.opt_local.spell = true  -- Enable spell checking for markdown files
        vim.opt_local.spelllang = 'en_us'

        -- Note: Markdown-specific keymaps are handled in core/keymaps.lua
      end,
    })
  end,
}
