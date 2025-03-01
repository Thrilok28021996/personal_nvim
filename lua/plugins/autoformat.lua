return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  lazy = false,
  config = function()
    require('conform').setup {
      formatters_by_ft = {

        -- Conform will run multiple formatters sequentially
        -- javascript = { "prettier" },
        -- typescript = { "prettier" },
        -- javascriptreact = { "prettier" },
        -- typescriptreact = { "prettier" },
        -- svelte = { "prettier" },
        -- css = { "prettier" },
        -- html = { "prettier" },
        -- json = { "prettier" },
        -- yaml = { "prettier" },
        markdown = { 'prettier' },
        -- graphql = { "prettier" },
        lua = { 'stylua' },
        -- python = { 'isort', 'black', 'ruff_format' },
        python = { 'isort', 'ruff_format' },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    }
  end,
}
