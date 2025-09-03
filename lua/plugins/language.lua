return {
  'neovim/nvim-lspconfig',
<<<<<<< HEAD
  dependencies = {
    -- LSP enhancement plugins
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim', -- JSON/YAML schemas
  },
  config = function()
    local lspconfig = require('lspconfig')
    
    -- Get LSP capabilities for blink.cmp
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    
    -- Common LSP on_attach function
    local function on_attach(client, bufnr)
      -- Use centralized LSP keymaps function
      _G.setup_lsp_keymaps(bufnr)

      -- Enable autoformat on save using conform
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
          local ok, conform = pcall(require, 'conform')
          if ok then
            conform.format { async = false }
          end
        end,
      })
    end

    -- Python LSP
    lspconfig.pyright.setup {
      on_attach = on_attach,
      capabilities = capabilities,
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
    }

    -- Lua LSP
    lspconfig.lua_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }

    -- TypeScript/JavaScript LSP
    lspconfig.ts_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    }

    -- JSON LSP
    lspconfig.jsonls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    }

    -- YAML LSP
    lspconfig.yamlls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        yaml = {
          schemaStore = {
            enable = false,
            url = '',
          },
          schemas = require('schemastore').yaml.schemas(),
        },
      },
    }

    -- HTML LSP
    lspconfig.html.setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    -- CSS LSP
    lspconfig.cssls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    -- Bash LSP
    lspconfig.bashls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    -- Dockerfile LSP
    lspconfig.dockerls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
=======
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
>>>>>>> refs/remotes/origin/main
  end,
}
