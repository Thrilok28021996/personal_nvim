-- Pre-defined macros in named registers. Play with @<reg>, repeat with @@.
-- Edit any macro with <leader>qm. Browse active macros with :ShowMacros.

-- ── Surround ──────────────────────────────────────────────────────────────────
vim.fn.setreg('a', 'A;<Esc>j')                  -- add semicolon + move down
vim.fn.setreg('b', 'ciw"<C-r>""<Esc>')          -- wrap in "double quotes"
vim.fn.setreg('c', "ciw'<C-r>\"'<Esc>")         -- wrap in 'single quotes'
vim.fn.setreg('d', 'ciw`<C-r>"`<Esc>')          -- wrap in `backticks`
vim.fn.setreg('e', 'ciw(<C-r>")<Esc>')          -- wrap in (parens)
vim.fn.setreg('f', 'ciw[<C-r>"]<Esc>')          -- wrap in [brackets]
vim.fn.setreg('g', 'ciw{<C-r>"}<Esc>')          -- wrap in {braces}

-- ── Case Conversion ───────────────────────────────────────────────────────────
vim.fn.setreg('h', ':s/_\\([a-z]\\)/\\u\\1/g<CR>') -- snake_case → camelCase
vim.fn.setreg('i', ':s/\\([a-z]\\)\\([A-Z]\\)/\\1_\\l\\2/g<CR>') -- camelCase → snake_case
vim.fn.setreg('u', 'gUiw')                      -- word → WORD
vim.fn.setreg('v', 'guiw')                      -- WORD → word

-- ── Line Operations ───────────────────────────────────────────────────────────
vim.fn.setreg('j', 'yyp')                       -- duplicate line down
vim.fn.setreg('k', 'yyP')                       -- duplicate line up
vim.fn.setreg('n', '<C-a>j')                    -- increment number + move down
vim.fn.setreg('o', '<C-x>j')                    -- decrement number + move down
vim.fn.setreg('w', 'dawwP')                     -- swap word with next
vim.fn.setreg('x', ':s/\\s\\+$//<CR>')          -- trim trailing whitespace

-- ── Debug Print ───────────────────────────────────────────────────────────────
vim.fn.setreg('p', 'yiwoprint(f"{<Esc>pa=}")<Esc>')            -- Python f-string print
vim.fn.setreg('r', "yiwoconsole.log('<Esc>pa:', <Esc>pa)<Esc>") -- JS console.log
vim.fn.setreg('s', 'yiwostd::cout << "<Esc>pa: " << <Esc>pa << std::endl;<Esc>') -- C++ cout

-- ── Misc ──────────────────────────────────────────────────────────────────────
vim.fn.setreg('t', ':s/TODO:/TODO(' .. vim.fn.expand '$USER' .. '):/g<CR>A [' .. os.date '%Y-%m-%d' .. ']<Esc>')
vim.fn.setreg('y', 'yif')                       -- yank inner function
vim.fn.setreg('z', 'zc')                        -- fold current block

-- ── Build Commands ────────────────────────────────────────────────────────────
vim.api.nvim_create_user_command('CMakeConfigure', function()
  vim.cmd 'split | terminal cmake -B build'
end, { desc = 'CMake configure' })

vim.api.nvim_create_user_command('CMakeBuild', function()
  vim.cmd 'split | terminal cmake --build build'
end, { desc = 'CMake build' })

vim.api.nvim_create_user_command('CMakeRun', function()
  local exe = vim.fn.input('Executable: ', 'main')
  vim.cmd('split | terminal cmake -B build && cmake --build build && ./build/' .. exe)
end, { desc = 'CMake configure + build + run' })

-- ── Language Commands ─────────────────────────────────────────────────────────
vim.api.nvim_create_user_command('PyDocstring', function()
  vim.api.nvim_put({ '"""', '', 'Args:', '    ', '', 'Returns:', '    ', '"""' }, 'l', true, true)
  vim.cmd 'normal! 6kA'
end, { desc = 'Python: insert docstring template' })

vim.api.nvim_create_user_command('CppClass', function()
  local name = vim.fn.input 'Class name: '
  if name == '' then return end
  vim.api.nvim_put({
    'class ' .. name .. ' {',
    'public:',
    '    ' .. name .. '() = default;',
    '    ~' .. name .. '() = default;',
    '',
    'private:',
    '};',
  }, 'l', true, true)
end, { desc = 'C++: insert class template' })

vim.api.nvim_create_user_command('CppIncludeGuard', function()
  local guard = vim.fn.expand('%:t:r'):upper():gsub('[%.%-]', '_') .. '_H'
  vim.api.nvim_buf_set_lines(0, 0, 0, false, { '#ifndef ' .. guard, '#define ' .. guard, '' })
  vim.cmd 'normal! G'
  vim.api.nvim_put({ '', '#endif // ' .. guard }, 'l', true, true)
end, { desc = 'C++: add include guard' })

-- ── Macro Utilities ───────────────────────────────────────────────────────────
vim.api.nvim_create_user_command('WrapWith', function(opts)
  local args = vim.split(opts.args, ' ')
  if #args == 2 then
    vim.cmd('normal! `<i' .. args[1] .. '<Esc>`>a' .. args[2] .. '<Esc>')
  else
    vim.notify('Usage: WrapWith <open> <close>', vim.log.levels.ERROR)
  end
end, { nargs = '+', range = true })

vim.api.nvim_create_user_command('MacroOnPattern', function(opts)
  local args = vim.split(opts.args, ' ')
  if #args == 2 then
    vim.cmd('g' .. args[1] .. '/normal @' .. args[2])
  else
    vim.notify('Usage: MacroOnPattern <pattern> <register>', vim.log.levels.ERROR)
  end
end, { nargs = '+' })

vim.api.nvim_create_user_command('MacroOnSelection', function(opts)
  vim.cmd("'<,'>normal @" .. opts.args)
end, { nargs = 1, range = true })

vim.api.nvim_create_user_command('ShowMacros', function()
  local macros = {}
  for i = 97, 122 do
    local reg = string.char(i)
    local content = vim.fn.getreg(reg)
    if content ~= '' then table.insert(macros, reg .. ': ' .. content) end
  end
  if #macros == 0 then vim.notify('No macros recorded', vim.log.levels.INFO) return end
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, macros)
  local w, h = 80, math.min(#macros, 20)
  vim.api.nvim_open_win(buf, true, {
    relative = 'editor', style = 'minimal', border = 'rounded',
    width = w, height = h,
    row = math.floor((vim.o.lines - h) / 2),
    col = math.floor((vim.o.columns - w) / 2),
    title = ' Macros ', title_pos = 'center',
  })
  vim.keymap.set('n', 'q',     '<cmd>close<cr>', { buffer = buf })
  vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf })
end, { desc = 'Show all non-empty macro registers' })
