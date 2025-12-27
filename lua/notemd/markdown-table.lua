return {
  'dhruvasagar/vim-table-mode',
  ft = 'markdown',
  config = function()
    -- Use markdown-compatible tables
    vim.g.table_mode_corner = '|'
    vim.g.table_mode_corner_corner = '|'
    vim.g.table_mode_header_fillchar = '-'

    -- Enable table mode for markdown files automatically
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.cmd 'TableModeEnable'
      end,
    })
  end,
}
