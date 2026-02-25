return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    adapters = {
      ollama = function()
        return require('codecompanion.adapters').extend('ollama', {
          schema = {
            model = {
              default = 'qwen2.5-coder:latest',
            },
          },
        })
      end,
    },
    strategies = {
      chat = { adapter = 'ollama' },
      inline = { adapter = 'ollama' },
      agent = { adapter = 'ollama' },
    },
    display = {
      chat = {
        window = {
          layout = 'float',
          width = function()
            return math.floor(vim.o.columns * 0.7)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.7)
          end,
          relative = 'editor',
        },
      },
      inline = {
        layout = 'buffer',
      },
    },
  },
  -- Keymaps are in lua/core/keymaps.lua (Section 8.8)
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
}
