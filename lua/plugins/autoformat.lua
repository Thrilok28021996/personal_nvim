return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  lazy=false,
  config = function()
  require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
end
}
