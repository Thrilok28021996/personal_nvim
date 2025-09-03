return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',

    -- Test adapters for different languages
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-jest',
    'nvim-neotest/neotest-go',
    'rouge8/neotest-rust',
    'rcasia/neotest-bash',
  },
  config = function()
    local neotest = require 'neotest'

    neotest.setup {
      adapters = {
        -- Python testing with pytest
        require 'neotest-python' {
          dap = { justMyCode = false },
          args = { '--log-level', 'DEBUG' },
          runner = 'pytest',
        },

        -- JavaScript/TypeScript testing with Jest
        require 'neotest-jest' {
          jestCommand = 'npm test --',
          jestConfigFile = function(file)
            if string.find(file, '/packages/') then
              return string.match(file, '(.-/[^/]+/)src') .. 'jest.config.js'
            end
            return vim.fn.getcwd() .. '/jest.config.js'
          end,
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
          jest_test_discovery = false,
        },

        -- Go testing
        require 'neotest-go' {
          experimental = {
            test_table = true,
          },
          args = { '-count=1', '-timeout=60s' },
        },

        -- Rust testing
        require 'neotest-rust' {
          args = { '--no-capture' },
        },

        -- Bash testing
        require 'neotest-bash',
      },

      -- Global configuration
      discovery = {
        enabled = true,
        concurrent = 1,
      },

      running = {
        concurrent = true,
      },

      summary = {
        enabled = true,
        animated = true,
        follow = true,
        expand_errors = true,
      },

      icons = {
        child_indent = '│',
        child_prefix = '├',
        collapsed = '─',
        expanded = '╮',
        failed = '✖',
        final_child_indent = ' ',
        final_child_prefix = '╰',
        non_collapsible = '─',
        passed = '✓',
        running = '󰑮',
        running_animated = { '/', '|', '\\', '-', '/', '|', '\\', '-' },
        skipped = '○',
        unknown = '?',
      },

      floating = {
        border = 'rounded',
        max_height = 0.6,
        max_width = 0.6,
        options = {},
      },

      strategies = {
        integrated = {
          height = 40,
          width = 120,
        },
      },

      status = {
        enabled = true,
        signs = true,
        virtual_text = false,
      },

      output = {
        enabled = true,
        open_on_run = 'short',
      },

      quickfix = {
        enabled = true,
        open = false,
      },

      -- Watch mode configuration
      watch = {
        enabled = true,
        symbol_queries = {
          python = [[
            ;; query
            ((identifier) @symbol
             (#match? @symbol "^test_"))
          ]],
          javascript = [[
            ;; query  
            (call_expression
              function: (identifier) @symbol
              (#match? @symbol "^(test|it|describe)$"))
          ]],
          typescript = [[
            ;; query
            (call_expression
              function: (identifier) @symbol
              (#match? @symbol "^(test|it|describe)$"))
          ]],
        },
      },
    }
  end,
}

