return {
  'pwntester/octo.nvim',
  cmd = 'Octo',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>go', '<cmd>Octo<cr>', desc = 'GitHub: Open Octo' },
    { '<leader>goi', '<cmd>Octo issue list<cr>', desc = 'GitHub: Issues' },
    { '<leader>gop', '<cmd>Octo pr list<cr>', desc = 'GitHub: PRs' },
    { '<leader>goc', '<cmd>Octo pr checkout<cr>', desc = 'GitHub: Checkout PR' },
  },
  opts = {
    default_remote = { 'upstream', 'origin' },
    default_merge_method = 'squash',
  },
}
