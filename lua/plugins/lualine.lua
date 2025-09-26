-- Set lualine as statusline
return {
  'nvim-lualine/lualine.nvim',
  config = function()
    -- Adapted from: https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/themes/onedark.lua
    local colors = {
      blue = '#61afef',
      green = '#98c379',
      purple = '#c678dd',
      cyan = '#56b6c2',
      red1 = '#e06c75',
      red2 = '#be5046',
      yellow = '#e5c07b',
      fg = '#abb2bf',
      bg = '#282c34',
      gray1 = '#828997',
      gray2 = '#2c323c',
      gray3 = '#3e4452',
    }

    local onedark_theme = {
      normal = {
        a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.gray3 },
        c = { fg = colors.fg, bg = colors.gray2 },
      },
      command = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
      insert = { a = { fg = colors.bg, bg = colors.blue, gui = 'bold' } },
      visual = { a = { fg = colors.bg, bg = colors.purple, gui = 'bold' } },
      terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' } },
      replace = { a = { fg = colors.bg, bg = colors.red1, gui = 'bold' } },
      inactive = {
        a = { fg = colors.gray1, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.gray1, bg = colors.bg },
        c = { fg = colors.gray1, bg = colors.gray2 },
      },
    }

    -- Import color theme based on environment variable NVIM_THEME
    local env_var_nvim_theme = os.getenv 'NVIM_THEME' or 'nord'

    -- Define a table of themes
    local themes = {
      onedark = onedark_theme,
      nord = 'nord',
    }

    local mode = {
      'mode',
      fmt = function(str)
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
        -- return ' ' .. str
        return '' .. str
      end,
    }
    -- Filename component: Shows filename, status, and path level with symbols and color
    local filename = {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
      symbols = {
        modified = '  ', -- Custom modified symbol with padding
        readonly = '  ', -- Custom readonly symbol with padding
        unnamed = '[No Name]', -- Custom unnamed symbol
        newfile = '[New]', -- Custom newfile symbol
      },
      -- Add a subtle color to the filename itself
      color = { fg = colors.cyan },
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      colored = true,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
      diagnostics_color = {
        error = { fg = colors.red1 },
        warn = { fg = colors.yellow },
        info = { fg = colors.cyan },
        hint = { fg = colors.green },
      },
    }

    local diff = {
      'diff',
      colored = true,
      symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
      cond = hide_in_width,
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = themes[env_var_nvim_theme], -- Set theme based on environment variable
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --          
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'neo-tree' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { 'branch', diff },
        lualine_c = { filename },
        lualine_x = { diagnostics, { 'encoding', cond = hide_in_width }, { 'filetype', cond = hide_in_width } },
        lualine_y = { 'location' },
        lualine_z = { 'datetime' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'fugitive' },
    }
  end,
}

