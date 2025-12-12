return {
  {
    'ahmedkhalf/project.nvim',
    name = 'project_nvim',
    config = function()
      require('project_nvim').setup {
        -- Detection methods for project root
        -- Order matters: the first pattern matched will be used
        detection_methods = { 'lsp', 'pattern' },

        -- Patterns to identify project root
        patterns = {
          '.git',
          '_darcs',
          '.hg',
          '.bzr',
          '.svn',
          'Makefile',
          'package.json',
          'setup.py',
          'pyproject.toml',
          'requirements.txt',
          'Cargo.toml',
          'go.mod',
          'CMakeLists.txt',
          'compile_commands.json',
        },

        -- Don't calculate root on these paths
        exclude_dirs = {
          '~/.cargo/*',
          '~/.local/*',
          '~/.cache/*',
          '/tmp/*',
          '/usr/*',
          '/opt/*',
        },

        -- Show hidden files in telescope picker
        show_hidden = false,

        -- Don't auto-change directory when opening a file
        silent_chdir = true,

        -- Scope to change directory: global (whole nvim), tab, or window
        scope_chdir = 'global',

        -- Path to store project history
        datapath = vim.fn.stdpath 'data',
      }
      -- Keymaps are in lua/core/keymaps.lua
    end,
  },
}
