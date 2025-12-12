return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    -- Indentation guides
    require('mini.indentscope').setup { symbol = '│' }

    -- Fuzzy finding
    require('mini.pick').setup {
      source = {
        cwd = vim.fn.getcwd(),
      },
    }

    -- Status line
    require('mini.statusline').setup()

    -- Auto pairs
    require('mini.pairs').setup()

    -- Icons
    require('mini.icons').setup()

    -- Tabline
    require('mini.tabline').setup()
  end,
}
