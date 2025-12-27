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

      -- File paths
      filetypes = { md = true, rmd = true, markdown = true },
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

      -- To-do list
      to_do = {
        symbols = { ' ', '-', 'X' },
        update_parents = true,
        not_started = ' ',
        in_progress = '-',
        complete = 'X',
      },

      -- Tables
      tables = {
        trim_whitespace = true,
        format_on_move = true,
        auto_extend_rows = false,
        auto_extend_cols = false,
      },

      -- Simplified keymaps (intuitive navigation)
      mappings = {
        MkdnEnter = { { 'n', 'v' }, '<CR>' },
        MkdnTab = false,
        MkdnSTab = false,
        MkdnNextLink = false, -- Use Tab in buffer navigation instead
        MkdnPrevLink = false,
        MkdnNextHeading = { 'n', ']]' },
        MkdnPrevHeading = { 'n', '[[' },
        MkdnGoBack = { 'n', '<BS>' },
        MkdnGoForward = false,
        MkdnCreateLink = false,
        MkdnCreateLinkFromClipboard = false,
        MkdnFollowLink = false, -- Using <CR>
        MkdnDestroyLink = false,
        MkdnTagSpan = false,
        MkdnMoveSource = false,
        MkdnYankAnchorLink = false,
        MkdnYankFileAnchorLink = false,
        MkdnIncreaseHeading = { 'n', '+' },
        MkdnDecreaseHeading = { 'n', '-' },
        MkdnToggleToDo = { { 'n', 'v' }, '<C-Space>' },
        MkdnNewListItem = false,
        MkdnNewListItemBelowInsert = { 'n', 'o' },
        MkdnNewListItemAboveInsert = { 'n', 'O' },
        MkdnExtendList = false,
        MkdnUpdateNumbering = false,
        MkdnTableNextCell = { 'i', '<Tab>' },
        MkdnTablePrevCell = { 'i', '<S-Tab>' },
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