-- -- evil line config
-- return {
--   'nvim-lualine/lualine.nvim',
--   dependencies = { 'nvim-tree/nvim-web-devicons' },
--   config = function()
--     -- Eviline config for lualine
--     -- Author: shadmansaleh
--     -- Credit: glepnir
--     local lualine = require 'lualine'
--
--     -- Color table for highlights
--     -- stylua: ignore
--     local colors = {
--       bg        = '#202328',
--       fg        = '#bbc2cf',
--       yellow    = '#ECBE7B',
--       cyan      = '#008080',
--       darkblue  = '#081633',
--       green     = '#98be65',
--       orange    = '#FF8800',
--       violet    = '#a9a1e1',
--       magenta   = '#c678dd',
--       blue      = '#51afef',
--       red       = '#ec5f67',
--     }
--
--     local conditions = {
--       buffer_not_empty = function()
--         return vim.fn.empty(vim.fn.expand '%:t') ~= 1
--       end,
--       hide_in_width = function()
--         return vim.fn.winwidth(0) > 80
--       end,
--       check_git_workspace = function()
--         local filepath = vim.fn.expand '%:p:h'
--         local gitdir = vim.fn.finddir('.git', filepath .. ';')
--         return gitdir and #gitdir > 0 and #gitdir < #filepath
--       end,
--     }
--
--     -- Config
--     local config = {
--       options = {
--         -- Disable sections and component separators
--         component_separators = '',
--         section_separators = '',
--         theme = {
--           -- We are going to use lualine_c an lualine_x as left and
--           -- right section. Both are highlighted by c theme .  So we
--           -- are just setting default looks o statusline
--           normal = { c = { fg = colors.fg, bg = colors.bg } },
--           inactive = { c = { fg = colors.fg, bg = colors.bg } },
--         },
--       },
--       sections = {
--         -- these are to remove the defaults
--         lualine_a = {},
--         lualine_b = {},
--         lualine_y = {},
--         lualine_z = {},
--         -- These will be filled later
--         lualine_c = {},
--         lualine_x = {},
--       },
--       inactive_sections = {
--         -- these are to remove the defaults
--         lualine_a = {},
--         lualine_b = {},
--         lualine_y = {},
--         lualine_z = {},
--         lualine_c = {},
--         lualine_x = {},
--       },
--     }
--
--     -- Inserts a component in lualine_c at left section
--     local function ins_left(component)
--       table.insert(config.sections.lualine_c, component)
--     end
--
--     -- Inserts a component in lualine_x at right section
--     local function ins_right(component)
--       table.insert(config.sections.lualine_x, component)
--     end
--
--     ins_left {
--       function()
--         return '▊'
--       end,
--       color = { fg = colors.blue }, -- Sets highlighting of component
--       padding = { left = 0, right = 1 }, -- We don't need space before this
--     }
--
--     ins_left {
--       -- mode component
--       function()
--         return ''
--       end,
--       color = function()
--         -- auto change color according to neovims mode
--         local mode_color = {
--           n = colors.red,
--           i = colors.green,
--           v = colors.blue,
--           [''] = colors.blue,
--           V = colors.blue,
--           c = colors.magenta,
--           no = colors.red,
--           s = colors.orange,
--           S = colors.orange,
--           [''] = colors.orange,
--           ic = colors.yellow,
--           R = colors.violet,
--           Rv = colors.violet,
--           cv = colors.red,
--           ce = colors.red,
--           r = colors.cyan,
--           rm = colors.cyan,
--           ['r?'] = colors.cyan,
--           ['!'] = colors.red,
--           t = colors.red,
--         }
--         return { fg = mode_color[vim.fn.mode()] }
--       end,
--       padding = { right = 1 },
--     }
--
--     ins_left {
--       -- filesize component
--       'filesize',
--       cond = conditions.buffer_not_empty,
--     }
--
--     ins_left {
--       'filename',
--       cond = conditions.buffer_not_empty,
--       color = { fg = colors.magenta, gui = 'bold' },
--     }
--
--     -- ins_left { 'location' }
--
--     ins_left { 'location', color = { fg = colors.fg, gui = 'bold' } }
--
--     ins_left {
--       'diagnostics',
--       sources = { 'nvim_diagnostic' },
--       symbols = { error = ' ', warn = ' ', info = ' ' },
--       diagnostics_color = {
--         error = { fg = colors.red },
--         warn = { fg = colors.yellow },
--         info = { fg = colors.cyan },
--       },
--     }
--
--     -- Insert mid section. You can make any number of sections in neovim :)
--     -- for lualine it's any number greater then 2
--     ins_left {
--       function()
--         return '%='
--       end,
--     }
--
--     -- Add components to right sections
--     ins_right {
--       'o:encoding', -- option component same as &encoding in viml
--       fmt = string.upper, -- I'm not sure why it's upper case either ;)
--       cond = conditions.hide_in_width,
--       color = { fg = colors.green, gui = 'bold' },
--     }
--
--     ins_right {
--       'fileformat',
--       fmt = string.upper,
--       icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
--       color = { fg = colors.green, gui = 'bold' },
--     }
--
--     ins_right {
--       'branch',
--       icon = '',
--       color = { fg = colors.violet, gui = 'bold' },
--     }
--
--     ins_right {
--       'diff',
--       -- Is it me or the symbol for modified us really weird
--       symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
--       diff_color = {
--         added = { fg = colors.green },
--         modified = { fg = colors.orange },
--         removed = { fg = colors.red },
--       },
--       cond = conditions.hide_in_width,
--     }
--
--     ins_right {
--       function()
--         return '▊'
--       end,
--       color = { fg = colors.blue },
--       padding = { left = 1 },
--     }
--
--     -- Now don't forget to initialize lualine
--     lualine.setup(config)
--   end,
-- }
--
--
--
