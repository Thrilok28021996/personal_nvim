return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
  opts = {
    -- =========================================================================
    -- Adapters
    -- =========================================================================
    adapters = {
      lmstudio = function()
        return require('codecompanion.adapters').extend('openai_compatible', {
          env = {
            url     = 'http://localhost:1234',
            api_key = 'lm-studio',
          },
          schema = {
            model       = { default = 'qwen/qwen3.5-9b' },
            temperature = { default = 0 },
            max_tokens  = { default = 4096 },
          },
        })
      end,
    },

    -- =========================================================================
    -- Strategies (aliased to interactions internally in v19+)
    -- =========================================================================
    strategies = {
      chat   = { adapter = 'lmstudio' },
      inline = { adapter = 'lmstudio' },
      agent  = { adapter = 'lmstudio' },
    },

    -- =========================================================================
    -- Display
    -- =========================================================================
    display = {
      action_palette = {
        provider = 'fzf_lua',
        opts = {
          show_default_actions         = true,
          show_default_prompt_library  = true,
        },
      },
      chat = {
        window = {
          layout   = 'vertical',
          width    = 0.35,
          position = 'right',
          border   = 'rounded',
        },
        show_token_count     = true,
        show_settings        = false,
        render_headers       = true,
        start_in_insert_mode = false,
        fold_context         = true,
        auto_scroll          = true,
      },
      diff = {
        enabled  = true,
        layout   = 'vertical',
        provider = 'default',
      },
    },

    -- =========================================================================
    -- Prompt library
    -- BufferContext fields available in content(ctx):
    --   ctx.bufnr, ctx.filetype, ctx.filename, ctx.mode, ctx.is_visual
    --   ctx.lines       — all buffer lines (1-indexed table)
    --   ctx.start_line  — first selected line (1-based)
    --   ctx.end_line    — last  selected line (1-based)
    -- There is NO ctx.code field — slice ctx.lines manually.
    -- =========================================================================
    prompt_library = {

      ['Explain Code'] = {
        strategy    = 'chat',
        description = 'Explain how the selected code works',
        opts        = { modes = { 'v' }, auto_submit = true, short_name = 'explain' },
        prompts = {
          {
            role    = 'user',
            content = function(ctx)
              local lines = vim.list_slice(ctx.lines, ctx.start_line, ctx.end_line)
              return string.format(
                'Explain this %s code step by step:\n\n```%s\n%s\n```',
                ctx.filetype, ctx.filetype, table.concat(lines, '\n')
              )
            end,
          },
        },
      },

      ['Fix Code'] = {
        strategy    = 'chat',
        description = 'Find and fix bugs in the selected code',
        opts        = { modes = { 'v' }, auto_submit = true, short_name = 'fix' },
        prompts = {
          {
            role    = 'user',
            content = function(ctx)
              local lines = vim.list_slice(ctx.lines, ctx.start_line, ctx.end_line)
              return string.format(
                'Find and fix any bugs in this %s code. Show the corrected version:\n\n```%s\n%s\n```',
                ctx.filetype, ctx.filetype, table.concat(lines, '\n')
              )
            end,
          },
        },
      },

      ['Generate Tests'] = {
        strategy    = 'chat',
        description = 'Write unit tests for the selected code',
        opts        = { modes = { 'v' }, auto_submit = true, short_name = 'tests' },
        prompts = {
          {
            role    = 'user',
            content = function(ctx)
              local lines = vim.list_slice(ctx.lines, ctx.start_line, ctx.end_line)
              return string.format(
                'Write comprehensive unit tests for this %s code:\n\n```%s\n%s\n```',
                ctx.filetype, ctx.filetype, table.concat(lines, '\n')
              )
            end,
          },
        },
      },

      ['Code Review'] = {
        strategy    = 'chat',
        description = 'Review code for issues, style, and improvements',
        opts        = { modes = { 'v' }, auto_submit = true, short_name = 'review' },
        prompts = {
          {
            role    = 'user',
            content = function(ctx)
              local lines = vim.list_slice(ctx.lines, ctx.start_line, ctx.end_line)
              return string.format(
                'Review this %s code. Focus on: correctness, performance, readability, edge cases:\n\n```%s\n%s\n```',
                ctx.filetype, ctx.filetype, table.concat(lines, '\n')
              )
            end,
          },
        },
      },

      ['Add Docstring'] = {
        strategy    = 'inline',
        description = 'Add a docstring to the selected function',
        opts        = { modes = { 'v' }, auto_submit = true, short_name = 'doc' },
        prompts = {
          {
            role    = 'user',
            content = function(ctx)
              local lines = vim.list_slice(ctx.lines, ctx.start_line, ctx.end_line)
              return string.format(
                'Add a %s docstring to this function. Return only the code with the docstring added:\n\n```%s\n%s\n```',
                ctx.filetype, ctx.filetype, table.concat(lines, '\n')
              )
            end,
          },
        },
      },

      ['Git Commit'] = {
        strategy    = 'chat',
        description = 'Generate a git commit message for staged changes',
        opts        = { auto_submit = true, short_name = 'commit' },
        prompts = {
          {
            role    = 'user',
            content = function()
              local diff = vim.fn.system 'git diff --cached'
              if diff == '' then
                return 'No staged changes found. Stage files with `git add` first.'
              end
              return 'Write a concise conventional commit message for these staged changes:\n\n```diff\n' .. diff .. '\n```'
            end,
          },
        },
      },

      ['Explain LSP Error'] = {
        strategy    = 'chat',
        description = 'Explain the LSP diagnostic under cursor',
        opts        = { auto_submit = true, short_name = 'lsp' },
        prompts = {
          {
            role    = 'user',
            content = function(ctx)
              local diag = vim.diagnostic.get(ctx.bufnr, { lnum = vim.fn.line('.') - 1 })
              if #diag == 0 then return 'No diagnostics on current line.' end
              local msgs = vim.tbl_map(function(d) return d.message end, diag)
              return string.format(
                'Explain this %s error and how to fix it:\n\n%s\n\nContext:\n```%s\n%s\n```',
                ctx.filetype, table.concat(msgs, '\n'),
                ctx.filetype, vim.api.nvim_get_current_line()
              )
            end,
          },
        },
      },

    },

    -- =========================================================================
    -- Global options
    -- =========================================================================
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
  },
}
