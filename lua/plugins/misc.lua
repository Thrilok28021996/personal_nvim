-- Native alternatives to mini.nvim modules
-- All functionality implemented using native Neovim features

return {
  -- No plugins needed - using native Neovim features configured in init.lua
  -- This file exists for consistency but loads native configs via autocmd

  {
    'native-features',
    name = 'native-mini-alternatives',
    dir = vim.fn.stdpath('config'),
    lazy = false,
    priority = 1000,
    config = function()
      -- ===================================================================
      -- 1. NATIVE STATUSLINE (replaces mini.statusline)
      -- ===================================================================

      -- Statusline function with LSP, git, and file info
      function _G.statusline()
        local mode_map = {
          n = 'NORMAL',
          i = 'INSERT',
          v = 'VISUAL',
          V = 'V-LINE',
          ['\22'] = 'V-BLOCK',
          c = 'COMMAND',
          s = 'SELECT',
          S = 'S-LINE',
          ['\19'] = 'S-BLOCK',
          R = 'REPLACE',
          r = 'PROMPT',
          ['!'] = 'SHELL',
          t = 'TERMINAL',
        }

        local mode = mode_map[vim.api.nvim_get_mode().mode] or 'UNKNOWN'
        local filename = vim.fn.expand('%:t') ~= '' and vim.fn.expand('%:t') or '[No Name]'
        local modified = vim.bo.modified and ' [+]' or ''
        local readonly = vim.bo.readonly and ' [RO]' or ''
        local filetype = vim.bo.filetype ~= '' and ' [' .. vim.bo.filetype .. ']' or ''

        -- LSP status
        local lsp_status = ''
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients > 0 then
          lsp_status = ' LSP:' .. clients[1].name
        end

        -- Python virtual environment (using vim.fs.basename for modern path handling)
        local venv = ''
        if vim.env.VIRTUAL_ENV then
          local venv_name = vim.fs.basename(vim.env.VIRTUAL_ENV)
          venv = ' ' .. venv_name
        end

        -- Position info
        local line = vim.fn.line('.')
        local col = vim.fn.col('.')
        local total_lines = vim.fn.line('$')
        local progress = math.floor((line / total_lines) * 100)

        return string.format(
          ' %s │ %s%s%s%s%s%s │ %d:%d │ %d%% ',
          mode, filename, modified, readonly, filetype, lsp_status, venv, line, col, progress
        )
      end

      vim.opt.statusline = "%{%v:lua.statusline()%}"

      -- ===================================================================
      -- 2. NATIVE TABLINE (replaces mini.tabline)
      -- ===================================================================

      function _G.tabline()
        local current_buf = vim.api.nvim_get_current_buf()

        local tabs = vim.iter(vim.api.nvim_list_bufs())
          :filter(function(buf)
            return vim.fn.buflisted(buf) == 1
          end)
          :map(function(buf)
            local name = vim.fn.bufname(buf)
            name = name ~= '' and vim.fn.fnamemodify(name, ':t') or '[No Name]'
            local highlight = buf == current_buf and '%#TabLineSel#' or '%#TabLine#'
            return highlight .. ' ' .. buf .. ':' .. name .. ' '
          end)
          :totable()

        return table.concat(tabs) .. '%#TabLineFill#'
      end

      vim.opt.tabline = "%{%v:lua.tabline()%}"

      -- ===================================================================
      -- 3. NATIVE AUTO-PAIRS (replaces mini.pairs)
      -- ===================================================================

      local function setup_autopairs()
        local pairs_map = {
          ['('] = ')',
          ['['] = ']',
          ['{'] = '}',
          ['"'] = '"',
          ["'"] = "'",
          ['`'] = '`',
        }

        for open, close in pairs(pairs_map) do
          -- Insert opening and closing pair
          vim.keymap.set('i', open, function()
            return open .. close .. '<Left>'
          end, { expr = true, silent = true })

          -- Skip closing pair if next char matches
          if open ~= close then
            vim.keymap.set('i', close, function()
              local col = vim.fn.col('.')
              local line = vim.api.nvim_get_current_line()
              local next_char = line:sub(col, col)
              if next_char == close then
                return '<Right>'
              end
              return close
            end, { expr = true, silent = true })
          else
            -- For quotes, handle both insert and skip
            vim.keymap.set('i', close, function()
              local col = vim.fn.col('.')
              local line = vim.api.nvim_get_current_line()
              local next_char = line:sub(col, col)
              local prev_char = line:sub(col - 1, col - 1)

              -- Skip if next char is closing quote
              if next_char == close then
                return '<Right>'
              end

              -- Insert pair if not after alphanumeric
              if prev_char:match('[%w]') then
                return close
              end

              return close .. close .. '<Left>'
            end, { expr = true, silent = true })
          end
        end

        -- Backspace deletes pair
        vim.keymap.set('i', '<BS>', function()
          local col = vim.fn.col('.')
          local line = vim.api.nvim_get_current_line()
          local prev_char = line:sub(col - 1, col - 1)
          local next_char = line:sub(col, col)

          for open, close in pairs(pairs_map) do
            if prev_char == open and next_char == close then
              return '<BS><Del>'
            end
          end

          return '<BS>'
        end, { expr = true, silent = true })

        -- Enter expands pairs
        vim.keymap.set('i', '<CR>', function()
          local col = vim.fn.col('.')
          local line = vim.api.nvim_get_current_line()
          local prev_char = line:sub(col - 1, col - 1)
          local next_char = line:sub(col, col)

          if (prev_char == '{' and next_char == '}') or
             (prev_char == '[' and next_char == ']') or
             (prev_char == '(' and next_char == ')') then
            return '<CR><Esc>O'
          end

          return '<CR>'
        end, { expr = true, silent = true })
      end

      setup_autopairs()

      -- ===================================================================
      -- 4. NATIVE INDENT GUIDES (replaces mini.indentscope)
      -- ===================================================================

      -- Use native listchars for indent visualization
      vim.opt.list = true
      vim.opt.listchars = {
        tab = '│ ',
        trail = '·',
        extends = '›',
        precedes = '‹',
        nbsp = '␣',
      }

      -- Highlight current indent level with CursorColumn
      vim.opt.cursorline = true
      vim.opt.cursorcolumn = false

      -- Add subtle indent highlighting via match
      vim.fn.matchadd('Whitespace', [[\(^\s\+\)]], 10)

      -- ===================================================================
      -- 5. NATIVE FUZZY FIND (replaces mini.pick)
      -- ===================================================================

      -- Note: Wildmenu settings are in core/options.lua

      -- Path completion settings for fuzzy find
      vim.opt.path = '.,**'
      vim.opt.complete:append('kspell')

      -- Native fuzzy file finder function
      function _G.fuzzy_find_files()
        local cwd = vim.fn.getcwd()
        vim.ui.input({ prompt = 'Find file: ', completion = 'file' }, function(input)
          if input then
            vim.cmd('edit ' .. input)
          end
        end)
      end

      -- Native grep function
      function _G.fuzzy_grep()
        vim.ui.input({ prompt = 'Grep for: ' }, function(pattern)
          if pattern and pattern ~= '' then
            vim.cmd('vimgrep /' .. pattern .. '/gj **/*')
            vim.cmd('copen')
          end
        end)
      end

      -- Native buffer finder (using vim.iter for modern Lua patterns)
      function _G.fuzzy_buffers()
        local buffers = vim.iter(vim.api.nvim_list_bufs())
          :filter(function(buf)
            return vim.fn.buflisted(buf) == 1
          end)
          :map(function(buf)
            local name = vim.fn.bufname(buf)
            name = name ~= '' and name or '[No Name]'
            return buf .. ': ' .. name
          end)
          :totable()

        vim.ui.select(buffers, {
          prompt = 'Select buffer:',
        }, function(choice)
          if choice then
            local buf_nr = tonumber(choice:match('^%d+'))
            if buf_nr then
              vim.cmd('buffer ' .. buf_nr)
            end
          end
        end)
      end

      -- ===================================================================
      -- 6. NATIVE ICONS (replaces mini.icons)
      -- ===================================================================

      -- Use native filetype icons via signs
      -- Define common file type signs
      local signs = {
        { name = 'lua', text = '' },
        { name = 'python', text = '' },
        { name = 'c', text = '' },
        { name = 'cpp', text = '' },
        { name = 'markdown', text = '' },
        { name = 'json', text = '' },
        { name = 'yaml', text = '' },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define('FileType_' .. sign.name, {
          text = sign.text,
          texthl = 'Directory',
        })
      end

      -- Native alternatives loaded silently for clean startup
    end,
  },
}
