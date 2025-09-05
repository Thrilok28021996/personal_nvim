-- Enable built-in Lua module loader cache for faster startup
vim.loader.enable()

require 'core.options'
require 'core.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require('lazy').setup {
  require 'plugins.fileexplorer',
  require 'plugins.colorscheme',
  require 'plugins.which-key',
  require 'plugins.autoformat',
  require 'plugins.terminal',
  require 'plugins.autocompletion',
  require 'plugins.language',
  require 'plugins.debugging',
  require 'plugins.testing',
  require 'plugins.code-intelligence',
  require 'plugins.text-manipulation',
  require 'plugins.session-management',
  require 'plugins.git-tools',

  require 'plugins.mason',

  require 'plugins.indent-blankline',
  require 'plugins.bufferline',
  require 'plugins.autopairs',
  require 'plugins.lualine',
  require 'plugins.file-picker',
  require 'plugins.todo-comments',
  require 'plugins.noice',
  require 'plugins.git-signs',
  require 'plugins.lazygit',
  
  -- Org mode plugins
  require 'plugins.org-mode',
  require 'plugins.org-roam',
  require 'plugins.org-bullets',
  
  -- Visual and markdown plugins  
  require 'plugins.smear',
  require 'plugins.markdown',
  require 'plugins.markdown-extras',

  -- Note-taking plugins
  require 'notemd.tree-sitter',
  require 'notemd.obsidian',
  require 'notemd.markdown-preview',
  require 'notemd.img-clip',
  require 'notemd.rendering-markdown',
}

-- Setup org treesitter parser commands
vim.api.nvim_create_user_command('SetupOrgParser', function()
  local setup_org = require('setup-org')
  setup_org.install_org_parser()
end, { desc = 'Configure org treesitter parser for installation' })

vim.api.nvim_create_user_command('CheckOrgParser', function()
  local setup_org = require('setup-org')
  setup_org.check_org_parser()
end, { desc = 'Check if org treesitter parser is installed' })

-- Auto-configure org parser (doesn't install, just sets up configuration)
pcall(require('setup-org').auto_setup)
