return {
  -- Core markdown support
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
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
          custom = {
            todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
            progress = { raw = '[>]', rendered = ' ', highlight = 'RenderMarkdownProgress' },
            cancelled = { raw = '[~]', rendered = '󰰱 ', highlight = 'RenderMarkdownCancelled' },
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

  -- Custom highlight groups for markdown elements
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = function(_, opts)
      -- Set up custom highlight groups for markdown
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('MarkdownHighlights', { clear = true }),
        callback = function()
          vim.api.nvim_set_hl(0, 'RenderMarkdownTodo', { bold = true, fg = '#f78c6c' })
          vim.api.nvim_set_hl(0, 'RenderMarkdownProgress', { bold = true, fg = '#f78c6c' })
          vim.api.nvim_set_hl(0, 'RenderMarkdownCancelled', { bold = true, fg = '#ff5370' })
        end,
      })
      -- Trigger the highlight setup
      vim.cmd('doautocmd ColorScheme')
    end,
  },

  -- Markdown preview
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function(plugin)
      vim.fn.system('cd ' .. plugin.dir .. '/app && npm install')
    end,
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

