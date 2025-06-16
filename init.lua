require 'core.options'
require 'core.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
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
}
