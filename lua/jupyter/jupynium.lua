return {
  'kiyoon/jupynium.nvim',
  build = 'pip3 install --user .',
  dependencies = {
    -- "hrsh7th/nvim-cmp",
    'saghen/blink.cmp',
    'nvim-lua/plenary.nvim',
    'madox2/vim-ai',
  },

  config = function()
    require('jupynium').setup {
      cell_markers = { '# %%', '# %%' },
      default_notebook_URL = 'localhost:8888/nbclassic',
    }
  end,
}
