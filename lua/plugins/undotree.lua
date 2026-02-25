return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
  config = function()
    vim.g.undotree_WindowLayout = 2 -- Tree on left, diff below
    vim.g.undotree_SplitWidth = 30
    vim.g.undotree_DiffpanelHeight = 10
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_TreeNodeShape = '*'
    vim.g.undotree_TreeVertShape = '|'
    vim.g.undotree_DiffAutoOpen = 1
  end,
  -- Keymaps are in lua/core/keymaps.lua (Section 8.10)
}
