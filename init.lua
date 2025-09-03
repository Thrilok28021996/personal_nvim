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

-- Helper function for safe plugin loading
local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify("Failed to load plugin module: " .. module .. "\nError: " .. result, vim.log.levels.WARN)
    return {}
  end
  return result
end

-- NOTE: Here is where you install your plugins.
require('lazy').setup {
<<<<<<< HEAD
  safe_require 'plugins.fileexplorer',
  safe_require 'plugins.colorscheme',
  safe_require 'plugins.which-key',
  safe_require 'plugins.autoformat',
  safe_require 'plugins.terminal',
  safe_require 'plugins.autocompletion',
  safe_require 'plugins.language',
  safe_require 'plugins.linting',
  safe_require 'plugins.debugging',
  safe_require 'plugins.testing',
  safe_require 'plugins.code-intelligence',
  safe_require 'plugins.text-manipulation',
  safe_require 'plugins.session-management',

  safe_require 'plugins.mason',

  safe_require 'plugins.indent-blankline',
  safe_require 'plugins.bufferline',
  safe_require 'plugins.autopairs',
  safe_require 'plugins.lualine',
  safe_require 'plugins.file-picker',
  safe_require 'plugins.todo-comments',
  safe_require 'plugins.noice',
  safe_require 'plugins.git-signs',
  safe_require 'plugins.lazygit',
  safe_require 'plugins.git-tools',

  -- INFO: Note Making Plugins.
  safe_require 'notemd.tree-sitter',
  safe_require 'notemd.obsidian',
  safe_require 'notemd.markdown-preview',
  safe_require 'notemd.img-clip',
  safe_require 'notemd.rendering-markdown',
=======
  require 'plugins.fileexplorer',
  require 'plugins.colorscheme',
  require 'plugins.which-key',
  require 'plugins.autoformat',
  require 'plugins.terminal',
  require 'plugins.autocompletion',
  require 'plugins.language',
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
  require 'plugins.org-mode',
  require 'plugins.org-roam',
  require 'plugins.org-bullets',
  require 'plugins.smear',
  require 'plugins.markdown',
  require 'plugins.markdown-extras',
>>>>>>> refs/remotes/origin/main
}
