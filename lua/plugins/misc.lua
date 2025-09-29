return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    -- File Viewer
    -- require("mini.files").setup()
    -- vim.keymap.set("n", "<leader>e", function() MiniFiles.open() end)

    -- Indentation guides
    require('mini.indentscope').setup { symbol = '│' }

    -- Fuzzy finding
    require('mini.pick').setup({
      source = {
        cwd = vim.fn.getcwd()
      }
    })

    -- Status line
    require('mini.statusline').setup()
    -- pairs
    require('mini.pairs').setup()
    -- icons
    require('mini.icons').setup()
    -- tabs line
    require('mini.tabline').setup()
  end,
}
