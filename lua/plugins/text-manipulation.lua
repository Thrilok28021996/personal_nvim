return {
  -- Comment plugin for <C-/> keybinding functionality
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {
      toggler = {
        line = 'gcc',
        block = 'gbc',
      },
      opleader = {
        line = 'gc',
        block = 'gb',
      },
      extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
      },
    },
  },
}