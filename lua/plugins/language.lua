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

    -- Set up autocommand for formatting on save
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == 'pyright' then
          -- Enable autoformat on save using conform
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              require('conform').format { async = false }
            end,
          })
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
  end,
}
