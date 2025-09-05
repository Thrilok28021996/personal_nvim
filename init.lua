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

  require 'plugins.git-signs',
  require 'plugins.lazygit',
  require 'plugins.markdown',
  require 'plugins.markdown-extras',

  -- Note-taking plugins
  require 'notemd.tree-sitter',
  require 'notemd.markdown-preview',
  require 'notemd.img-clip',
  require 'notemd.rendering-markdown',
}

