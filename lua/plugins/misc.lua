return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    -- Indentation guides
    require('mini.indentscope').setup { symbol = '│' }

    -- Fuzzy finding
    require('mini.pick').setup {
      source = {
        cwd = vim.fn.getcwd(),
      },
    }

    -- Status line with navic integration
    local statusline = require 'mini.statusline'
    statusline.setup {
      content = {
        active = function()
          local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
          local git = statusline.section_git { trunc_width = 75 }
          local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
          local filename = statusline.section_filename { trunc_width = 140 }
          local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
          local location = statusline.section_location { trunc_width = 75 }
          local search = statusline.section_searchcount { trunc_width = 75 }

          -- Add navic breadcrumbs if available
          local navic_location = ''
          local has_navic, navic = pcall(require, 'nvim-navic')
          if has_navic and navic.is_available() then
            navic_location = navic.get_location()
            if navic_location ~= '' then
              navic_location = ' > ' .. navic_location
            end
          end

          return statusline.combine_groups {
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
            '%<', -- Mark general truncate point
            { hl = 'MiniStatuslineFilename', strings = { filename } },
            '%=', -- End left alignment
            { hl = 'MiniStatuslineFileinfo', strings = { navic_location } },
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          }
        end,
      },
    }

    -- Auto pairs
    require('mini.pairs').setup()

    -- Icons
    require('mini.icons').setup()

    -- Tabline
    require('mini.tabline').setup()
  end,
}
