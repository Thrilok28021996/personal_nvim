return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'windwp/nvim-ts-autotag',
  },
  opts = {
    -- Essential parsers only (optimized for faster startup and actual usage)
    ensure_installed = {
      -- Core Neovim languages
      'lua',
      'vim',
      'vimdoc',
      'query',

      -- Note-taking and documentation
      'markdown',
      'markdown_inline',

      -- Programming languages (based on LSP configuration)
      'python',
      'javascript',
      'typescript',
      'html',
      'css',
      'json',
      'yaml',
      'bash',
      'dockerfile',

      -- Essential system files
      'git_config',
      'gitcommit',
      'gitignore',
      'diff',
      'regex',

      -- Common config formats
      'toml',
      'ini',
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Disable auto install for faster startup (manually install as needed)
    auto_install = false,

    -- List of parsers to ignore installing (or "all")
    ignore_install = {},

    -- Highlighting configuration
    highlight = {
      enable = true,
      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      disable = function(lang, buf)
        -- Disable in very large files
        local max_filesize = 100 * 1024 -- 100 KB
        local filename = vim.api.nvim_buf_get_name(buf)
        if filename == '' then
          return false
        end

        local fs_stat = vim.loop and vim.loop.fs_stat or (vim.uv and vim.uv.fs_stat)
        if not fs_stat then
          return false
        end

        local ok, stats = pcall(fs_stat, filename)
        if ok and stats and stats.size > max_filesize then
          return true
        end

        -- Disable for specific languages in large files
        if lang == 'latex' then
          local max_latex_filesize = 50 * 1024 -- 50 KB for LaTeX
          if ok and stats and stats.size > max_latex_filesize then
            return true
          end
        end

        return false
      end,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = { 'markdown' },
    },

    -- Indentation configuration
    indent = {
      enable = true,
      -- Disable indentation for specific languages
      disable = { 'python', 'yaml' },
    },

    -- Incremental selection configuration
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = '<C-g>',
        node_decremental = '<C-backspace>',
      },
    },

    -- Text objects configuration
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
          ['ai'] = '@conditional.outer',
          ['ii'] = '@conditional.inner',
          ['ak'] = '@comment.outer',
          ['ik'] = '@comment.inner',
          ['as'] = '@statement.outer',
          ['is'] = '@statement.inner',
          ['ad'] = '@call.outer',
          ['id'] = '@call.inner',
          ['ar'] = '@assignment.outer',
          ['ir'] = '@assignment.inner',
        },
        -- You can choose the select mode (default is charwise 'v')
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap` and `ip`.
        include_surrounding_whitespace = false,
      },

      -- Move to next/previous function, class, etc.
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']f'] = '@function.outer',
          [']c'] = '@class.outer',
          [']a'] = '@parameter.inner',
          [']b'] = '@block.outer',
          [']l'] = '@loop.outer',
          [']i'] = '@conditional.outer',
          [']d'] = '@call.outer',
        },
        goto_next_end = {
          [']F'] = '@function.outer',
          [']C'] = '@class.outer',
          [']A'] = '@parameter.inner',
          [']B'] = '@block.outer',
          [']L'] = '@loop.outer',
          [']I'] = '@conditional.outer',
          [']D'] = '@call.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[c'] = '@class.outer',
          ['[a'] = '@parameter.inner',
          ['[b'] = '@block.outer',
          ['[l'] = '@loop.outer',
          ['[i'] = '@conditional.outer',
          ['[d'] = '@call.outer',
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
          ['[C'] = '@class.outer',
          ['[A'] = '@parameter.inner',
          ['[B'] = '@block.outer',
          ['[L'] = '@loop.outer',
          ['[I'] = '@conditional.outer',
          ['[D'] = '@call.outer',
        },
      },

      -- Swap parameters, functions, etc.
      swap = {
        enable = true,
        swap_next = {
          ['<leader>tsn'] = '@parameter.inner',
          ['<leader>tsf'] = '@function.outer',
        },
        swap_previous = {
          ['<leader>tsp'] = '@parameter.inner',
          ['<leader>tsF'] = '@function.outer',
        },
      },

      -- LSP interop for textobjects
      lsp_interop = {
        enable = true,
        border = 'rounded',
        floating_preview_opts = {},
        peek_definition_code = {
          ['<leader>pf'] = '@function.outer',
          ['<leader>pc'] = '@class.outer',
        },
      },
    },

    -- Folding configuration
    fold = {
      enable = true,
      disable = {},
    },

    -- Playground configuration (if you want to debug treesitter)
    playground = {
      enable = false,
      disable = {},
      updatetime = 25,
      persist_queries = false,
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    },

    -- Autopairs integration
    autopairs = {
      enable = true,
    },

    -- NOTE: Autotag configuration moved to separate setup below to avoid deprecation warning

    -- Note: Rainbow parentheses, matchup, context_commentstring, and refactor
    -- configurations removed as they require additional plugins not in dependencies
  },

  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    -- Configure treesitter context
    require('treesitter-context').setup {
      enable = true,
      max_lines = 3,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 1,
      trim_scope = 'outer',
      mode = 'cursor',
      separator = '▔',
      zindex = 20,
      on_attach = nil,
    }

    -- Configure autotag (separate setup to avoid deprecation warning)
    require('nvim-ts-autotag').setup {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
      per_filetype = {
        ['html'] = {
          enable_close = true,
        },
        ['javascript'] = {
          enable_close = true,
        },
        ['typescript'] = {
          enable_close = true,
        },
        ['javascriptreact'] = {
          enable_close = true,
        },
        ['typescriptreact'] = {
          enable_close = true,
        },
        ['svelte'] = {
          enable_close = true,
        },
        ['vue'] = {
          enable_close = true,
        },
        ['tsx'] = {
          enable_close = true,
        },
        ['jsx'] = {
          enable_close = true,
        },
        ['rescript'] = {
          enable_close = true,
        },
        ['xml'] = {
          enable_close = true,
        },
        ['php'] = {
          enable_close = true,
        },
        ['markdown'] = {
          enable_close = true,
        },
        ['astro'] = {
          enable_close = true,
        },
        ['glimmer'] = {
          enable_close = true,
        },
        ['handlebars'] = {
          enable_close = true,
        },
        ['hbs'] = {
          enable_close = true,
        },
        ['eruby'] = {
          enable_close = true,
        },
        ['htmldjango'] = {
          enable_close = true,
        },
      },
    }

    -- Note: Treesitter keymaps are defined in core/keymaps.lua

    -- Set up folding with treesitter
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt.foldenable = false -- Start with folds open

    -- Configure commentstring for different filetypes
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
      callback = function()
        vim.bo.commentstring = '// %s'
      end,
    })

    -- Note: Markdown-specific settings are handled by rendering-markdown.lua
  end,
}
