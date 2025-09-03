return {
  'kdheepak/lazygit.nvim',
  -- Note: Keymaps are defined in core/keymaps.lua
  -- Lazy loading on command
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
