return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = false,
  opts = {
    -- Provider configuration
    provider = 'ollama',
    auto_suggestions_provider = 'ollama',

    -- Ollama provider configuration (new format)
    providers = {
      ollama = {
        ['local'] = true,
        endpoint = '127.0.0.1:11434/v1',
        model = 'qwen2.5-coder:14b',
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
      },
    },

    -- Behavior settings
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },

    -- Key mappings
    mappings = {
      diff = {
        ours = 'co',
        theirs = 'ct',
        all_theirs = 'ca',
        both = 'cb',
        cursor = 'cc',
        next = ']x',
        prev = '[x',
      },
      suggestion = {
        accept = '<M-l>',
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<C-]>',
      },
      jump = {
        next = ']]',
        prev = '[[',
      },
      submit = {
        normal = '<CR>',
        insert = '<C-s>',
      },
    },

    hints = { enabled = true },

    windows = {
      position = 'right',
      wrap = true,
      width = 30,
      sidebar_header = {
        align = 'center',
        rounded = true,
      },
    },

    highlights = {
      diff = {
        current = 'DiffText',
        incoming = 'DiffAdd',
      },
    },

    diff = {
      autojump = true,
      list_opener = 'copen',
    },
  },

  build = 'make',

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
