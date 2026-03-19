return {
  -- Zen mode for distraction-free writing
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    -- Keymaps are in lua/core/keymaps.lua (Section 6)
    config = function()
      require('zen-mode').setup {
        window = {
          backdrop = 0.95,
          width = 0.85,
          height = 0.9,
          options = {
            signcolumn = 'no',
            number = false,
            relativenumber = false,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = '0',
            list = false,
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false,
            showcmd = false,
            laststatus = 0,
          },
          twilight = { enabled = false },
          gitsigns = { enabled = false },
          tmux = { enabled = false },
          kitty = {
            enabled = false,
            font = '+4',
          },
        },
      }
    end,
  },
}
