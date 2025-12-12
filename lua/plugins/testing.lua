return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- Test adapters
      'nvim-neotest/neotest-python',
      'alfaix/neotest-gtest', -- For C++ GoogleTest
    },
    config = function()
      -- Build adapters list dynamically
      local adapters = {
        require('neotest-python') {
          -- Use pytest by default
          runner = 'pytest',
          -- Use the python from the virtual environment if available
          python = function()
            local venv = vim.fn.getcwd() .. '/venv/bin/python'
            if vim.fn.filereadable(venv) == 1 then
              return venv
            end
            return 'python3'
          end,
          -- Arguments for pytest
          args = { '--log-level', 'DEBUG', '-vv' },
        },
      }

      -- Try to load C++ adapter (requires cpp treesitter parser)
      local ok, gtest = pcall(require, 'neotest-gtest')
      if ok then
        table.insert(adapters, gtest.setup {})
      else
        vim.notify('C++ treesitter parser not installed yet. Install with :TSInstall cpp', vim.log.levels.WARN)
      end

      require('neotest').setup {
        adapters = adapters,
        -- Status and output display
        status = {
          enabled = true,
          signs = true,
          virtual_text = true,
        },
        output = {
          enabled = true,
          open_on_run = false, -- Don't auto-open output
        },
        -- Diagnostic display
        diagnostic = {
          enabled = true,
        },
        -- Floating window for test output
        floating = {
          border = 'rounded',
          max_height = 0.8,
          max_width = 0.9,
        },
        -- Summary window configuration
        summary = {
          enabled = true,
          follow = true,
          expand_errors = true,
        },
        -- Icons for test status
        icons = {
          passed = '✓',
          running = '●',
          failed = '✗',
          skipped = '⊝',
          unknown = '?',
          running_animated = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
        },
      }
      -- Keymaps are in lua/core/keymaps.lua
    end,
  },
}
