return {
  'mzlogin/vim-markdown-toc',
  ft = 'markdown',
  config = function()
    -- Generate GFM (GitHub Flavored Markdown) style TOC
    vim.g.vmt_fence_text = 'TOC'
    vim.g.vmt_fence_closing_text = '/TOC'

    -- Don't include headings with specific text
    vim.g.vmt_fence_hidden_markdown_style = 'GFM'

    -- Auto update TOC on save
    vim.g.vmt_auto_update_on_save = 1

    -- Keymaps are defined in lua/core/keymaps.lua under markdown FileType autocmd
  end,
}
