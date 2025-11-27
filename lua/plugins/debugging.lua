return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    -- Setup DAP UI
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      -- Expand lines larger than the window
      expand_lines = vim.fn.has("nvim-0.7") == 1,
      -- Layouts define sections of the screen to place windows.
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            "breakpoints",
            "stacks",
            "watches",
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 0.25,
          position = "bottom",
        },
      },
      controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "↻",
          terminate = "□",
        },
      },
      floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil,
        max_value_lines = 100,
      }
    })

    -- Setup virtual text
    require('nvim-dap-virtual-text').setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = false,
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value
        else
          return variable.name .. ' = ' .. variable.value
        end
      end,
      virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil
    })

    -- Auto open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Python debugging setup
    require('dap-python').setup('python')
    
    -- Python configurations
    table.insert(dap.configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'Launch file with arguments',
      program = '${file}',
      args = function()
        local args_string = vim.fn.input('Arguments: ')
        return vim.split(args_string, " +")
      end,
      console = 'integratedTerminal',
      cwd = '${workspaceFolder}',
    })

    -- Node.js debugging
    dap.adapters.node2 = {
      type = 'executable',
      command = 'node',
      args = {os.getenv('HOME') .. '/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js'},
    }

    dap.configurations.javascript = {
      {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
      {
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        processId = require'dap.utils'.pick_process,
      },
    }

    dap.configurations.typescript = dap.configurations.javascript

    -- C/C++ debugging using codelldb
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.stdpath("data") .. '/mason/packages/codelldb/extension/adapter/codelldb',
        args = { '--port', '${port}' },
      },
    }

    -- C/C++ configurations
    dap.configurations.cpp = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
          local args_string = vim.fn.input('Arguments: ')
          return vim.split(args_string, ' +')
        end,
        runInTerminal = false,
      },
      {
        name = 'Attach to process',
        type = 'codelldb',
        request = 'attach',
        pid = function()
          local handle = io.popen('ps aux | grep -v grep')
          if handle then
            local result = handle:read('*a')
            handle:close()
            return vim.fn.input('PID: ')
          end
          return ''
        end,
        args = {},
      },
    }

    -- Share C++ config with C
    dap.configurations.c = dap.configurations.cpp

    -- Bash debugging
    dap.adapters.bashdb = {
      type = 'executable',
      command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
      name = 'bashdb',
    }

    dap.configurations.sh = {
      {
        type = 'bashdb',
        request = 'launch',
        name = 'Launch file',
        showDebugOutput = true,
        pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
        pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
        trace = true,
        file = '${file}',
        program = '${file}',
        cwd = '${workspaceFolder}',
        pathCat = 'cat',
        pathBash = '/bin/bash',
        pathMkfifo = 'mkfifo',
        pathPkill = 'pkill',
        args = {},
        env = {},
        terminalKind = 'integrated',
      }
    }

    -- DAP signs
    vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
    vim.fn.sign_define('DapBreakpointCondition', {text='🟡', texthl='', linehl='', numhl=''})
    vim.fn.sign_define('DapLogPoint', {text='🔵', texthl='', linehl='', numhl=''})
    vim.fn.sign_define('DapStopped', {text='▶️', texthl='', linehl='debugPC', numhl=''})
    vim.fn.sign_define('DapBreakpointRejected', {text='❌', texthl='', linehl='', numhl=''})
  end,
}