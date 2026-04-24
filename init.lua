require 'core.options'
require 'core.keymaps'
require 'core.macros'
require 'plugins.misc'
require 'plugins.language'

-- ============================================================================
-- Plugin Manager: vim.pack (built-in, Neovim 0.12+)
-- ============================================================================

vim.pack.add {
  -- ── Always loaded ──────────────────────────────────────────────────────────
  {
    name = 'catppuccin',
    src  = 'https://github.com/catppuccin/nvim',
    load = function(plug)
      vim.cmd('packadd ' .. plug.name)
      require('catppuccin').setup {
        integrations = {
          treesitter      = true,
          gitsigns        = true,
          fzf             = true,
          render_markdown = true,
          dap             = true,
          dap_ui          = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin-mocha'

      local function set_highlights()
        vim.api.nvim_set_hl(0, 'PmenuBorder',          { link = 'FloatBorder' })
        vim.api.nvim_set_hl(0, 'PmenuShadow',          { link = 'FloatShadow' })
        vim.api.nvim_set_hl(0, 'PmenuShadowThrough',   { link = 'FloatShadowThrough' })
        vim.api.nvim_set_hl(0, 'DiffTextAdd',          { link = 'DiffAdd' })
        vim.api.nvim_set_hl(0, 'SnippetTabstopActive', { link = 'Visual' })
        vim.api.nvim_set_hl(0, 'LspReferenceTarget',   { link = 'LspReferenceWrite' })
        vim.api.nvim_set_hl(0, 'OkMsg',                { link = 'DiagnosticOk' })
        vim.api.nvim_set_hl(0, 'StderrMsg',            { link = 'ErrorMsg' })
        vim.api.nvim_set_hl(0, 'StdoutMsg',            { link = 'Normal' })
      end
      set_highlights()
      vim.api.nvim_create_autocmd('ColorScheme', { callback = set_highlights })
    end,
  },

  {
    name = 'oil.nvim',
    src  = 'https://github.com/stevearc/oil.nvim',
    load = function(plug)
      vim.cmd('packadd ' .. plug.name)
      require('oil').setup {
        columns = { 'size' },
        view_options = { show_hidden = true },
        keymaps = {
          ['g?'] = 'actions.show_help',
          ['<CR>'] = 'actions.select',
          ['<C-v>'] = 'actions.select_vsplit',
          ['<C-s>'] = 'actions.select_split',
          ['<C-t>'] = 'actions.select_tab',
          ['<C-p>'] = 'actions.preview',
          ['<C-c>'] = 'actions.close',
          ['<C-l>'] = 'actions.refresh',
          ['-'] = 'actions.parent',
          ['_'] = 'actions.open_cwd',
          ['`'] = 'actions.cd',
          ['~'] = 'actions.tcd',
          ['gs'] = 'actions.change_sort',
          ['gx'] = 'actions.open_external',
          ['g.'] = 'actions.toggle_hidden',
          ['g\\'] = 'actions.toggle_trash',
        },
      }
    end,
  },

  {
    name = 'vim-visual-multi',
    src  = 'https://github.com/mg979/vim-visual-multi',
    load = function(plug)
      vim.g.VM_theme = 'iceblue'
      vim.g.VM_maps = {
        ['Find Under'] = '<C-n>',
        ['Find Subword Under'] = '<C-n>',
      }
      vim.cmd('packadd ' .. plug.name)
    end,
  },

  -- ── Lazy: BufReadPre (open any file) ───────────────────────────────────────
  {
    name = 'gitsigns.nvim',
    src  = 'https://github.com/lewis6991/gitsigns.nvim',
    load = function(plug)
      vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
        once = true,
        callback = function()
          vim.cmd('packadd ' .. plug.name)
          require('gitsigns').setup {
            signs = {
              add          = { text = '+' },
              change       = { text = '~' },
              delete       = { text = '_' },
              topdelete    = { text = '‾' },
              changedelete = { text = '~' },
            },
            signs_staged = {
              add          = { text = '+' },
              change       = { text = '~' },
              delete       = { text = '_' },
              topdelete    = { text = '‾' },
              changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
              if _G.gitsigns_on_attach then _G.gitsigns_on_attach(bufnr) end
            end,
          }
        end,
      })
    end,
  },

  -- nvim-treesitter-textobjects must packadd before treesitter setup
  {
    name = 'nvim-treesitter-textobjects',
    src  = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    load = false,
  },

  {
    name = 'nvim-treesitter',
    src  = 'https://github.com/nvim-treesitter/nvim-treesitter',
    load = function(plug)
      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
        once = true,
        callback = function()
          vim.cmd 'packadd nvim-treesitter-textobjects'
          vim.cmd('packadd ' .. plug.name)
          require('nvim-treesitter').setup {
            ensure_installed = {
              'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query',
              'markdown', 'python', 'bash', 'json', 'yaml', 'toml', 'cmake', 'make',
            },
            auto_install = true,
            highlight = { enable = true },
            textobjects = {
              move = {
                enable = true,
                goto_next_start     = { [']f'] = '@function.outer', [']C'] = '@class.outer', [']a'] = '@parameter.inner', [']l'] = '@loop.outer', [']i'] = '@conditional.outer', [']r'] = '@return.outer', [']x'] = '@call.outer', [']v'] = '@assignment.outer' },
                goto_next_end       = { [']F'] = '@function.outer', [']CC'] = '@class.outer' },
                goto_previous_start = { ['[f'] = '@function.outer', ['[C'] = '@class.outer', ['[a'] = '@parameter.inner', ['[l'] = '@loop.outer', ['[i'] = '@conditional.outer', ['[r'] = '@return.outer', ['[x'] = '@call.outer', ['[v'] = '@assignment.outer' },
                goto_previous_end   = { ['[F'] = '@function.outer', ['[CC'] = '@class.outer' },
              },
              select = {
                enable = true,
                lookahead = true,
                keymaps = {
                  ['af'] = '@function.outer', ['if'] = '@function.inner',
                  ['ac'] = '@class.outer',    ['ic'] = '@class.inner',
                  ['as'] = '@statement.outer', ['is'] = '@statement.outer',
                  ['ai'] = '@conditional.outer', ['ii'] = '@conditional.inner',
                  ['al'] = '@loop.outer',     ['il'] = '@loop.inner',
                  ['aa'] = '@parameter.outer', ['ia'] = '@parameter.inner',
                  ['aC'] = '@comment.outer',  ['iC'] = '@comment.outer',
                  ['ab'] = '@block.outer',    ['ib'] = '@block.inner',
                  ['ar'] = '@return.outer',   ['ir'] = '@return.inner',
                  ['ax'] = '@call.outer',     ['ix'] = '@call.inner',
                  ['a='] = '@assignment.outer', ['i='] = '@assignment.inner',
                  ['l='] = '@assignment.lhs', ['r='] = '@assignment.rhs',
                },
              },
              swap = {
                enable = true,
                swap_next     = { ['<leader>a'] = '@parameter.inner' },
                swap_previous = { ['<leader>A'] = '@parameter.inner' },
              },
            },
          }
        end,
      })
    end,
  },

  -- ── Lazy: BufWritePre + :ConformInfo command ────────────────────────────────
  {
    name = 'conform.nvim',
    src  = 'https://github.com/stevearc/conform.nvim',
    load = function(plug)
      local loaded = false
      local function load()
        if loaded then return end
        loaded = true
        vim.cmd('packadd ' .. plug.name)
        vim.g.disable_autoformat = false
        require('conform').setup {
          formatters_by_ft = {
            markdown   = { 'prettier' },
            lua        = { 'stylua' },
            python     = { 'isort', 'black' },
            c          = { 'clang-format' },
            cpp        = { 'clang-format' },
            javascript = { 'prettier' },
            typescript = { 'prettier' },
            json       = { 'prettier' },
          },
          format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
            return { timeout_ms = 1000, lsp_format = 'fallback' }
          end,
        }
        vim.api.nvim_create_user_command('FormatToggle', function()
          if vim.g.disable_autoformat then
            vim.g.disable_autoformat = false
            vim.notify('Format on save enabled', vim.log.levels.INFO)
          else
            vim.g.disable_autoformat = true
            vim.notify('Format on save disabled', vim.log.levels.WARN)
          end
        end, { desc = 'Toggle format on save' })
      end
      vim.api.nvim_create_autocmd('BufWritePre', { once = true, callback = load })
      vim.api.nvim_create_user_command('ConformInfo', function()
        load()
        vim.cmd 'ConformInfo'
      end, {})
    end,
  },

  -- ── Lazy: FileType markdown ─────────────────────────────────────────────────
  {
    name = 'render-markdown.nvim',
    src  = 'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    load = function(plug)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        once = true,
        callback = function()
          vim.cmd('packadd ' .. plug.name)
          require('render-markdown').setup {
            file_types   = { 'markdown' },
            render_modes = { 'n', 'c' },
            heading  = { enabled = true, sign = true, icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' }, backgrounds = { 'RenderMarkdownH1Bg', 'RenderMarkdownH2Bg', 'RenderMarkdownH3Bg', 'RenderMarkdownH4Bg', 'RenderMarkdownH5Bg', 'RenderMarkdownH6Bg' } },
            code       = { enabled = true, sign = true, style = 'full', left_pad = 2, right_pad = 2, width = 'block', border = 'thin', highlight = 'RenderMarkdownCode' },
            bullet     = { enabled = true, icons = { '●', '○', '◆', '◇' }, highlight = 'RenderMarkdownBullet' },
            checkbox   = { enabled = true, unchecked = { icon = '󰄱 ' }, checked = { icon = '󰱒 ' } },
            quote      = { enabled = true, icon = '▋', highlight = 'RenderMarkdownQuote' },
            pipe_table = { enabled = true, style = 'full', cell = 'padded' },
            link       = { enabled = true, image = '󰥶 ', hyperlink = '󰌹 ' },
            inline_code = { enabled = true, highlight = 'RenderMarkdownCode' },
            latex = { enabled = false },
          }
        end,
      })
    end,
  },

  {
    name = 'mkdnflow.nvim',
    src  = 'https://github.com/jakewvincent/mkdnflow.nvim',
    load = function(plug)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        once = true,
        callback = function()
          vim.cmd('packadd ' .. plug.name)
          require('mkdnflow').setup {
            modules = { bib = true, buffers = true, conceal = true, cursor = true, folds = false, links = true, lists = true, maps = true, paths = true, tables = true, yaml = false },
            create_dirs = true,
            perspective = { priority = 'first', fallback = 'current', root_tell = false, nvim_wd_heel = false, update = false },
            links = { style = 'markdown', name_is_source = false, conceal = false, context = 0, implicit_extension = nil, transform_implicit = false, transform_explicit = function(text) return text:gsub(' ', '-'):lower() end },
            to_do = {
              statuses     = { not_started = { marker = ' ' }, in_progress = { marker = '-' }, complete = { marker = 'X' } },
              status_order = { 'not_started', 'in_progress', 'complete' },
              status_propagation = { up = true, down = false },
            },
            tables = { trim_whitespace = true, format_on_move = true, auto_extend_rows = false, auto_extend_cols = false },
            mappings = {
              MkdnEnter                  = { { 'n', 'v' }, '<CR>' },
              MkdnTab                    = false,
              MkdnSTab                   = false,
              MkdnNextLink               = false,
              MkdnPrevLink               = false,
              MkdnNextHeading            = { 'n', ']]' },
              MkdnPrevHeading            = { 'n', '[[' },
              MkdnGoBack                 = { 'n', '<BS>' },
              MkdnGoForward              = false,
              MkdnCreateLink             = false,
              MkdnCreateLinkFromClipboard = false,
              MkdnFollowLink             = false,
              MkdnDestroyLink            = false,
              MkdnTagSpan                = false,
              MkdnMoveSource             = false,
              MkdnYankAnchorLink         = false,
              MkdnYankFileAnchorLink     = false,
              MkdnIncreaseHeading        = { 'n', '<leader>h+' },
              MkdnDecreaseHeading        = { 'n', '<leader>h-' },
              MkdnToggleToDo             = { { 'n', 'v' }, '<C-Space>' },
              MkdnNewListItem            = false,
              MkdnNewListItemBelowInsert = { 'n', '<M-o>' },
              MkdnNewListItemAboveInsert = { 'n', '<M-O>' },
              MkdnExtendList             = false,
              MkdnUpdateNumbering        = false,
              MkdnTableNextCell          = { 'i', '<M-]>' },
              MkdnTablePrevCell          = { 'i', '<M-[>' },
              MkdnTableNextRow           = false,
              MkdnTablePrevRow           = false,
              MkdnTableNewRowBelow       = false,
              MkdnTableNewRowAbove       = false,
              MkdnTableNewColAfter       = false,
              MkdnTableNewColBefore      = false,
              MkdnFoldSection            = false,
              MkdnUnfoldSection          = false,
            },
          }
        end,
      })
    end,
  },

  -- ── Lazy: :Mason command ────────────────────────────────────────────────────
  {
    name = 'mason.nvim',
    src  = 'https://github.com/williamboman/mason.nvim',
    load = function(plug)
      vim.api.nvim_create_user_command('Mason', function()
        vim.cmd('packadd ' .. plug.name)
        require('mason').setup {
          ui = {
            icons = {
              package_installed   = '✓',
              package_pending     = '➜',
              package_uninstalled = '✗',
            },
          },
        }
        vim.cmd 'Mason'
      end, {})
    end,
  },

  -- ── Lazy: :FzfLua command + LspAttach ───────────────────────────────────────
  {
    name = 'fzf-lua',
    src  = 'https://github.com/ibhagwan/fzf-lua',
    load = function(plug)
      local loaded = false
      local function load()
        if loaded then return end
        loaded = true
        vim.cmd('packadd ' .. plug.name)
        local fzf = require 'fzf-lua'
        fzf.setup {
          'fzf-native',
          fzf_opts = { ['--layout'] = 'reverse' },
          winopts = {
            height = 0.85, width = 0.80, row = 0.35, col = 0.50,
            preview = { layout = 'flex', flip_columns = 120 },
          },
          files = { cmd = 'fd --type f --hidden --exclude .git' },
          grep  = { rg_opts = '--column --line-number --no-heading --color=always --smart-case' },
        }
        fzf.register_ui_select()
      end
      vim.api.nvim_create_user_command('FzfLua', function(opts)
        load()
        require('fzf-lua')[opts.args]()
      end, { nargs = '?' })
      vim.api.nvim_create_autocmd('LspAttach', { once = true, callback = load })
    end,
  },

  -- ── Lazy: InsertEnter (ghost-text completions) ───────────────────────────────
  {
    name = 'minuet-ai.nvim',
    src  = 'https://github.com/milanglacier/minuet-ai.nvim',
    load = function(plug)
      vim.api.nvim_create_autocmd('InsertEnter', {
        once = true,
        callback = function()
          vim.cmd('packadd ' .. plug.name)
          require('minuet').setup {
            provider = 'openai_fim_compatible',
            n_completions = 1,
            context_window = 512,
            throttle = 1200,
            debounce = 400,
            provider_options = {
              openai_fim_compatible = {
                api_key  = 'lm-studio',
                name     = 'LMStudio',
                end_point = 'http://localhost:1234/v1/completions',
                model    = 'qwen2.5-coder',
                optional = { max_tokens = 56, top_p = 0.9 },
              },
            },
            virtualtext = {
              auto_trigger_ft = { '*' },
              auto_trigger_ignore_ft = { 'TelescopePrompt', 'fzf', 'oil', 'mason', 'help', 'markdown' },
              keymap = {
                accept       = '<A-a>',
                accept_line  = '<A-l>',
                accept_n_lines = '<A-n>',
                next         = '<A-]>',
                prev         = '<A-[>',
                dismiss      = '<A-e>',
              },
            },
          }
        end,
      })
    end,
  },

  -- ── Lazy: CodeCompanion commands (+ flat deps) ───────────────────────────────
  {
    name = 'plenary.nvim',
    src  = 'https://github.com/nvim-lua/plenary.nvim',
    load = false,
  },

  {
    name = 'codecompanion.nvim',
    src  = 'https://github.com/olimorris/codecompanion.nvim',
    load = function(plug)
      local loaded = false
      local function load()
        if loaded then return end
        loaded = true
        vim.cmd 'packadd plenary.nvim'
        -- nvim-treesitter already loaded on BufReadPost; packadd is safe to repeat
        vim.cmd 'packadd nvim-treesitter'
        vim.cmd('packadd ' .. plug.name)
        require('codecompanion').setup {
          adapters = {
            lmstudio = function()
              return require('codecompanion.adapters').extend('openai_compatible', {
                env    = { url = 'http://localhost:1234', api_key = 'lm-studio' },
                schema = {
                  model       = { default = 'qwen/qwen3.5-9b' },
                  temperature = { default = 0 },
                  max_tokens  = { default = 4096 },
                },
              })
            end,
          },
          strategies = {
            chat   = { adapter = 'lmstudio' },
            inline = { adapter = 'lmstudio' },
            agent  = { adapter = 'lmstudio' },
          },
          display = {
            action_palette = {
              provider = 'fzf_lua',
              opts = { show_default_actions = true, show_default_prompt_library = true },
            },
            chat = {
              window = { layout = 'vertical', width = 0.35, position = 'right', border = 'rounded' },
              show_token_count = true, show_settings = false, render_headers = true,
              start_in_insert_mode = false, fold_context = true, auto_scroll = true,
            },
            diff = { enabled = true, layout = 'vertical', provider = 'default' },
          },
          prompt_library = {
            ['Explain Code'] = {
              strategy = 'chat', description = 'Explain how the selected code works',
              opts = { modes = { 'v' }, auto_submit = true, short_name = 'explain' },
              prompts = { { role = 'user', content = function(ctx)
                local lines = vim.list_slice(ctx.lines, ctx.start_line, ctx.end_line)
                return string.format('Explain this %s code step by step:\n\n```%s\n%s\n```', ctx.filetype, ctx.filetype, table.concat(lines, '\n'))
              end } },
            },
            ['Fix Code'] = {
              strategy = 'chat', description = 'Find and fix bugs in the selected code',
              opts = { modes = { 'v' }, auto_submit = true, short_name = 'fix' },
              prompts = { { role = 'user', content = function(ctx)
                local lines = vim.list_slice(ctx.lines, ctx.start_line, ctx.end_line)
                return string.format('Find and fix any bugs in this %s code. Show the corrected version:\n\n```%s\n%s\n```', ctx.filetype, ctx.filetype, table.concat(lines, '\n'))
              end } },
            },
            ['Generate Tests'] = {
              strategy = 'chat', description = 'Write unit tests for the selected code',
              opts = { modes = { 'v' }, auto_submit = true, short_name = 'tests' },
              prompts = { { role = 'user', content = function(ctx)
                local lines = vim.list_slice(ctx.lines, ctx.start_line, ctx.end_line)
                return string.format('Write comprehensive unit tests for this %s code:\n\n```%s\n%s\n```', ctx.filetype, ctx.filetype, table.concat(lines, '\n'))
              end } },
            },
            ['Code Review'] = {
              strategy = 'chat', description = 'Review code for issues, style, and improvements',
              opts = { modes = { 'v' }, auto_submit = true, short_name = 'review' },
              prompts = { { role = 'user', content = function(ctx)
                local lines = vim.list_slice(ctx.lines, ctx.start_line, ctx.end_line)
                return string.format('Review this %s code. Focus on: correctness, performance, readability, edge cases:\n\n```%s\n%s\n```', ctx.filetype, ctx.filetype, table.concat(lines, '\n'))
              end } },
            },
            ['Add Docstring'] = {
              strategy = 'inline', description = 'Add a docstring to the selected function',
              opts = { modes = { 'v' }, auto_submit = true, short_name = 'doc' },
              prompts = { { role = 'user', content = function(ctx)
                local lines = vim.list_slice(ctx.lines, ctx.start_line, ctx.end_line)
                return string.format('Add a %s docstring to this function. Return only the code with the docstring added:\n\n```%s\n%s\n```', ctx.filetype, ctx.filetype, table.concat(lines, '\n'))
              end } },
            },
            ['Git Commit'] = {
              strategy = 'chat', description = 'Generate a git commit message for staged changes',
              opts = { auto_submit = true, short_name = 'commit' },
              prompts = { { role = 'user', content = function()
                local diff = vim.fn.system 'git diff --cached'
                if diff == '' then return 'No staged changes found. Stage files with `git add` first.' end
                return 'Write a concise conventional commit message for these staged changes:\n\n```diff\n' .. diff .. '\n```'
              end } },
            },
            ['Explain LSP Error'] = {
              strategy = 'chat', description = 'Explain the LSP diagnostic under cursor',
              opts = { auto_submit = true, short_name = 'lsp' },
              prompts = { { role = 'user', content = function(ctx)
                local diag = vim.diagnostic.get(ctx.bufnr, { lnum = vim.fn.line('.') - 1 })
                if #diag == 0 then return 'No diagnostics on current line.' end
                local msgs = vim.tbl_map(function(d) return d.message end, diag)
                return string.format('Explain this %s error and how to fix it:\n\n%s\n\nContext:\n```%s\n%s\n```', ctx.filetype, table.concat(msgs, '\n'), ctx.filetype, vim.api.nvim_get_current_line())
              end } },
            },
          },
          opts = {
            log_level = 'ERROR',
            send_code = true,
            system_prompt = function(opts)
              return string.format(
                'You are an expert software developer specializing in %s. '
                .. 'Give terse, direct answers. Prefer native solutions over adding dependencies. '
                .. 'Match the existing code style when writing code.',
                opts.language or 'general programming'
              )
            end,
          },
        }
      end
      for _, cmd in ipairs { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' } do
        vim.api.nvim_create_user_command(cmd, function(opts)
          load()
          vim.cmd(cmd .. (opts.args ~= '' and ' ' .. opts.args or ''))
        end, { nargs = '*', range = true })
      end
    end,
  },

  -- ── Lazy: DAP commands ───────────────────────────────────────────────────────
  {
    name = 'nvim-nio',
    src  = 'https://github.com/nvim-neotest/nvim-nio',
    load = false,
  },
  {
    name = 'nvim-dap-ui',
    src  = 'https://github.com/rcarriga/nvim-dap-ui',
    load = false,
  },
  {
    name = 'nvim-dap-virtual-text',
    src  = 'https://github.com/theHamsta/nvim-dap-virtual-text',
    load = false,
  },
  {
    name = 'nvim-dap-python',
    src  = 'https://github.com/mfussenegger/nvim-dap-python',
    load = false,
  },
  {
    name = 'nvim-dap',
    src  = 'https://github.com/mfussenegger/nvim-dap',
    load = function(plug)
      local loaded = false
      local function load()
        if loaded then return end
        loaded = true
        for _, dep in ipairs { 'nvim-nio', 'nvim-dap-ui', 'nvim-dap-virtual-text', 'nvim-dap-python' } do
          vim.cmd('packadd ' .. dep)
        end
        vim.cmd('packadd ' .. plug.name)

        local dap   = require 'dap'
        local dapui = require 'dapui'

        dapui.setup {
          icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
          layouts = {
            { elements = { { id = 'scopes', size = 0.25 }, 'breakpoints', 'stacks', 'watches' }, size = 40, position = 'left' },
            { elements = { 'repl', 'console' }, size = 0.25, position = 'bottom' },
          },
          controls = { icons = { pause = '', play = '', step_into = '', step_over = '', step_out = '', step_back = '', run_last = '↻', terminate = '□' } },
          floating = { border = 'rounded' },
        }

        require('nvim-dap-virtual-text').setup {
          highlight_changed_variables = true,
          virt_text_pos = 'inline',
          display_callback = function(variable, _, _, _, options)
            if options.virt_text_pos == 'inline' then return ' = ' .. variable.value end
            return variable.name .. ' = ' .. variable.value
          end,
        }

        dap.listeners.after.event_initialized['dapui_config']  = function() dapui.open() end
        dap.listeners.before.event_terminated['dapui_config']  = function() dapui.close() end
        dap.listeners.before.event_exited['dapui_config']      = function() dapui.close() end

        require('dap-python').setup 'python3'
        table.insert(dap.configurations.python, {
          type = 'python', request = 'launch', name = 'Launch file with arguments',
          program = '${file}', args = function() return vim.split(vim.fn.input 'Arguments: ', '%s+') end,
          console = 'integratedTerminal', cwd = '${workspaceFolder}',
        })

        dap.adapters['pwa-node'] = {
          type = 'server', host = 'localhost', port = '${port}',
          executable = { command = 'node', args = { vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' } },
        }
        dap.configurations.javascript = {
          { name = 'Launch file', type = 'pwa-node', request = 'launch', program = '${file}', cwd = '${workspaceFolder}', sourceMaps = true, console = 'integratedTerminal' },
          { name = 'Attach to process', type = 'pwa-node', request = 'attach', processId = require('dap.utils').pick_process, cwd = '${workspaceFolder}' },
        }
        dap.configurations.typescript = dap.configurations.javascript

        local codelldb_cmd = vim.fn.exepath 'codelldb' ~= '' and vim.fn.exepath 'codelldb'
          or vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb'
        dap.adapters.codelldb = {
          type = 'server', port = '${port}',
          executable = { command = codelldb_cmd, args = { '--port', '${port}' } },
        }
        dap.configurations.cpp = {
          { name = 'Launch file', type = 'codelldb', request = 'launch', program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end, cwd = '${workspaceFolder}', stopOnEntry = false, args = function() return vim.split(vim.fn.input 'Arguments: ', '%s+') end, runInTerminal = false },
          { name = 'Attach to process', type = 'codelldb', request = 'attach', pid = require('dap.utils').pick_process, args = {} },
        }
        dap.configurations.c = dap.configurations.cpp

        local mason_pkg = vim.fn.stdpath 'data' .. '/mason/packages'
        dap.adapters.bashdb = { type = 'executable', command = mason_pkg .. '/bash-debug-adapter/bash-debug-adapter', name = 'bashdb' }
        dap.configurations.sh = { {
          type = 'bashdb', request = 'launch', name = 'Launch file',
          showDebugOutput = true,
          pathBashdb    = mason_pkg .. '/bash-debug-adapter/extension/bashdb_dir/bashdb',
          pathBashdbLib = mason_pkg .. '/bash-debug-adapter/extension/bashdb_dir',
          trace = true, file = '${file}', program = '${file}', cwd = '${workspaceFolder}',
          pathCat = 'cat', pathBash = '/bin/bash', pathMkfifo = 'mkfifo', pathPkill = 'pkill',
          args = {}, env = {}, terminalKind = 'integrated',
        } }

        vim.fn.sign_define('DapBreakpoint',          { text = '●', texthl = 'DiagnosticError', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DiagnosticWarn',  linehl = '', numhl = '' })
        vim.fn.sign_define('DapLogPoint',            { text = '◉', texthl = 'DiagnosticInfo',  linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped',             { text = '▶', texthl = 'DiagnosticOk',    linehl = 'debugPC', numhl = '' })
        vim.fn.sign_define('DapBreakpointRejected',  { text = '○', texthl = 'DiagnosticHint',  linehl = '', numhl = '' })
      end

      -- Load on any DAP command
      for _, cmd in ipairs { 'DapToggleBreakpoint', 'DapContinue', 'DapStepInto', 'DapStepOver', 'DapStepOut', 'DapTerminate' } do
        vim.api.nvim_create_user_command(cmd, function()
          load()
          vim.cmd(cmd)
        end, {})
      end
    end,
  },
}
