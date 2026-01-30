return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      python = { 'ruff' },
      c = { 'clangtidy' },
      cpp = { 'clangtidy' },
    }
    -- Lint only on save (not too aggressive)
    vim.api.nvim_create_autocmd('BufWritePost', {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
