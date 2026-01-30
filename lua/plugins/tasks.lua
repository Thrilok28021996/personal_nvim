return {
  {
    'stevearc/overseer.nvim',
    opts = {
      -- Strategy for running tasks (jobstart uses Neovim's native job control)
      strategy = 'jobstart',

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

      -- Common task templates (simplified - use overseer auto-detection for most)
      overseer.register_template {
        name = 'Run: Current file',
        builder = function()
          local file = vim.fn.expand '%:p'
          local ft = vim.bo.filetype
          local cmd = ft == 'python' and 'python3' or ft == 'lua' and 'lua' or 'node'
          return {
            cmd = { cmd },
            args = { file },
            components = { 'default' },
          }
        end,
        condition = {
          filetype = { 'python', 'lua', 'javascript' },
        },
      }

      overseer.register_template {
        name = 'Build: Make',
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
        name = 'Test: Current project',
        builder = function()
          local ft = vim.bo.filetype
          local cmd = ft == 'python' and 'pytest' or 'make test'
          return {
            cmd = vim.split(cmd, ' '),
            components = { 'default' },
          }
        end,
        condition = {
          filetype = { 'python', 'c', 'cpp' },
        },
      }
    end,
  },
}
