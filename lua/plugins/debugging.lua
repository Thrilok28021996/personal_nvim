return {
  'mfussenegger/nvim-dap',
  lazy = true,
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Setup DAP UI
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.25 },
            'breakpoints',
            'stacks',
            'watches',
          },
          size = 40,
          position = 'left',
        },
        {
          elements = { 'repl', 'console' },
          size = 0.25,
          position = 'bottom',
        },
      },
      controls = {
        icons = {
          pause = '', play = '', step_into = '', step_over = '',
          step_out = '', step_back = '', run_last = '↻', terminate = '□',
        },
      },
      floating = { border = 'rounded' },
    }

    -- Setup virtual text
    require('nvim-dap-virtual-text').setup {
      highlight_changed_variables = true,
      virt_text_pos = 'inline',
      display_callback = function(variable, _, _, _, options)
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value
        end
        return variable.name .. ' = ' .. variable.value
      end,
    }

    -- Auto open/close DAP UI
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- Python debugging setup
    require('dap-python').setup 'python3'

    -- Python configurations
    table.insert(dap.configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'Launch file with arguments',
      program = '${file}',
      args = function()
        local args_string = vim.fn.input 'Arguments: '
        return vim.split(args_string, '%s+')
      end,
      console = 'integratedTerminal',
      cwd = '${workspaceFolder}',
    })

    -- Node.js debugging (modern pwa-node adapter)
    -- Install: npm install -g js-debug OR download from https://github.com/microsoft/vscode-js-debug/releases
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        -- Update this path if you installed js-debug elsewhere
        args = { vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
      },
    }

    dap.configurations.javascript = {
      {
        name = 'Launch file',
        type = 'pwa-node',
        request = 'launch',
        program = '${file}',
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        console = 'integratedTerminal',
      },
      {
        name = 'Attach to process',
        type = 'pwa-node',
        request = 'attach',
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
      },
    }

    dap.configurations.typescript = dap.configurations.javascript

    -- C/C++ debugging using codelldb
    -- Resolves to system install (brew install codelldb) or mason fallback
    local codelldb_cmd = vim.fn.exepath 'codelldb' ~= '' and vim.fn.exepath 'codelldb'
      or vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb'
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = codelldb_cmd,
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
          local args_string = vim.fn.input 'Arguments: '
          return vim.split(args_string, '%s+')
        end,
        runInTerminal = false,
      },
      {
        name = 'Attach to process',
        type = 'codelldb',
        request = 'attach',
        pid = require('dap.utils').pick_process,
        args = {},
      },
    }

    -- Share C++ config with C
    dap.configurations.c = dap.configurations.cpp

    -- Bash debugging (mason-installed only)
    local mason_pkg = vim.fn.stdpath 'data' .. '/mason/packages'
    dap.adapters.bashdb = {
      type = 'executable',
      command = mason_pkg .. '/bash-debug-adapter/bash-debug-adapter',
      name = 'bashdb',
    }

    dap.configurations.sh = {
      {
        type = 'bashdb',
        request = 'launch',
        name = 'Launch file',
        showDebugOutput = true,
        pathBashdb    = mason_pkg .. '/bash-debug-adapter/extension/bashdb_dir/bashdb',
        pathBashdbLib = mason_pkg .. '/bash-debug-adapter/extension/bashdb_dir',
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
      },
    }

    -- DAP signs
    vim.fn.sign_define('DapBreakpoint',          { text = '●', texthl = 'DiagnosticError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DiagnosticWarn',  linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint',            { text = '◉', texthl = 'DiagnosticInfo',  linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped',             { text = '▶', texthl = 'DiagnosticOk',    linehl = 'debugPC', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected',  { text = '○', texthl = 'DiagnosticHint',  linehl = '', numhl = '' })
  end,
}
