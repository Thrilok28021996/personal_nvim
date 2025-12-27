return {
  'lukas-reineke/headlines.nvim',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  ft = 'markdown',
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
        quote_highlight = 'Quote',
      },
    }

    -- Define custom highlights
    vim.cmd [[
      highlight Headline1 guibg=#1e2718 guifg=#a6e3a1
      highlight Headline2 guibg=#1a2a32 guifg=#89dceb
      highlight Headline3 guibg=#2b1e33 guifg=#cba6f7
      highlight Headline4 guibg=#2e2419 guifg=#fab387
      highlight Headline5 guibg=#2b2424 guifg=#f38ba8
      highlight Headline6 guibg=#1e2326 guifg=#94e2d5
      highlight CodeBlock guibg=#1c1c1c
      highlight Dash guibg=#1c1c1c guifg=#585b70
      highlight Quote guifg=#94e2d5 gui=italic
    ]]
  end,
}
