return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  lazy = true,
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        markdown = { 'prettier' },
        lua = { 'stylua' },
        python = { 'isort', 'black', 'ruff' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    }
  end,
}
