return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        -- JavaScript/TypeScript
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },

        -- Web Technologies
        html = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },

        -- Configuration Files
        json = { 'prettier' },
        yaml = { 'prettier' },

        -- Documentation
        markdown = { 'prettier' },

        -- Programming Languages
        lua = { 'stylua' },
        python = { 'isort', 'black', 'ruff_format' },

        -- Shell Scripting
        bash = { 'shfmt' },
        sh = { 'shfmt' },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
    }
  end,
}
