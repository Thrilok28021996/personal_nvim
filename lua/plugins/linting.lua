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
    vim.api.nvim_create_augroup('nvim_lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'InsertLeave' }, {
      group = 'nvim_lint',
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
