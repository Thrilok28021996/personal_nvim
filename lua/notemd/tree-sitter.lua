return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  opts = {
    ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'python' },
    auto_install = true,
    highlight = { enable = true },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = {
          [']f'] = '@function.outer',
          [']C'] = '@class.outer', -- Changed from ]c to avoid conflict with diff navigation
          [']a'] = '@parameter.inner',
          [']l'] = '@loop.outer',
          [']i'] = '@conditional.outer',
        },
        goto_next_end = {
          [']F'] = '@function.outer',
          [']CC'] = '@class.outer', -- Changed from ]C (was goto_end)
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[C'] = '@class.outer', -- Changed from [c to avoid conflict with diff navigation
          ['[a'] = '@parameter.inner',
          ['[l'] = '@loop.outer',
          ['[i'] = '@conditional.outer',
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
          ['[CC'] = '@class.outer', -- Changed from [C (was goto_end)
        },
      },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          -- Function
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          -- Class
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          -- Statement
          ['as'] = '@statement.outer',
          ['is'] = '@statement.outer', -- No inner variant
          -- Conditional (if, else, switch)
          ['ai'] = '@conditional.outer',
          ['ii'] = '@conditional.inner',
          -- Loop (for, while)
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
          -- Parameter/Argument
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          -- Comment
          ['aC'] = '@comment.outer',
          ['iC'] = '@comment.outer', -- No inner variant
          -- Block
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner', -- Swap with next parameter
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner', -- Swap with previous parameter
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
