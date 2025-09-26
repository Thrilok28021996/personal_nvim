return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },
  -- Define all your servers here
  opts = {
    servers = {
      pyright = {
        on_attach = function(client, bufnr)
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          -- navigation
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
          -- docs & sig help
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, bufopts)
          -- autoformat on save
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
              typeCheckingMode = 'basic',
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'openFilesOnly',
            },
          },
        },
      },
      lua_ls = {}, -- you can add more servers here
      -- ... any other server you need
    },
    -- global LSP client capabilities tweaks
    capabilities = {
      textDocument = {
        foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
      },
    },
  },
  -- the setup function that Lazy.nvim will call
  config = function(_, opts)
    local lspconfig = require 'lspconfig'
    for name, cfg in pairs(opts.servers) do
      -- merge blink.cmp capabilities into both your base and server‑specific caps
      cfg.capabilities = require('blink.cmp').get_lsp_capabilities(
        vim.tbl_deep_extend('force', opts.capabilities or {}, cfg.capabilities or {}),
        false -- pass `false` if you don't want blink.cmp to auto‑enable snippetSupport
      )
      lspconfig[name].setup(cfg)
    end
  end,
}
