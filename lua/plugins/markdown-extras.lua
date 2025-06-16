return {
  -- Enhanced markdown syntax highlighting and concealing
  {
    'lukas-reineke/headlines.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    ft = { 'markdown', 'org' },
    config = function()
      require('headlines').setup {
        markdown = {
          headline_highlights = {
            'Headline1',
            'Headline2',
            'Headline3',
            'Headline4',
            'Headline5',
            'Headline6',
          },
          codeblock_highlight = 'CodeBlock',
          dash_highlight = 'Dash',
          dash_string = '-',
          quote_highlight = 'Quote',
          quote_string = '┃',
          fat_headlines = true,
          fat_headline_upper_string = '▃',
          fat_headline_lower_string = '🬂',
        },
      }
    end,
  },

  -- Markdown link navigation and management
  {
    'jakewvincent/mkdnflow.nvim',
    ft = 'markdown',
    config = function()
      require('mkdnflow').setup({
        modules = {
          bib = true,
          buffers = true,
          conceal = true,
          cursor = true,
          folds = true,
          links = true,
          lists = true,
          maps = true,
          paths = true,
          tables = true,
          yaml = false
        },
        filetypes = {md = true, rmd = true, markdown = true},
        create_dirs = true,
        perspective = {
          priority = 'first',
          fallback = 'current',
          root_tell = false,
          nvim_wd_heel = false,
          update = false
        },
        wrap = false,
        bib = {
          default_path = nil,
          find_in_root = true
        },
        silent = false,
        links = {
          style = 'markdown',
          name_is_source = false,
          conceal = false,
          context = 0,
          implicit_extension = nil,
          transform_implicit = false,
          transform_explicit = function(text)
            text = text:gsub(" ", "-")
            text = text:lower()
            text = os.date('%Y-%m-%d_')..text
            return(text)
          end
        },
        new_file_location = {
          'current_dir',
          'same_dir'
        },
        to_do = {
          symbols = {' ', '-', 'X'},
          update_parents = true,
          not_started = ' ',
          in_progress = '-',
          complete = 'X'
        },
        tables = {
          trim_whitespace = true,
          format_on_move = true,
          auto_extend_rows = false,
          auto_extend_cols = false,
          style = {
            cell_padding = 1,
            separator_padding = 1,
            outer_pipes = true,
            mimic_alignment = true
          }
        },
        yaml = {
          bib = { override = false }
        },
        mappings = {
          MkdnEnter = {{'n', 'v'}, '<CR>'},
          MkdnTab = false,
          MkdnSTab = false,
          MkdnNextLink = {'n', '<Tab>'},
          MkdnPrevLink = {'n', '<S-Tab>'},
          MkdnNextHeading = {'n', ']]'},
          MkdnPrevHeading = {'n', '[['},
          MkdnGoBack = {'n', '<BS>'},
          MkdnGoForward = {'n', '<Del>'},
          MkdnCreateLink = false,
          MkdnCreateLinkFromClipboard = {{'n', 'v'}, '<leader>ml'},
          MkdnFollowLink = false,
          MkdnDestroyLink = {'n', '<M-CR>'},
          MkdnTagSpan = {'v', '<M-CR>'},
          MkdnMoveSource = {'n', '<F2>'},
          MkdnYankAnchorLink = {'n', 'yaa'},
          MkdnYankFileAnchorLink = {'n', 'yfa'},
          MkdnIncreaseHeading = {'n', '+'},
          MkdnDecreaseHeading = {'n', '-'},
          MkdnToggleToDo = {{'n', 'v'}, '<C-Space>'},
          MkdnNewListItem = false,
          MkdnNewListItemBelowInsert = {'n', 'o'},
          MkdnNewListItemAboveInsert = {'n', 'O'},
          MkdnExtendList = false,
          MkdnUpdateNumbering = {'n', '<leader>nn'},
          MkdnTableNextCell = {'i', '<Tab>'},
          MkdnTablePrevCell = {'i', '<S-Tab>'},
          MkdnTableNextRow = false,
          MkdnTablePrevRow = {'i', '<M-CR>'},
          MkdnTableNewRowBelow = {'n', '<leader>ir'},
          MkdnTableNewRowAbove = {'n', '<leader>iR'},
          MkdnTableNewColAfter = {'n', '<leader>ic'},
          MkdnTableNewColBefore = {'n', '<leader>iC'},
          MkdnFoldSection = {'n', '<leader>f'},
          MkdnUnfoldSection = {'n', '<leader>F'}
        }
      })
    end
  },

  -- Zen mode for distraction-free writing
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    keys = {
      { '<leader>z', '<cmd>ZenMode<cr>', desc = 'Toggle Zen Mode' },
    },
    config = function()
      require('zen-mode').setup {
        window = {
          backdrop = 0.95,
          width = 0.85,
          height = 0.9,
          options = {
            signcolumn = 'no',
            number = false,
            relativenumber = false,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = '0',
            list = false,
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false,
            showcmd = false,
            laststatus = 0,
          },
          twilight = { enabled = true },
          gitsigns = { enabled = false },
          tmux = { enabled = false },
          kitty = {
            enabled = false,
            font = '+4',
          },
        },
      }
    end,
  },

  -- Twilight for better focus
  {
    'folke/twilight.nvim',
    cmd = { 'Twilight', 'TwilightEnable', 'TwilightDisable' },
    config = function()
      require('twilight').setup {
        dimming = {
          alpha = 0.25,
          color = { 'Normal', '#ffffff' },
          term_bg = '#000000',
          inactive = false,
        },
        context = 10,
        treesitter = true,
        expand = {
          'function',
          'method',
          'table',
          'if_statement',
        },
        exclude = {},
      }
    end,
  },

  -- Markdown checklist management
  {
    'nfrid/markdown-togglecheck',
    dependencies = { 'nfrid/treesitter-utils' },
    ft = { 'markdown' },
    config = function()
      require('markdown-togglecheck').setup({
        create_user_command = true,
      })
    end,
  },
}