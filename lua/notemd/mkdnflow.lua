return {
  'jakewvincent/mkdnflow.nvim',
  ft = 'markdown',
  config = function()
    require('mkdnflow').setup {
      -- File creation and link management
      modules = {
        bib = true,
        buffers = true,
        conceal = true,
        cursor = true,
        folds = false,
        links = true,
        lists = true,
        maps = true,
        paths = true,
        tables = true,
        yaml = false,
      },

      -- filetypes: use new Neovim filetype names (no 'md' key needed)
      create_dirs = true,
      perspective = {
        priority = 'first',
        fallback = 'current',
        root_tell = false,
        nvim_wd_heel = false,
        update = false,
      },

      -- Link interpretation
      links = {
        style = 'markdown',
        name_is_source = false,
        conceal = false,
        context = 0,
        implicit_extension = nil,
        transform_implicit = false,
        transform_explicit = function(text)
          text = text:gsub(' ', '-')
          text = text:lower()
          return text
        end,
      },

      -- To-do list (updated API: use 'statuses' and 'status_propagation')
      to_do = {
        symbols = { ' ', '-', 'X' },
        statuses = {
          { name = 'not_started', marker = ' ' },
          { name = 'in_progress', marker = '-' },
          { name = 'complete',    marker = 'X' },
        },
        status_propagation = {
          up = true,
          down = false,
        },
      },

      -- Tables
      tables = {
        trim_whitespace = true,
        format_on_move = true,
        auto_extend_rows = false,
        auto_extend_cols = false,
      },

      -- Keymaps: avoid conflicts with global bindings
      --   + → global: increment number  → use <leader>+ for heading
      --   - → global: Oil               → use <leader>- for heading
      --   o/O → native open-line        → use <M-o>/<M-O> for list items
      --   i <Tab>/<S-Tab> → snippet nav → use <M-]>/<M-[> for table cells
      mappings = {
        MkdnEnter = { { 'n', 'v' }, '<CR>' },
        MkdnTab = false,
        MkdnSTab = false,
        MkdnNextLink = false,
        MkdnPrevLink = false,
        MkdnNextHeading = { 'n', ']]' },
        MkdnPrevHeading = { 'n', '[[' },
        MkdnGoBack = { 'n', '<BS>' },
        MkdnGoForward = false,
        MkdnCreateLink = false,
        MkdnCreateLinkFromClipboard = false,
        MkdnFollowLink = false,
        MkdnDestroyLink = false,
        MkdnTagSpan = false,
        MkdnMoveSource = false,
        MkdnYankAnchorLink = false,
        MkdnYankFileAnchorLink = false,
        MkdnIncreaseHeading = { 'n', '<leader>h+' }, -- was +, conflicted with increment
        MkdnDecreaseHeading = { 'n', '<leader>h-' }, -- was -, conflicted with Oil
        MkdnToggleToDo = { { 'n', 'v' }, '<C-Space>' },
        MkdnNewListItem = false,
        MkdnNewListItemBelowInsert = { 'n', '<M-o>' }, -- was o, conflicted with native open-line
        MkdnNewListItemAboveInsert = { 'n', '<M-O>' }, -- was O, conflicted with native open-line
        MkdnExtendList = false,
        MkdnUpdateNumbering = false,
        MkdnTableNextCell = { 'i', '<M-]>' },   -- was <Tab>, conflicted with snippets
        MkdnTablePrevCell = { 'i', '<M-[>' },   -- was <S-Tab>, conflicted with snippets
        MkdnTableNextRow = false,
        MkdnTablePrevRow = false,
        MkdnTableNewRowBelow = false,
        MkdnTableNewRowAbove = false,
        MkdnTableNewColAfter = false,
        MkdnTableNewColBefore = false,
        MkdnFoldSection = false,
        MkdnUnfoldSection = false,
      },
    }
  end,
}
