return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ft = 'markdown',
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  config = function()
    require('render-markdown').setup {
      -- Enable rendering in both normal and insert modes
      render_modes = { 'n', 'c' },

      -- Heading icons
      heading = {
        enabled = true,
        sign = true,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        backgrounds = {
          'RenderMarkdownH1Bg',
          'RenderMarkdownH2Bg',
          'RenderMarkdownH3Bg',
          'RenderMarkdownH4Bg',
          'RenderMarkdownH5Bg',
          'RenderMarkdownH6Bg',
        },
      },

      -- Code block rendering
      code = {
        enabled = true,
        sign = true,
        style = 'full',
        left_pad = 2,
        right_pad = 2,
        width = 'block',
        border = 'thin',
        highlight = 'RenderMarkdownCode',
      },

      -- Bullet points
      bullet = {
        enabled = true,
        icons = { '●', '○', '◆', '◇' },
        highlight = 'RenderMarkdownBullet',
      },

      -- Checkboxes
      checkbox = {
        enabled = true,
        unchecked = { icon = '󰄱 ' },
        checked = { icon = '󰱒 ' },
      },

      -- Quote blocks
      quote = {
        enabled = true,
        icon = '▋',
        highlight = 'RenderMarkdownQuote',
      },

      -- Tables
      pipe_table = {
        enabled = true,
        style = 'full',
        cell = 'padded',
      },

      -- Links
      link = {
        enabled = true,
        image = '󰥶 ',
        hyperlink = '󰌹 ',
      },

      -- Inline code
      inline_code = {
        enabled = true,
        highlight = 'RenderMarkdownCode',
      },

      -- Disable latex support (not needed, removes warnings)
      latex = { enabled = false },
    }
  end,
}
