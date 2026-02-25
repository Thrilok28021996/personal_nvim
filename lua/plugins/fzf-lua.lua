return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  event = 'LspAttach', -- Load when LSP attaches for LSP navigation keymaps
  opts = {
    'fzf-native',
    fzf_opts = { ['--layout'] = 'reverse' },
    winopts = {
      height = 0.85,
      width = 0.80,
      row = 0.35,
      col = 0.50,
      preview = {
        layout = 'flex',
        flip_columns = 120,
      },
    },
    files = {
      cmd = 'fd --type f --hidden --exclude .git',
    },
    grep = {
      rg_opts = '--column --line-number --no-heading --color=always --smart-case',
    },
  },
  config = function(_, opts)
    local fzf = require 'fzf-lua'
    fzf.setup(opts)
    -- Use fzf-lua for all vim.ui.select calls (code actions, project picker, etc.)
    fzf.register_ui_select()
  end,
}
