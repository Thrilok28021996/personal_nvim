return {
  -- Zen mode for distraction-free writing
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    keys = {
      { '<leader>z', '<cmd>ZenMode<cr>', desc = 'Toggle Zen Mode' },
    },
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
          twilight = { enabled = true },
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

  -- Twilight for better focus
  {
    'folke/twilight.nvim',
    cmd = { 'Twilight', 'TwilightEnable', 'TwilightDisable' },
    config = function()
      require('twilight').setup {
        dimming = {
          alpha = 0.25,
          color = { 'Normal', '#ffffff' },
          term_bg = '#000000',
          inactive = false,
        },
        context = 10,
        treesitter = true,
        expand = {
          'function',
          'method',
          'table',
          'if_statement',
        },
        exclude = {},
      }
    end,
  },
}
