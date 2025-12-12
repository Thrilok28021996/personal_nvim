return {
  {
    'stevearc/overseer.nvim',
    opts = {
      -- Strategy for running tasks
      strategy = {
        'toggleterm',
        -- Use terminal at bottom
        direction = 'horizontal',
        -- Close terminal when task completes
        close_on_exit = false,
        -- Don't open terminal automatically
        open_on_start = true,
        -- Hidden by default
        hidden = false,
      },

      -- Templates to use
      templates = { 'builtin', 'user' },

      -- Auto-detect tasks from common build systems
      auto_detect_success_color = true,

      -- Notify when tasks complete
      dap = false,

      -- Task list configuration
      task_list = {
        direction = 'bottom',
        min_height = 10,
        max_height = 25,
        default_detail = 1,
        bindings = {
          ['?'] = 'ShowHelp',
          ['g?'] = 'ShowHelp',
          ['<CR>'] = 'RunAction',
          ['<C-e>'] = 'Edit',
          ['o'] = 'Open',
          ['<C-v>'] = 'OpenVsplit',
          ['<C-s>'] = 'OpenSplit',
          ['<C-f>'] = 'OpenFloat',
          ['<C-q>'] = 'OpenQuickFix',
          ['p'] = 'TogglePreview',
          ['<C-l>'] = 'IncreaseDetail',
          ['<C-h>'] = 'DecreaseDetail',
          ['L'] = 'IncreaseAllDetail',
          ['H'] = 'DecreaseAllDetail',
          ['['] = 'DecreaseWidth',
          [']'] = 'IncreaseWidth',
          ['{'] = 'PrevTask',
          ['}'] = 'NextTask',
          ['<C-k>'] = 'ScrollOutputUp',
          ['<C-j>'] = 'ScrollOutputDown',
          ['q'] = 'Close',
        },
      },

      -- Form configuration
      form = {
        border = 'rounded',
        win_opts = {
          winblend = 0,
        },
      },

      -- Confirmation before running tasks
      confirm = {
        border = 'rounded',
        win_opts = {
          winblend = 0,
        },
      },

      -- Task launcher configuration
      task_launcher = {
        border = 'rounded',
        win_opts = {
          winblend = 0,
        },
      },

      -- Task editor configuration
      task_editor = {
        border = 'rounded',
        win_opts = {
          winblend = 0,
        },
      },

      -- Component aliases (for output formatting)
      component_aliases = {
        default = {
          { 'display_duration', detail_level = 2 },
          'on_output_summarize',
          'on_exit_set_status',
          'on_complete_notify',
          'on_complete_dispose',
        },
      },
    },

    config = function(_, opts)
      local overseer = require 'overseer'
      overseer.setup(opts)

      -- Keymaps are in lua/core/keymaps.lua

      -- Add some common task templates
      overseer.register_template {
        name = 'Python: Run current file',
        builder = function()
          return {
            cmd = { 'python3' },
            args = { vim.fn.expand '%:p' },
            components = { 'default' },
          }
        end,
        condition = {
          filetype = { 'python' },
        },
      }

      overseer.register_template {
        name = 'Python: pytest current file',
        builder = function()
          return {
            cmd = { 'pytest' },
            args = { vim.fn.expand '%:p', '-v' },
            components = { 'default' },
          }
        end,
        condition = {
          filetype = { 'python' },
        },
      }

      overseer.register_template {
        name = 'Python: pytest all',
        builder = function()
          return {
            cmd = { 'pytest' },
            args = { '-v' },
            components = { 'default' },
          }
        end,
        condition = {
          filetype = { 'python' },
        },
      }

      overseer.register_template {
        name = 'C++: Build with make',
        builder = function()
          return {
            cmd = { 'make' },
            components = { 'default' },
          }
        end,
        condition = {
          filetype = { 'cpp', 'c' },
        },
      }

      overseer.register_template {
        name = 'C++: Run executable',
        builder = function()
          -- Get the executable name (assuming it's the basename of current file)
          local file = vim.fn.expand '%:t:r'
          return {
            cmd = { './' .. file },
            components = { 'default' },
          }
        end,
        condition = {
          filetype = { 'cpp', 'c' },
        },
      }

      overseer.register_template {
        name = 'C++: Build and run',
        builder = function()
          local file = vim.fn.expand '%:t:r'
          return {
            cmd = { 'sh' },
            args = { '-c', 'make && ./' .. file },
            components = { 'default' },
          }
        end,
        condition = {
          filetype = { 'cpp', 'c' },
        },
      }

      overseer.register_template {
        name = 'CMake: Build',
        builder = function()
          return {
            cmd = { 'cmake' },
            args = { '--build', 'build' },
            components = { 'default' },
          }
        end,
        condition = {
          filetype = { 'cpp', 'c' },
        },
      }
    end,
  },
}
