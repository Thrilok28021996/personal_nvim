return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim', -- JSON/YAML schemas
  },
  opts = {
    servers = {
      -- Python LSP
      pyright = {
        on_attach = function(client, bufnr)
          -- Use centralized LSP keymaps function if available
          if _G.setup_lsp_keymaps then
            _G.setup_lsp_keymaps(bufnr)
          else
            -- Fallback keymaps
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, bufopts)
          end

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

      -- Lua LSP
      lua_ls = {
        on_attach = function(client, bufnr)
          if _G.setup_lsp_keymaps then
            _G.setup_lsp_keymaps(bufnr)
          end
        end,
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
      },

      -- TypeScript/JavaScript LSP
      ts_ls = {
        on_attach = function(client, bufnr)
          if _G.setup_lsp_keymaps then
            _G.setup_lsp_keymaps(bufnr)
          end
        end,
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
      },

      -- JSON LSP
      jsonls = {
        on_attach = function(client, bufnr)
          if _G.setup_lsp_keymaps then
            _G.setup_lsp_keymaps(bufnr)
          end
        end,
        settings = {
          json = {
            schemas = pcall(require, 'schemastore') and require('schemastore').json.schemas() or {},
            validate = { enable = true },
          },
        },
      },

      -- YAML LSP
      yamlls = {
        on_attach = function(client, bufnr)
          if _G.setup_lsp_keymaps then
            _G.setup_lsp_keymaps(bufnr)
          end
        end,
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = '',
            },
            schemas = pcall(require, 'schemastore') and require('schemastore').yaml.schemas() or {},
          },
        },
      },

      -- HTML LSP
      html = {
        on_attach = function(client, bufnr)
          if _G.setup_lsp_keymaps then
            _G.setup_lsp_keymaps(bufnr)
          end
        end,
      },

      -- CSS LSP
      cssls = {
        on_attach = function(client, bufnr)
          if _G.setup_lsp_keymaps then
            _G.setup_lsp_keymaps(bufnr)
          end
        end,
      },

      -- Bash LSP
      bashls = {
        on_attach = function(client, bufnr)
          if _G.setup_lsp_keymaps then
            _G.setup_lsp_keymaps(bufnr)
          end
        end,
      },

      -- Dockerfile LSP
      dockerls = {
        on_attach = function(client, bufnr)
          if _G.setup_lsp_keymaps then
            _G.setup_lsp_keymaps(bufnr)
          end
        end,
      },
    },
    -- Global LSP client capabilities tweaks
    capabilities = {
      textDocument = {
        foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
      },
    },
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for name, cfg in pairs(opts.servers) do
      -- Merge blink.cmp capabilities into both your base and server-specific caps
      cfg.capabilities = require('blink.cmp').get_lsp_capabilities(
        vim.tbl_deep_extend('force', opts.capabilities or {}, cfg.capabilities or {}),
        false -- pass `false` if you don't want blink.cmp to auto-enable snippetSupport
      )
      lspconfig[name].setup(cfg)
    end
  end,
}
