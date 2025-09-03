return {
  'williamboman/mason.nvim',
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
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
        -- Formatters
        'prettier', -- prettier formatter
        'stylua', -- lua formatter
        'isort', -- python formatter
        'black', -- python formatter
        'shfmt', -- shell script formatter

        -- Linters
        'ruff', -- python linter (also has ruff_format for formatting)

        -- Language Servers
        'pyright', -- Python Language server
        'lua-language-server', -- Lua LSP
        'typescript-language-server', -- TypeScript/JavaScript LSP
        'json-lsp', -- JSON LSP
        'yaml-language-server', -- YAML LSP
        'html-lsp', -- HTML LSP
        'css-lsp', -- CSS LSP
        'bash-language-server', -- Bash LSP
        'dockerfile-language-server', -- Dockerfile LSP

        -- Debug Adapters
        'debugpy', -- Python debugger
        -- 'node-debug2-adapter', -- Node.js debugger
        'bash-debug-adapter', -- Bash debugger

        -- Test Runners
        -- pytest is installed via pip, not Mason
      },
    }
  end,
}
