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
    require('mini.pick').setup()
    -- vim.keymap.set('n', '<leader>ff', function()
    --   MiniPick.builtin.files()
    -- end, { desc = 'Find Files' })
    -- vim.keymap.set('n', '<leader>fg', function()
    --   MiniPick.builtin.grep_live()
    -- end, { desc = 'Find the word' })

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
