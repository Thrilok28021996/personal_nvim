return {
  'williamboman/mason.nvim',
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  event = 'VimEnter', -- Load on startup instead of VeryLazy
  priority = 100, -- Load early
  config = function()
    local mason = require 'mason'

    local mason_tool_installer = require 'mason-tool-installer'

    -- enable mason and configure icons
    mason.setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        'prettier', -- prettier formatter
        'stylua', -- lua formatter
        'isort', -- python formatter
        'black', -- python formatter
        'pylint', -- python linter
        'ruff', -- python formatter & linter
        'pyright', -- Python Language server

        -- C/C++ tools
        'clangd', -- C/C++ Language server
        'clang-format', -- C/C++ formatter
        'codelldb', -- C/C++ debugger

        -- Lua tools
        'lua-language-server', -- Lua LSP for Neovim config
      },

      -- Automatically install tools on startup
      auto_update = false,
      run_on_start = true,
      start_delay = 3000, -- 3 second delay after start
      debounce_hours = 5, -- at least 5 hours between attempts
    }
  end,
}
