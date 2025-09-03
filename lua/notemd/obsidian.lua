return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  dependencies = {
    -- Required
    'nvim-lua/plenary.nvim',
    -- Updated for blink.cmp compatibility
    'saghen/blink.cmp', -- For completion (replaced nvim-cmp)
    'nvim-treesitter/nvim-treesitter', -- For better syntax highlighting
  },
  opts = {
    workspaces = {
      {
        name = 'cwd',
        path = vim.fn.getcwd(),
      },
    },

    -- Daily notes configuration
    daily_notes = {
      folder = 'dailies',
      date_format = '%Y-%m-%d',
      alias_format = '%B %-d, %Y',
      template = nil, -- Path to daily note template
    },

    -- Note completion settings - Updated for blink.cmp
    completion = {
      nvim_cmp = false, -- Disable nvim-cmp integration
      min_chars = 2,
    },

    -- Mappings for obsidian commands (minimalistic - most keymaps in core/keymaps.lua)
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Smart action (follow link or toggle checkbox) - using Enter key for simplicity
      ['<cr>'] = {
        action = function()
          return require('obsidian').util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },

    -- New note creation
    new_notes_location = 'notes_subdir',
    note_id_func = function(title)
      -- Create note IDs from title if provided, otherwise use timestamp
      local suffix = ''
      if title ~= nil and type(title) == 'string' and title ~= '' then
        -- Convert title to valid filename
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        -- Use timestamp if no title provided
        suffix = tostring(os.time())
      end
      return suffix
    end,

    -- Note path function
    note_path_func = function(spec)
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix '.md'
    end,

    -- Wiki link settings
    wiki_link_func = function(opts)
      if opts.id == nil then
        return string.format('[[%s]]', opts.label)
      elseif opts.label ~= opts.id then
        return string.format('[[%s|%s]]', opts.id, opts.label)
      else
        return string.format('[[%s]]', opts.id)
      end
    end,

    -- Markdown link settings
    markdown_link_func = function(opts)
      return string.format('[%s](%s)', opts.label, opts.path)
    end,

    -- Preferred link style
    preferred_link_style = 'wiki',

    -- Disable default UI for better performance
    ui = {
      enable = false,
    },

    -- Attachments configuration
    attachments = {
      img_folder = 'assets/imgs',
      img_name_func = function()
        return string.format('%s-', os.time())
      end,
    },

    -- YAML frontmatter parsing
    yaml_parser = 'native',

    -- Follow URL behavior
    follow_url_func = function(url)
      vim.fn.jobstart { 'open', url } -- macOS
      -- vim.fn.jobstart({'xdg-open', url})  -- Linux
      -- vim.cmd(':!start ' .. url) -- Windows
    end,

    -- Use advanced URI for links
    use_advanced_uri = true,

    -- Open app on follow
    open_app_foreground = false,

    -- Finder command for searching notes (using built-in vim commands)
    finder = 'builtin',

    -- Sort options
    sort_by = 'modified',
    sort_reversed = true,

    -- Open notes in new splits/tabs
    open_notes_in = 'current',

    -- Templates (disabled by default to avoid directory errors)
    -- To enable: create a 'templates' folder in your workspace and set folder = 'templates'
    templates = {
      folder = nil, -- Set to 'templates' if you have a templates directory
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      substitutions = {},
    },

    -- Disable certain features if needed
    disable_frontmatter = false,

    -- Callbacks
    callbacks = {
      -- Called when entering a buffer for a note
      enter_note = function(client, note) end,
      -- Called when leaving a buffer for a note
      leave_note = function(client, note) end,
      -- Called when creating a new note
      pre_write_note = function(client, note) end,
      -- Called after writing a note
      post_set_note_contents = function(client, note) end,
    },
  },

  -- Note: Keymaps are defined in core/keymaps.lua

  -- Setup function for additional configuration
  config = function(_, opts)
    require('obsidian').setup(opts)

    -- Note: Markdown-specific settings are handled by rendering-markdown.lua
    -- Obsidian-specific autocmds for enhanced functionality
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = '*.md',
      callback = function()
        -- Only set obsidian-specific options that don't conflict
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
      end,
    })
  end,
}
