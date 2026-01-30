return {
  {
    'stevearc/aerial.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      -- How to open aerial window
      layout = {
        max_width = { 40, 0.2 }, -- Max 40 cols or 20% of window
        width = nil,
        min_width = 20,
        default_direction = 'prefer_right', -- Open on right side
        placement = 'window',
      },

      -- Show symbols for these filetypes
      attach_mode = 'window', -- Attach to window instead of buffer

      -- Disable on certain buffers
      disable = {
        filetypes = {},
        buftypes = 'special',
      },

      -- Use treesitter for symbol detection
      backends = { 'treesitter', 'lsp', 'markdown', 'man' },

      -- Filtering options
      filter_kind = {
        'Class',
        'Constructor',
        'Enum',
        'Function',
        'Interface',
        'Module',
        'Method',
        'Struct',
        'Type',
        'Variable',
        'Constant',
        'Property',
        'Field',
      },

      -- Symbol highlighting
      highlight_mode = 'split_width', -- Highlight symbol in aerial window

      -- Show line numbers in aerial window
      show_guides = true,

      -- Keymaps in aerial window
      keymaps = {
        ['?'] = 'actions.show_help',
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.jump',
        ['<2-LeftMouse>'] = 'actions.jump',
        ['<C-v>'] = 'actions.jump_vsplit',
        ['<C-s>'] = 'actions.jump_split',
        ['p'] = 'actions.scroll',
        ['<C-j>'] = 'actions.down_and_scroll',
        ['<C-k>'] = 'actions.up_and_scroll',
        ['{'] = 'actions.prev',
        ['}'] = 'actions.next',
        ['[['] = 'actions.prev_up',
        [']]'] = 'actions.next_up',
        ['q'] = 'actions.close',
        ['o'] = 'actions.tree_toggle',
        ['za'] = 'actions.tree_toggle',
        ['O'] = 'actions.tree_toggle_recursive',
        ['zA'] = 'actions.tree_toggle_recursive',
        ['l'] = 'actions.tree_open',
        ['zo'] = 'actions.tree_open',
        ['L'] = 'actions.tree_open_recursive',
        ['zO'] = 'actions.tree_open_recursive',
        ['h'] = 'actions.tree_close',
        ['zc'] = 'actions.tree_close',
        ['H'] = 'actions.tree_close_recursive',
        ['zC'] = 'actions.tree_close_recursive',
        ['zr'] = 'actions.tree_increase_fold_level',
        ['zR'] = 'actions.tree_open_all',
        ['zm'] = 'actions.tree_decrease_fold_level',
        ['zM'] = 'actions.tree_close_all',
        ['zx'] = 'actions.tree_sync_folds',
        ['zX'] = 'actions.tree_sync_folds',
      },

      -- Automatically close aerial when you select a symbol
      close_on_select = false,

      -- Update aerial when you change buffers
      update_events = 'TextChanged,InsertLeave',

      -- Icons for different symbol types
      icons = {
        Collapsed = '',
        Array = '󰅪',
        Boolean = '⊨',
        Class = '󰌗',
        Constructor = '',
        Constant = '󰏿',
        Enum = '',
        EnumMember = '',
        Event = '',
        Field = '',
        File = '󰈙',
        Function = '󰊕',
        Interface = '',
        Key = '󰌋',
        Method = '󰆧',
        Module = '',
        Namespace = '󰌗',
        Null = '󰟢',
        Number = '',
        Object = '󰅩',
        Operator = '󰆕',
        Package = '',
        Property = '󰜢',
        String = '󰀬',
        Struct = '󰌗',
        TypeParameter = '󰊄',
        Variable = '󰀫',
      },

      -- Auto-open aerial in certain scenarios
      open_automatic = false,

      -- Minimum number of symbols required to show aerial
      min_symbols = 1,

      -- Post-parse callback (can be used for custom filtering)
      post_parse_symbol = function(bufnr, item, ctx)
        return true
      end,

      -- Post-add callback
      post_add_all_symbols = function(bufnr, items, ctx)
        return items
      end,
    },

    config = function(_, opts)
      require('aerial').setup(opts)
      -- Keymaps are in lua/core/keymaps.lua
    end,
  },
}
