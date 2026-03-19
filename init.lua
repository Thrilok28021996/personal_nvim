require 'core.options'
require 'core.keymaps'
require 'core.macros'
require 'plugins.misc'
require 'plugins.language'

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
  require 'plugins.fileexplorer',
  require 'plugins.fzf-lua',
  require 'plugins.mason',

  -- LSP & Completion
  require 'plugins.autoformat',
  require 'plugins.linting',

  -- IDE Features
  require 'plugins.debugging',
  require 'plugins.tasks',

  -- Git
  require 'plugins.git-signs',

  -- AI
  require 'plugins.codecompanion',

  -- Markdown
  require 'notemd.tree-sitter',
  require 'notemd.markdown-preview',
  require 'notemd.img-clip',
  require 'notemd.rendering-markdown',
  require 'notemd.mkdnflow',
  require 'notemd.zen-mode',

  -- Extra
  require 'plugins.multicursor',
}
