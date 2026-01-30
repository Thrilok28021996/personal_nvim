-- Enhance Neovim's native commenting with better treesitter integration
-- Note: Neovim 0.10+ has built-in commenting (gc, gcc operators)
-- This plugin enhances it with better treesitter-aware comment detection
return {
  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
    opts = {},
  },
}
