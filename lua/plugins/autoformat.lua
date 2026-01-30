return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = { 'n', 'v' },
      desc = 'Format buffer',
    },
  },
  config = function()
    -- Initialize autoformat flag (default to enabled)
    vim.g.disable_autoformat = false

    require('conform').setup {
      formatters_by_ft = {
        markdown = { 'prettier' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        json = { 'prettier' },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 1000, lsp_fallback = true }
      end,
    }

    -- Command to toggle format on save
    vim.api.nvim_create_user_command('FormatToggle', function()
      if vim.g.disable_autoformat then
        vim.g.disable_autoformat = false
        vim.notify('Format on save enabled', vim.log.levels.INFO)
      else
        vim.g.disable_autoformat = true
        vim.notify('Format on save disabled', vim.log.levels.WARN)
      end
    end, {
      desc = 'Toggle format on save',
    })
  end,
}
