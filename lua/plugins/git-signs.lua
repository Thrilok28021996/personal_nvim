-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    signs_staged = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    -- Keymaps defined in lua/core/keymaps.lua (Section 8.16)
    on_attach = function(bufnr)
      if _G.gitsigns_on_attach then
        _G.gitsigns_on_attach(bufnr)
      end
    end,
  },
}
