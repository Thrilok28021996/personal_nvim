return {
  -- Core markdown support
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    ft = { 'markdown', 'Avante' },
    config = function()
      require('render-markdown').setup {
        heading = {
          enabled = true,
          sign = true,
          icons = { '◉ ', '○ ', '✸ ', '✿ ', '✦ ', '✧ ' },
        },
        code = {
          enabled = true,
          sign = false,
          style = 'full',
          position = 'left',
          language_pad = 0,
          disable_background = { 'diff' },
        },
        dash = {
          enabled = true,
          icon = '─',
          width = 'full',
        },
        bullet = {
          enabled = true,
          icons = { '●', '○', '◆', '◇' },
        },
        checkbox = {
          enabled = true,
          unchecked = {
            icon = '󰄱 ',
            highlight = 'RenderMarkdownUnchecked',
          },
          checked = {
            icon = '󰱒 ',
            highlight = 'RenderMarkdownChecked',
          },
        },
        quote = {
          enabled = true,
          icon = '▋',
          repeat_linebreak = false,
        },
        pipe_table = {
          enabled = true,
          preset = 'none',
          style = 'full',
        },
        callout = {
          note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
          tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
          important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
          warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
          caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
        },
        link = {
          enabled = true,
          image = '󰥶 ',
          hyperlink = '󰌹 ',
          highlight = 'RenderMarkdownLink',
        },
      }
    end,
  },

  -- Obsidian-like functionality
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('obsidian').setup {
        workspaces = {
          {
            name = 'personal',
            path = '/Users/thrilok/Documents/obsidian',
          },
          {
            name = 'work',
            path = '/Users/thrilok/Documents/obsidian-work',
          },
        },

        -- Daily notes configuration
        daily_notes = {
          folder = 'daily',
          date_format = '%Y-%m-%d',
          alias_format = '%B %-d, %Y',
          template = 'daily-note.md',
        },

        -- Note completion
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },

        -- Note templates
        templates = {
          subdir = 'templates',
          date_format = '%Y-%m-%d',
          time_format = '%H:%M',
          tags = '',
        },

        -- Note naming and ID generation
        note_id_func = function(title)
          local suffix = ''
          if title ~= nil then
            suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
          else
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end
          return tostring(os.time()) .. '-' .. suffix
        end,

        -- Note frontmatter
        note_frontmatter_func = function(note)
          local out = {
            id = note.id,
            aliases = note.aliases,
            tags = note.tags,
            created = os.date '%Y-%m-%d %H:%M:%S',
            modified = os.date '%Y-%m-%d %H:%M:%S',
          }

          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
          end

          return out
        end,

        -- Wiki links
        wiki_link_func = function(opts)
          if opts.id == nil then
            return string.format('[[%s]]', opts.label)
          elseif opts.label ~= opts.id then
            return string.format('[[%s|%s]]', opts.id, opts.label)
          else
            return string.format('[[%s]]', opts.id)
          end
        end,

        -- Markdown links
        markdown_link_func = function(opts)
          return string.format('[%s](%s)', opts.label, opts.path)
        end,

        -- Follow URL behavior
        follow_url_func = function(url)
          vim.fn.jobstart { 'open', url }
        end,

        -- Use advanced URI encoding
        use_advanced_uri = true,

        -- Finder settings
        finder = 'fzf-lua',
        finder_mappings = {
          new = '<C-x>',
          insert_link = '<C-l>',
        },

        -- Sorting for tags/references
        sort_by = 'modified',
        sort_reversed = true,

        -- Search settings
        search_max_lines = 1000,

        -- Open files in new tab
        open_notes_in = 'current',

        -- UI settings
        ui = {
          enable = true,
          update_debounce = 200,
          checkboxes = {
            [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
            ['x'] = { char = '󰱒', hl_group = 'ObsidianDone' },
            ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
            ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
          },
          bullets = { char = '•', hl_group = 'ObsidianBullet' },
          external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
          reference_text = { hl_group = 'ObsidianRefText' },
          highlight_text = { hl_group = 'ObsidianHighlightText' },
          tags = { hl_group = 'ObsidianTag' },
          hl_groups = {
            ObsidianTodo = { bold = true, fg = '#f78c6c' },
            ObsidianDone = { bold = true, fg = '#89ddff' },
            ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
            ObsidianTilde = { bold = true, fg = '#ff5370' },
            ObsidianBullet = { bold = true, fg = '#89ddff' },
            ObsidianRefText = { underline = true, fg = '#c792ea' },
            ObsidianExtLinkIcon = { fg = '#c792ea' },
            ObsidianTag = { italic = true, fg = '#89ddff' },
            ObsidianHighlightText = { bg = '#75662e' },
          },
        },

        -- Attachments
        attachments = {
          img_folder = 'assets/imgs',
          img_text_func = function(client, path)
            local link_path
            local vault_relative_path = client:vault_relative_path(path)
            if vault_relative_path ~= nil then
              link_path = vault_relative_path
            else
              link_path = tostring(path)
            end
            local display_name = vim.fs.basename(link_path)
            return string.format('![%s](%s)', display_name, link_path)
          end,
        },
      }
    end,
  },

  -- Markdown preview
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && npm install',
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ''
      vim.g.mkdp_browser = ''
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ''
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {},
      }
      vim.g.mkdp_markdown_css = ''
      vim.g.mkdp_highlight_css = ''
      vim.g.mkdp_port = ''
      vim.g.mkdp_page_title = '「${name}」'
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.g.mkdp_theme = 'dark'
    end,
  },

  -- Table mode for easy table creation
  {
    'dhruvasagar/vim-table-mode',
    ft = { 'markdown' },
    config = function()
      vim.g.table_mode_corner = '|'
      vim.g.table_mode_corner_corner = '|'
      vim.g.table_mode_header_fillchar = '-'
    end,
  },

  -- Paste images into markdown
  {
    'HakonHarnes/img-clip.nvim',
    event = 'VeryLazy',
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = true,
        drag_and_drop = {
          insert_mode = true,
        },
        use_absolute_path = false,
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = '![$CURSOR]($FILE_PATH)',
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
  },
}

