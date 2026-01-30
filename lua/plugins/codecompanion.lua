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
        local model_name = vim.fn.input('Enter Ollama model (default qwen2.5-coder:latest): ', 'qwen2.5-coder:latest')
        return require('codecompanion.adapters').extend('ollama', {
          schema = {
            model = {
              default = model_name,
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
          -- dynamically set width and height relative to editor size
          width = function()
            return math.floor(vim.o.columns * 0.5)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.4)
          end,
          relative = 'editor',
        },
      },
    },
  },
  keys = {
    { '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Toggle Chat' },
    { '<leader>ca', '<cmd>CodeCompanionActions<cr>', desc = 'Actions' },
    { '<leader>ci', '<cmd>CodeCompanion<cr>', desc = 'Inline Prompt' },
    { '<leader>cx', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = 'Add to Chat' }, -- fixed unique leader
  },
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
}
