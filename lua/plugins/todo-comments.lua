return {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  keys = {
    { ']T', function() require('todo-comments').jump_next() end, desc = 'Next TODO' },
    { '[T', function() require('todo-comments').jump_prev() end, desc = 'Prev TODO' },
    { '<leader>ft', '<cmd>TodoQuickFix<CR>', desc = 'TODOs to quickfix' },
  },
}
