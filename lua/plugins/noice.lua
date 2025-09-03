<<<<<<< HEAD
-- NOTE: noice.nvim removed - using default Neovim UI
-- Built-in alternatives provide all essential functionality:
-- - Default command line and messages work perfectly
-- - Native LSP hover and signature help
-- - Built-in completion popupmenu
-- - :messages to view message history
-- Benefits: Faster startup, more stable, learn default Neovim interface
return {}
=======
-- lazy.nvim
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {},
  dependencies = {

    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('noice').setup {
      lsp = {},

      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    }
  end,
}
>>>>>>> refs/remotes/origin/main
