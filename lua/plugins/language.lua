-- nvim-lspconfig for LSP support
-- return {
--   'neovim/nvim-lspconfig',
--   config = function()
--     require('lspconfig').pylsp.setup {
--       on_attach = function(client, bufnr)
--         -- Enable autoformat on save
--         vim.api.nvim_create_autocmd('BufWritePre', {
--           buffer = bufnr,
--           callback = function()
--             vim.lsp.buf.format { async = false }
--           end,
--         })
--       end,
--       settings = {
--         pylsp = {
--           plugins = {
--             -- black = { enabled = true },
--             -- pyflakes = { enabled = false },
--             -- pycodestyle = { enabled = false },
--           },
--         },
--       },
--     }
--   end,
-- }
--
--
-- Updated to use modern vim.lsp.config instead of deprecated lspconfig
return {
  'neovim/nvim-lspconfig',
  config = function()
    -- Modern approach using vim.lsp.config (Neovim 0.11+)

    -- Python LSP (Pyright)
    vim.lsp.config.pyright = {
      cmd = { 'pyright-langserver', '--stdio' },
      filetypes = { 'python' },
      settings = {
        python = {
          analysis = {
            typeCheckingMode = 'basic', -- Adjust as needed ("off", "basic", "strict")
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'openFilesOnly',
          },
        },
      },
    }

    -- C++ LSP (clangd)
    vim.lsp.config.clangd = {
      cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=iwyu',
        '--completion-style=detailed',
        '--function-arg-placeholders',
        '--fallback-style=llvm',
      },
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
      root_markers = {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git',
      },
      capabilities = {
        offsetEncoding = { 'utf-16' },
      },
    }

    -- Set up autocommand for formatting on save
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and (client.name == 'pyright' or client.name == 'clangd') then
          -- Enable autoformat on save using conform
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              require('conform').format { async = false }
            end,
          })
        end

        -- LSP keybindings (using Neovim built-ins)
        if client then
          local opts = { buffer = args.buf, silent = true }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        end
      end,
    })

    -- Enable pyright for Python files
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'python',
      callback = function()
        vim.lsp.enable('pyright')
      end,
    })

    -- Enable clangd for C/C++ files
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
      callback = function()
        vim.lsp.enable('clangd')
      end,
    })
  end,
}
