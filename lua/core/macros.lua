-- Useful macros for software developers
-- These are pre-defined macros stored in registers for quick access

-- ============================================================================
-- How to Use These Macros
-- ============================================================================
-- Each macro is stored in a named register (a-z)
-- To play a macro: @<register> (e.g., @a)
-- To repeat last macro: @@
-- To play macro N times: N@<register> (e.g., 10@a)
--
-- Custom keymaps (from keymaps.lua):
-- <leader>qq → Start recording to register 'q'
-- <leader>qw → Play macro from register 'q'
-- <leader>qe → Replay last macro
-- <leader>qm → Edit a macro
-- ============================================================================

-- ============================================================================
-- Pre-defined Developer Macros
-- ============================================================================

-- Macro 'a': Add semicolon to end of line and move down
-- Use: Fix missing semicolons in C/C++/JS
-- Usage: @a or 10@a for 10 lines
vim.fn.setreg('a', 'A;<Esc>j')

-- Macro 'b': Wrap word in double quotes
-- Use: "word" → '"word"'
-- Usage: Place cursor on word, @b
vim.fn.setreg('b', 'ciw"<C-r>""<Esc>')

-- Macro 'c': Wrap word in single quotes
-- Use: word → 'word'
-- Usage: Place cursor on word, @c
vim.fn.setreg('c', "ciw'<C-r>\"'<Esc>")

-- Macro 'd': Wrap word in backticks (for code/markdown)
-- Use: word → `word`
-- Usage: Place cursor on word, @d
vim.fn.setreg('d', 'ciw`<C-r>"`<Esc>')

-- Macro 'e': Wrap word in parentheses
-- Use: word → (word)
-- Usage: Place cursor on word, @e
vim.fn.setreg('e', 'ciw(<C-r>")<Esc>')

-- Macro 'f': Wrap word in square brackets
-- Use: word → [word]
-- Usage: Place cursor on word, @f
vim.fn.setreg('f', 'ciw[<C-r>"]<Esc>')

-- Macro 'g': Wrap word in curly braces
-- Use: word → {word}
-- Usage: Place cursor on word, @g
vim.fn.setreg('g', 'ciw{<C-r>"}<Esc>')

-- Macro 'h': Convert snake_case to camelCase
-- Use: my_variable → myVariable
-- Usage: Place cursor on word, @h
vim.fn.setreg('h', ':s/_\\([a-z]\\)/\\u\\1/g<CR>')

-- Macro 'i': Convert camelCase to snake_case
-- Use: myVariable → my_variable
-- Usage: Place cursor on word, @i
vim.fn.setreg('i', ':s/\\([a-z]\\)\\([A-Z]\\)/\\1_\\l\\2/g<CR>')

-- Macro 'j': Duplicate line down
-- Use: Creates a copy of current line below
-- Usage: @j
vim.fn.setreg('j', 'yyp')

-- Macro 'k': Duplicate line up
-- Use: Creates a copy of current line above
-- Usage: @k
vim.fn.setreg('k', 'yyP')

