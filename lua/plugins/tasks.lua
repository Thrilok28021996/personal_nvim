return {
  {
    'stevearc/overseer.nvim',
    cmd = { 'OverseerToggle', 'OverseerRun', 'OverseerOpen', 'OverseerClose', 'OverseerQuickAction', 'OverseerTaskAction', 'OverseerBuild', 'OverseerInfo' },
    opts = {
      -- Strategy for running tasks (jobstart uses Neovim's native job control)
      strategy = 'jobstart',

      -- Templates to use
      templates = { 'builtin', 'user' },

      -- Auto-detect tasks from common build systems
      auto_detect_success_color = true,

      -- DAP integration for preLaunchTask/postDebugTask (disabled initially for lazy-loading)
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
        -- Alias for tasks that should populate quickfix on errors
        default_with_qf = {
          { 'display_duration', detail_level = 2 },
          'on_output_summarize',
          'on_exit_set_status',
          { 'on_output_quickfix', open = true, open_on_match = true, open_height = 8 },
          'on_complete_notify',
          'on_complete_dispose',
        },
        -- Alias for tasks that restart on save (useful for watch-mode development)
        default_restart_on_save = {
          { 'display_duration', detail_level = 2 },
          'on_output_summarize',
          'on_exit_set_status',
          'restart_on_save',
          'on_complete_notify',
        },
      },
    },

    config = function(_, opts)
      local overseer = require 'overseer'
      overseer.setup(opts)

      -- Enable DAP integration (for preLaunchTask/postDebugTask support)
      -- This allows debug configurations to run tasks before/after debugging
      local dap_ok = pcall(require, 'dap')
      if dap_ok then
        overseer.enable_dap()
      end

      -- Keymaps are in lua/core/keymaps.lua

      -- Common task templates (simplified - use overseer auto-detection for most)
      overseer.register_template {
        name = 'Run: Current file',
        builder = function()
          local file = vim.fn.expand '%:p'
          local ft = vim.bo.filetype
          local cmd = ft == 'python' and 'python3' or ft == 'lua' and 'lua' or nil
          if not cmd then
            return { cmd = { 'echo' }, args = { 'No runner for ' .. ft } }
          end
          return {
            cmd = { cmd },
            args = { file },
            components = { 'default' },
          }
        end,
        condition = {
          filetype = { 'python', 'lua' },
        },
      }

      overseer.register_template {
        name = 'Build: Make',
        builder = function()
          return {
            cmd = { 'make' },
            components = { 'default_with_qf' }, -- Errors go to quickfix
          }
        end,
        condition = {
          filetype = { 'cpp', 'c' },
        },
      }

      overseer.register_template {
        name = 'Build: CMake',
        builder = function()
          return {
            cmd = { 'cmake' },
            args = { '--build', 'build' },
            components = { 'default_with_qf' }, -- Errors go to quickfix
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
          local test_cmds = {
            python = { 'pytest' },
            c = { 'make', 'test' },
            cpp = { 'make', 'test' },
          }
          local parts = test_cmds[ft] or { 'echo', 'No test runner for ' .. ft }
          return {
            cmd = { parts[1] },
            args = vim.list_slice(parts, 2),
            components = { 'default_with_qf' }, -- Test failures go to quickfix
          }
        end,
        condition = {
          filetype = { 'python', 'c', 'cpp' },
        },
      }

      overseer.register_template {
        name = 'Lint: Current file',
        builder = function()
          local file = vim.fn.expand '%:p'
          local ft = vim.bo.filetype
          local lint_cmds = {
            python = { 'ruff', 'check', file },
            c = { 'clang-tidy', file },
            cpp = { 'clang-tidy', file },
          }
          local parts = lint_cmds[ft] or { 'echo', 'No linter for ' .. ft }
          return {
            cmd = { parts[1] },
            args = vim.list_slice(parts, 2),
            components = { 'default_with_qf' }, -- Lint errors go to quickfix
          }
        end,
        condition = {
          filetype = { 'python', 'c', 'cpp' },
        },
      }
    end,
  },
}
