return {
  'catppuccin/nvim',
  lazy = false,
  name = 'catppuccin',
  priority = 1000,
  opts = {
    integrations = {
      treesitter    = true,
      gitsigns      = true,
      fzf           = true,
      render_markdown = true,
      dap           = true,
      dap_ui        = true,
      -- everything else disabled (navic, telescope, blink, nvimtree, etc.)
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin-mocha'

    -- 0.12 new highlight groups — catppuccin doesn't define these yet,
    -- so link them to the nearest catppuccin-defined equivalents.
    local function set_highlights()
      -- Completion popup (matches winborder/floatborder style)
      vim.api.nvim_set_hl(0, 'PmenuBorder',          { link = 'FloatBorder' })
      vim.api.nvim_set_hl(0, 'PmenuShadow',          { link = 'FloatShadow' })
      vim.api.nvim_set_hl(0, 'PmenuShadowThrough',   { link = 'FloatShadowThrough' })

      -- Inline diff (added characters within a changed line)
      vim.api.nvim_set_hl(0, 'DiffTextAdd',          { link = 'DiffAdd' })

      -- Active snippet tabstop
      vim.api.nvim_set_hl(0, 'SnippetTabstopActive', { link = 'Visual' })

      -- LSP rename target
      vim.api.nvim_set_hl(0, 'LspReferenceTarget',   { link = 'LspReferenceWrite' })

      -- Message types
      vim.api.nvim_set_hl(0, 'OkMsg',                { link = 'DiagnosticOk' })
      vim.api.nvim_set_hl(0, 'StderrMsg',            { link = 'ErrorMsg' })
      vim.api.nvim_set_hl(0, 'StdoutMsg',            { link = 'Normal' })
    end

    set_highlights()

    -- Re-apply if colorscheme is changed at runtime
    vim.api.nvim_create_autocmd('ColorScheme', { callback = set_highlights })
  end,
}