-- Macro 'l': Toggle line comment (for languages with // comments)
-- Use: Toggles // at start of line
-- Usage: @l
vim.fn.setreg('l', 'I// <Esc>j')

-- Macro 'm': Remove line comment (for languages with // comments)
-- Use: Removes // from start of line
-- Usage: @m
vim.fn.setreg('m', ':s/^\\/\\/ //<CR>j')

-- Macro 'n': Increment number under cursor and move down
-- Use: Increment version numbers, counters, etc.
-- Usage: @n or 10@n for 10 increments
vim.fn.setreg('n', '<C-a>j')

-- Macro 'o': Decrement number under cursor and move down
-- Use: Decrement counters
-- Usage: @o
vim.fn.setreg('o', '<C-x>j')

-- Macro 'p': Print statement for current word (Python)
-- Use: variable → print(f"{variable=}")
-- Usage: Place cursor on variable name, @p
vim.fn.setreg('p', 'yiwoprint(f"{<Esc>pa=}")<Esc>')

-- Macro 'r': Console.log for current word (JavaScript)
-- Use: variable → console.log('variable:', variable)
-- Usage: Place cursor on variable name, @r
vim.fn.setreg('r', 'yiwoconsole.log(\'<Esc>pa:\', <Esc>pa)<Esc>')

-- Macro 's': std::cout for current word (C++)
-- Use: variable → std::cout << "variable: " << variable << std::endl;
-- Usage: Place cursor on variable name, @s
vim.fn.setreg('s', 'yiwostd::cout << "<Esc>pa: " << <Esc>pa << std::endl;<Esc>')

-- Macro 't': Convert TODO comment to formatted TODO
-- Use: // TODO: fix this → // TODO(username): fix this [DATE]
-- Usage: On line with TODO, @t
vim.fn.setreg('t', ':s/TODO:/TODO(' .. vim.fn.expand('$USER') .. '):/g<CR>A [' .. os.date('%Y-%m-%d') .. ']<Esc>')

-- Macro 'u': Uppercase word
-- Use: word → WORD
-- Usage: Place cursor on word, @u
vim.fn.setreg('u', 'gUiw')

-- Macro 'v': Lowercase word
-- Use: WORD → word
-- Usage: Place cursor on word, @v
vim.fn.setreg('v', 'guiw')

-- Macro 'w': Swap word with next word
-- Use: word1 word2 → word2 word1
-- Usage: Place cursor on first word, @w
vim.fn.setreg('w', 'dawwP')

-- Macro 'x': Delete trailing whitespace on line
-- Use: Removes spaces/tabs at end of line
-- Usage: @x or visual select + @x
vim.fn.setreg('x', ':s/\\s\\+$//<CR>')

-- Macro 'y': Yank inner function (treesitter aware)
-- Use: Yank entire function content
-- Usage: Inside function, @y
vim.fn.setreg('y', 'yif')

-- Macro 'z': Fold current function/class
-- Use: Quickly fold current code block
-- Usage: Inside function/class, @z
vim.fn.setreg('z', 'zc')

-- ============================================================================
-- Build System Commands
-- ============================================================================

-- CMake: Configure project
vim.api.nvim_create_user_command('CMakeConfigure', function()
  vim.cmd 'split | terminal cmake -B build'
end, { desc = 'CMake: Configure project' })

-- CMake: Build project
vim.api.nvim_create_user_command('CMakeBuild', function()
  vim.cmd 'split | terminal cmake --build build'
end, { desc = 'CMake: Build project' })

-- CMake: Configure + Build + Run
vim.api.nvim_create_user_command('CMakeRun', function()
  local exe = vim.fn.input('Executable name: ', 'main')
  vim.cmd('split | terminal cmake -B build && cmake --build build && ./build/' .. exe)
end, { desc = 'CMake: Configure, build, and run' })

-- Make: Build current project
vim.api.nvim_create_user_command('Make', function(opts)
  local target = opts.args ~= '' and opts.args or ''
  vim.cmd('split | terminal make ' .. target)
end, { nargs = '?', desc = 'Make: Build project' })

-- Make: Clean build
vim.api.nvim_create_user_command('MakeClean', function()
  vim.cmd 'split | terminal make clean'
end, { desc = 'Make: Clean build' })

-- ============================================================================
-- Language-Specific Commands
-- ============================================================================

-- Python: Add type hint to current line (word → word: str)
vim.api.nvim_create_user_command('PyTypeHint', function(opts)
  local hint_type = opts.args ~= '' and opts.args or 'str'
  vim.cmd('normal! A: ' .. hint_type)
end, { nargs = '?', desc = 'Python: Add type hint' })

-- Python: Add function docstring
vim.api.nvim_create_user_command('PyDocstring', function()
  vim.api.nvim_put({ '"""', '', 'Args:', '    ', '', 'Returns:', '    ', '"""' }, 'l', true, true)
  vim.cmd 'normal! 6kA'
end, { desc = 'Python: Add docstring template' })

-- Python: Convert to dataclass
vim.api.nvim_create_user_command('PyDataclass', function()
  vim.cmd 'normal! ggO@dataclass'
  vim.cmd 'normal! Ofrom dataclasses import dataclass'
end, { desc = 'Python: Add dataclass decorator' })

-- C++: Add class template
vim.api.nvim_create_user_command('CppClass', function()
  local name = vim.fn.input('Class name: ')
  if name == '' then return end

  local template = {
    'class ' .. name .. ' {',
    'public:',
    '    ' .. name .. '() = default;',
    '    ~' .. name .. '() = default;',
    '',
    'private:',
    '};'
  }
  vim.api.nvim_put(template, 'l', true, true)
end, { desc = 'C++: Add class template' })

-- C++: Add namespace wrapper
vim.api.nvim_create_user_command('CppNamespace', function()
  local name = vim.fn.input('Namespace: ')
  if name == '' then return end

  local start_line = vim.fn.line('.')
  vim.api.nvim_buf_set_lines(0, start_line - 1, start_line - 1, false, { 'namespace ' .. name .. ' {', '' })
  vim.cmd 'normal! G'
  vim.api.nvim_put({ '', '} // namespace ' .. name }, 'l', true, true)
end, { desc = 'C++: Wrap in namespace' })

-- C++: Add include guard
vim.api.nvim_create_user_command('CppIncludeGuard', function()
  local filename = vim.fn.expand('%:t:r'):upper() .. '_H'
  local guard_name = filename:gsub('%.', '_'):gsub('-', '_')

  vim.api.nvim_buf_set_lines(0, 0, 0, false, {
    '#ifndef ' .. guard_name,
    '#define ' .. guard_name,
    '',
  })
  vim.cmd 'normal! G'
  vim.api.nvim_put({ '', '#endif // ' .. guard_name }, 'l', true, true)
end, { desc = 'C++: Add include guard' })

-- ============================================================================
-- Complex Macro Helpers
-- ============================================================================

-- Function to create a macro for wrapping visual selection
-- Usage: :WrapWith ( ) → wraps selection in parentheses
vim.api.nvim_create_user_command('WrapWith', function(opts)
  local args = vim.split(opts.args, ' ')
  if #args == 2 then
    local open, close = args[1], args[2]
    vim.cmd("normal! `<i" .. open .. "<Esc>`>a" .. close .. "<Esc>")
  else
    vim.notify('Usage: WrapWith <open> <close>', vim.log.levels.ERROR)
  end
end, { nargs = '+', range = true })

-- Function to apply macro to all lines matching pattern
-- Usage: :MacroOnPattern /TODO/ a → applies macro 'a' to all TODO lines
vim.api.nvim_create_user_command('MacroOnPattern', function(opts)
  local args = vim.split(opts.args, ' ')
  if #args == 2 then
    local pattern, register = args[1], args[2]
    vim.cmd('g' .. pattern .. '/normal @' .. register)
  else
    vim.notify('Usage: MacroOnPattern <pattern> <register>', vim.log.levels.ERROR)
  end
end, { nargs = '+' })

-- Function to apply macro to visual selection
-- Usage: Visual select, :MacroOnSelection a → applies macro 'a' to each line
vim.api.nvim_create_user_command('MacroOnSelection', function(opts)
  local register = opts.args
  vim.cmd("'<,'>normal @" .. register)
end, { nargs = 1, range = true })

-- ============================================================================
-- Macro Recording Helpers
-- ============================================================================

-- Show all current macros in a floating window
vim.api.nvim_create_user_command('ShowMacros', function()
  local macros = {}
  for i = 97, 122 do -- a-z
    local reg = string.char(i)
    local content = vim.fn.getreg(reg)
    if content ~= '' then
      table.insert(macros, reg .. ': ' .. content)
    end
  end

  if #macros == 0 then
    vim.notify('No macros recorded', vim.log.levels.INFO)
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, macros)

  local width = 80
  local height = math.min(#macros, 20)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = ' Macros ',
    title_pos = 'center',
  })

  vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf })
  vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf })
end, {})

-- Save current macro to init.lua for persistence
vim.api.nvim_create_user_command('SaveMacro', function(opts)
  local register = opts.args
  local content = vim.fn.getreg(register)
  if content == '' then
    vim.notify('Macro ' .. register .. ' is empty', vim.log.levels.WARN)
    return
  end

  local line = "vim.fn.setreg('" .. register .. "', '" .. content:gsub("'", "\\'") .. "')"
  vim.notify('Add this to macros.lua: ' .. line, vim.log.levels.INFO)
end, { nargs = 1 })

-- ============================================================================
-- Macro Keymaps (Additional to keymaps.lua)
-- ============================================================================

-- Quick access to pre-defined macros (optional - uncomment if desired)
-- vim.keymap.set('n', '<leader>ma', '@a', { desc = 'Add semicolon' })
-- vim.keymap.set('n', '<leader>mb', '@b', { desc = 'Wrap in double quotes' })
-- vim.keymap.set('n', '<leader>mc', '@c', { desc = 'Wrap in single quotes' })

-- Macros loaded silently for clean startup experience
