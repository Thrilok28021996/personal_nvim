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
return {
  'neovim/nvim-lspconfig',
  config = function()
    require('lspconfig').pyright.setup {
      on_attach = function(client, bufnr)
        -- Enable autoformat on save using conform
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          callback = function()
            require('conform').format { async = false }
          end,
        })
      end,
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
  end,
}
