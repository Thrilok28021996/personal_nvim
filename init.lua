require 'core.options'
require 'core.keymaps'
require 'core.macros'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  -- Core
  require 'plugins.colorscheme',
  require 'plugins.comments',
  require 'plugins.fileexplorer',
  require 'plugins.misc',
  require 'plugins.which-key',
  require 'plugins.mason',

  -- LSP & Completion
  require 'plugins.language',
  require 'plugins.autoformat',
  require 'plugins.autocompletion',
  require 'plugins.linting',

  -- IDE Features
  require 'plugins.symbols',
  require 'plugins.debugging',
  require 'plugins.testing',
  require 'plugins.tasks',
  require 'plugins.project',
  require 'plugins.search-replace',

  -- Git
  require 'plugins.git-signs',
  require 'plugins.lazygit',
  require 'plugins.octo',

  -- AI
  require 'plugins.codecompanion',

  -- Markdown
  require 'notemd.tree-sitter',
  require 'notemd.markdown-preview',
  require 'notemd.img-clip',
  require 'notemd.rendering-markdown',
  require 'notemd.mkdnflow',
  require 'notemd.markdown-toc',
  require 'notemd.zen-mode',

  -- Extra
  require 'plugins.undotree',
  require 'plugins.multicursor',
  require 'plugins.todo-comments',
}
