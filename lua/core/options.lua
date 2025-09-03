-- core/options.lua
local o = vim.opt
o.number = true
o.relativenumber = true
o.mouse = 'a'
o.showmode = false
o.clipboard = 'unnamedplus'
o.breakindent = true
o.undofile = true

-- Configure backup, swap, and undo directories
o.backup = false
o.writebackup = false
o.swapfile = false
o.undodir = vim.fn.expand('~/.config/nvim/undo')

-- Create undo directory if it doesn't exist
local undo_dir = vim.fn.expand('~/.config/nvim/undo')
if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, 'p')
end
o.ignorecase = true
o.smartcase = true
o.signcolumn = 'yes'
o.updatetime = 100 -- Faster diagnostics and CursorHold events
o.timeoutlen = 500 -- Longer timeout to reduce keymap conflicts
o.splitright = true
o.splitbelow = true
o.list = true
o.listchars = { 
  tab = '» ', 
  trail = '·', 
  nbsp = '␣',
  leadmultispace = '▏   ', -- Show indent guides for 4+ spaces
  extends = '◣',
  precedes = '◤'
}
o.inccommand = 'split'
o.cursorline = true
o.scrolloff = 10

-- For markdown/writing
o.wrap = true -- Wrap long lines
o.linebreak = true -- Break lines at word boundaries
o.conceallevel = 0 -- Don't hide markup by default (plugins will override per filetype)
o.spell = false -- Disable global spell checking (enable per filetype in markdown files)
o.spelllang = 'en_us' -- Spell check language

-- For better completion experience
o.completeopt = 'menu,menuone,noselect' -- Better completion behavior
o.pumheight = 10 -- Limit completion menu height

-- For better search experience
o.hlsearch = true -- Highlight search matches
o.incsearch = true -- Incremental search

-- Performance optimizations
-- o.lazyredraw = true -- Disabled due to conflicts with Noice plugin
o.synmaxcol = 240 -- Limit syntax highlighting for long lines
o.redrawtime = 1500 -- Time limit for redrawing
o.maxmempattern = 1000 -- Limit memory used for pattern matching

-- Better completion and messages
o.shortmess:append('c') -- Don't give completion messages
o.shortmess:append('I') -- Don't show intro message
o.shortmess:append('W') -- Don't show "written" message

-- Better folding
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldlevel = 99 -- Start with all folds open
o.foldcolumn = '0'
o.foldenable = false -- Disable folding by default

-- Better diff experience
o.diffopt:append('internal,algorithm:patience,indent-heuristic')

-- Better terminal colors
o.termguicolors = true

-- Better command line completion
o.wildmode = 'longest:full,full'
o.wildoptions = 'pum'

-- Better whitespace handling
o.fillchars = {
  eob = ' ', -- Remove ~ from end of buffer
  fold = ' ',
  vert = '│',
  diff = '╱',
}

-- Better session handling
o.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'

-- Additional performance optimizations
o.laststatus = 3 -- Global statusline for better performance

-- Enhanced built-in functionality
o.path = o.path + '**' -- Recursive file search for :find
o.wildmenu = true -- Enhanced command line completion
o.wildignore = '*.pyc,*/__pycache__/*,*/node_modules/*,*/.git/*'
o.grepprg = 'rg --vimgrep --smart-case --follow' -- Use ripgrep if available
