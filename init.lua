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
  require 'plugins.neo-tree',
  require 'plugins.colorscheme',
  require 'plugins.which-key',
  require 'plugins.autoformat',
  require 'plugins.autocompletion',
  require 'plugins.language',
  require 'plugins.navic',
  require 'plugins.mason',
  require 'plugins.trouble',
  require 'plugins.ufo',
  require 'plugins.debugging',
  require 'plugins.testing', -- Test runner (Neotest)
  require 'plugins.symbols', -- Code outline (Aerial)
  require 'plugins.project', -- Project management
  require 'plugins.tasks', -- Build/task system (Overseer)
  require 'plugins.search-replace', -- Advanced search/replace (Spectre)
  require 'plugins.misc',

  require 'plugins.git-signs',
  require 'plugins.lazygit',
  require 'plugins.octo',
  require 'plugins.gen-nvim', -- Fast AI prompts
  require 'plugins.avante', -- Advanced AI assistant

  -- INFO: Note Making Plugins.

  require 'notemd.tree-sitter',
  require 'notemd.markdown-preview',
  require 'notemd.img-clip',
  require 'notemd.rendering-markdown',
  require 'notemd.markdown-table',
  require 'notemd.headlines',
  require 'notemd.mkdnflow',
  require 'notemd.markdown-toc',
  require 'notemd.zen-mode',
}
