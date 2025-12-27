-- Keymaps for better default experience

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-- For conciseness
local map = vim.keymap.set

-- Disable the spacebar key's default behavior in Normal and Visual modes
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- ============================================================================
-- Basic Editor Operations
-- ============================================================================

-- Clear highlights
map('n', '<Esc>', '<cmd>noh<CR>', { noremap = true, silent = true, desc = 'Clear search highlights' })

-- Save file
map('n', '<C-s>', '<cmd>w<CR>', { noremap = true, silent = true, desc = 'Save file' })

-- Quit file
map('n', '<C-q>', '<cmd>q<CR>', { noremap = true, silent = true, desc = 'Quit window' })

-- Comment toggle
map('n', '<C-/>', 'gcc', { remap = true, desc = 'Toggle comment' })
map('v', '<C-/>', 'gc', { remap = true, desc = 'Toggle comment' })

-- Delete single character without copying into register
map('n', 'x', '"_x', { noremap = true, silent = true, desc = 'Delete character' })

-- Select all content
map('n', '<C-a>', 'ggVG', { noremap = true, silent = true, desc = 'Select all content' })

-- Yank to system clipboard
map({ 'n', 'v' }, '<leader>y', [["+y]], { noremap = true, silent = true, desc = 'Yank to system clipboard' })
map('n', '<leader>Y', [["+Y]], { noremap = true, silent = true, desc = 'Yank line to system clipboard' })

-- Search and replace with confirmation
map('n', '<leader>sr', [[:%s///gc<Left><Left><Left>]], { desc = 'Prompted search and replace with confirmation' })

-- ============================================================================
-- Buffer Management
-- ============================================================================

-- Navigate buffers
map('n', '<Tab>', '<cmd>bnext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
map('n', '<S-Tab>', '<cmd>bprevious<CR>', { noremap = true, silent = true, desc = 'Previous buffer' })

-- Close buffers
map('n', '<leader>bc', '<cmd>bdel<CR>', { noremap = true, silent = true, desc = 'Close buffer' })
map('n', '<leader>bq', '<cmd>bdel!<CR>', { noremap = true, silent = true, desc = 'Force close buffer' })

-- ============================================================================
-- Window Management
-- ============================================================================

-- Split windows
map('n', '<leader>v', '<C-w>v', { noremap = true, silent = true, desc = 'Split window vertically' })
map('n', '<leader>wh', '<C-w>s', { noremap = true, silent = true, desc = 'Split window horizontally' })
map('n', '<leader>we', '<C-w>=', { noremap = true, silent = true, desc = 'Equal window sizes' })
map('n', '<leader>wc', '<cmd>close<CR>', { noremap = true, silent = true, desc = 'Close window' })

-- Navigate between windows
map('n', '<C-k>', '<cmd>wincmd k<CR>', { noremap = true, silent = true, desc = 'Move to window above' })
map('n', '<C-j>', '<cmd>wincmd j<CR>', { noremap = true, silent = true, desc = 'Move to window below' })
map('n', '<C-h>', '<cmd>wincmd h<CR>', { noremap = true, silent = true, desc = 'Move to window left' })
map('n', '<C-l>', '<cmd>wincmd l<CR>', { noremap = true, silent = true, desc = 'Move to window right' })

-- ============================================================================
-- Visual Mode Operations
-- ============================================================================

-- Stay in indent mode
map('v', '<', '<gv', { noremap = true, silent = true, desc = 'Indent left' })
map('v', '>', '>gv', { noremap = true, silent = true, desc = 'Indent right' })

-- Keep last yanked when pasting
map('v', 'p', '"_dP', { noremap = true, silent = true, desc = 'Paste without yanking' })

-- ============================================================================
-- Plugin Manager
-- ============================================================================

map('n', '<leader>l', '<cmd>Lazy<CR>', { noremap = true, silent = true, desc = 'Open Lazy plugin manager' })

-- ============================================================================
-- File Explorer
-- ============================================================================

map('n', '-', '<cmd>Oil<CR>', { noremap = true, silent = true, desc = 'Open parent directory' })

-- ============================================================================
-- Fuzzy Finding
-- ============================================================================

map('n', '<leader>ff', function()
  require('mini.pick').builtin.files()
end, { noremap = true, silent = true, desc = 'Find files' })

map('n', '<leader>fw', function()
  require('mini.pick').builtin.grep_live()
end, { noremap = true, silent = true, desc = 'Find word (grep)' })

map('n', '<leader>fb', function()
  require('mini.pick').builtin.buffers()
end, { noremap = true, silent = true, desc = 'Find buffers' })

-- ============================================================================
-- Terminal
-- ============================================================================

map('n', '<C-t>', '<cmd>terminal<CR>', { noremap = true, silent = true, desc = 'Open terminal' })
map('n', '<leader>ht', '<cmd>split | terminal<CR>', { noremap = true, silent = true, desc = 'Open terminal horizontal' })
map('n', '<leader>vt', '<cmd>vsplit | terminal<CR>', { noremap = true, silent = true, desc = 'Open terminal vertical' })
map('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Exit terminal mode' })
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { noremap = true, silent = true, desc = 'Move to window left from terminal' })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { noremap = true, silent = true, desc = 'Move to window below from terminal' })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { noremap = true, silent = true, desc = 'Move to window above from terminal' })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { noremap = true, silent = true, desc = 'Move to window right from terminal' })

-- ============================================================================
-- AI Assistants
-- ============================================================================

-- Gen.nvim - Fast AI prompts (local Ollama)
map({ 'n', 'v' }, '<leader>gg', '<cmd>Gen<CR>', { noremap = true, silent = true, desc = 'Gen: Show all prompts' })
map({ 'n', 'v' }, '<leader>gc', '<cmd>Gen Chat<CR>', { noremap = true, silent = true, desc = 'Gen: Chat' })
map({ 'n', 'v' }, '<leader>gk', '<cmd>Gen Complete_Code<CR>', { noremap = true, silent = true, desc = 'Gen: Complete code' })
map({ 'n', 'v' }, '<leader>ge', '<cmd>Gen Explain_Code<CR>', { noremap = true, silent = true, desc = 'Gen: Explain code' })
map({ 'n', 'v' }, '<leader>gf', '<cmd>Gen Fix_Code<CR>', { noremap = true, silent = true, desc = 'Gen: Fix bugs' })
map({ 'n', 'v' }, '<leader>go', '<cmd>Gen Optimize_Code<CR>', { noremap = true, silent = true, desc = 'Gen: Optimize code' })
map({ 'n', 'v' }, '<leader>gr', '<cmd>Gen Refactor_Code<CR>', { noremap = true, silent = true, desc = 'Gen: Refactor code' })
map({ 'n', 'v' }, '<leader>gt', '<cmd>Gen Generate_Tests<CR>', { noremap = true, silent = true, desc = 'Gen: Generate tests' })
map({ 'n', 'v' }, '<leader>gb', '<cmd>Gen Find_Bugs<CR>', { noremap = true, silent = true, desc = 'Gen: Find bugs' })
map({ 'n', 'v' }, '<leader>gd', '<cmd>Gen Generate_Docs<CR>', { noremap = true, silent = true, desc = 'Gen: Generate docs' })
map({ 'n', 'v' }, '<leader>gv', '<cmd>Gen Review_Code<CR>', { noremap = true, silent = true, desc = 'Gen: Review code' })
map({ 'n', 'v' }, '<leader>gx', '<cmd>Gen Add_Comments<CR>', { noremap = true, silent = true, desc = 'Gen: Add comments' })

-- Avante.nvim - Advanced AI assistant (local Ollama)
-- Keymaps are defined in the plugin config:
-- <leader>aa - Toggle Avante chat
-- <leader>ar - Refresh Avante
-- <leader>ae - Edit with AI
-- See :h avante-keymaps for full list

-- ============================================================================
-- IDE Features - Testing (Neotest)
-- ============================================================================

map('n', '<leader>tr', function()
  require('neotest').run.run()
end, { noremap = true, silent = true, desc = 'Test: Run nearest' })

map('n', '<leader>tf', function()
  require('neotest').run.run(vim.fn.expand '%')
end, { noremap = true, silent = true, desc = 'Test: Run file' })

map('n', '<leader>ta', function()
  require('neotest').run.run(vim.fn.getcwd())
end, { noremap = true, silent = true, desc = 'Test: Run all' })

map('n', '<leader>ts', function()
  require('neotest').summary.toggle()
end, { noremap = true, silent = true, desc = 'Test: Toggle summary' })

map('n', '<leader>to', function()
  require('neotest').output.open { enter = true }
end, { noremap = true, silent = true, desc = 'Test: Open output' })

map('n', '<leader>tp', function()
  require('neotest').output_panel.toggle()
end, { noremap = true, silent = true, desc = 'Test: Toggle output panel' })

map('n', '<leader>tS', function()
  require('neotest').run.stop()
end, { noremap = true, silent = true, desc = 'Test: Stop' })

map('n', '<leader>td', function()
  require('neotest').run.run { strategy = 'dap' }
end, { noremap = true, silent = true, desc = 'Test: Debug nearest' })

map('n', '[t', function()
  require('neotest').jump.prev { status = 'failed' }
end, { noremap = true, silent = true, desc = 'Jump to previous failed test' })

map('n', ']t', function()
  require('neotest').jump.next { status = 'failed' }
end, { noremap = true, silent = true, desc = 'Jump to next failed test' })

-- ============================================================================
-- IDE Features - Code Symbols/Outline (Aerial)
-- ============================================================================

map('n', '<leader>a', '<cmd>AerialToggle!<CR>', { noremap = true, silent = true, desc = 'Symbols: Toggle outline' })
map('n', '<leader>A', '<cmd>AerialNavToggle<CR>', { noremap = true, silent = true, desc = 'Symbols: Toggle navigation' })
map('n', '[s', '<cmd>AerialPrev<CR>', { noremap = true, silent = true, desc = 'Jump to previous symbol' })
map('n', ']s', '<cmd>AerialNext<CR>', { noremap = true, silent = true, desc = 'Jump to next symbol' })

-- ============================================================================
-- IDE Features - Project Management (project.nvim)
-- ============================================================================

map('n', '<leader>fp', function()
  local projects = require('project_nvim').get_recent_projects()
  local items = {}
  for _, project in ipairs(projects) do
    local name = vim.fn.fnamemodify(project, ':t')
    table.insert(items, {
      text = name .. ' (' .. project .. ')',
      path = project,
    })
  end
  require('mini.pick').start {
    source = {
      items = items,
      name = 'Projects',
      choose = function(item)
        if item then
          vim.cmd('cd ' .. item.path)
          vim.notify('Switched to project: ' .. item.path, vim.log.levels.INFO)
        end
      end,
    },
  }
end, { noremap = true, silent = true, desc = 'Project: Find projects' })

map('n', '<leader>pr', function()
  local project_root = require('project_nvim.project').get_project_root()
  if project_root then
    vim.notify('Project root: ' .. project_root, vim.log.levels.INFO)
  else
    vim.notify('No project root found', vim.log.levels.WARN)
  end
end, { noremap = true, silent = true, desc = 'Project: Show root' })

map('n', '<leader>pc', function()
  local project_root = require('project_nvim.project').get_project_root()
  if project_root then
    vim.cmd('cd ' .. project_root)
    vim.notify('Changed to project root: ' .. project_root, vim.log.levels.INFO)
  else
    vim.notify('No project root found', vim.log.levels.WARN)
  end
end, { noremap = true, silent = true, desc = 'Project: Change to root' })

-- ============================================================================
-- IDE Features - Build/Task System (Overseer)
-- ============================================================================

map('n', '<leader>ot', '<cmd>OverseerToggle<CR>', { noremap = true, silent = true, desc = 'Task: Toggle list' })
map('n', '<leader>or', '<cmd>OverseerRun<CR>', { noremap = true, silent = true, desc = 'Task: Run' })
map('n', '<leader>oo', '<cmd>OverseerOpen<CR>', { noremap = true, silent = true, desc = 'Task: Open' })
map('n', '<leader>oc', '<cmd>OverseerClose<CR>', { noremap = true, silent = true, desc = 'Task: Close' })
map('n', '<leader>oq', '<cmd>OverseerQuickAction<CR>', { noremap = true, silent = true, desc = 'Task: Quick action' })
map('n', '<leader>oi', '<cmd>OverseerInfo<CR>', { noremap = true, silent = true, desc = 'Task: Info' })
map('n', '<leader>ob', '<cmd>OverseerBuild<CR>', { noremap = true, silent = true, desc = 'Task: Build' })
map('n', '<leader>ol', '<cmd>OverseerLoadBundle<CR>', { noremap = true, silent = true, desc = 'Task: Load bundle' })
map('n', '<leader>os', '<cmd>OverseerSaveBundle<CR>', { noremap = true, silent = true, desc = 'Task: Save bundle' })
map('n', '<leader>od', '<cmd>OverseerDeleteBundle<CR>', { noremap = true, silent = true, desc = 'Task: Delete bundle' })
map('n', '<leader>oa', '<cmd>OverseerTaskAction<CR>', { noremap = true, silent = true, desc = 'Task: Action' })
map('n', '<leader>oC', '<cmd>OverseerClearCache<CR>', { noremap = true, silent = true, desc = 'Task: Clear cache' })

-- ============================================================================
-- IDE Features - Advanced Search/Replace (Spectre)
-- ============================================================================

map('n', '<leader>S', function()
  require('spectre').toggle()
end, { noremap = true, silent = true, desc = 'Search: Toggle Spectre' })

map('n', '<leader>sw', function()
  require('spectre').open_visual { select_word = true }
end, { noremap = true, silent = true, desc = 'Search: Current word' })

map('v', '<leader>sw', function()
  require('spectre').open_visual()
end, { noremap = true, silent = true, desc = 'Search: Selection' })

map('n', '<leader>sp', function()
  require('spectre').open_file_search { select_word = true }
end, { noremap = true, silent = true, desc = 'Search: In current file' })

-- ============================================================================
-- IDE Features - Debugging (DAP)
-- ============================================================================

map('n', '<leader>db', function()
  require('dap').toggle_breakpoint()
end, { noremap = true, silent = true, desc = 'Debug: Toggle breakpoint' })

map('n', '<leader>dB', function()
  require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { noremap = true, silent = true, desc = 'Debug: Set conditional breakpoint' })

map('n', '<leader>dc', function()
  require('dap').continue()
end, { noremap = true, silent = true, desc = 'Debug: Continue' })

map('n', '<leader>di', function()
  require('dap').step_into()
end, { noremap = true, silent = true, desc = 'Debug: Step into' })

map('n', '<leader>do', function()
  require('dap').step_over()
end, { noremap = true, silent = true, desc = 'Debug: Step over' })

map('n', '<leader>dO', function()
  require('dap').step_out()
end, { noremap = true, silent = true, desc = 'Debug: Step out' })

map('n', '<leader>dr', function()
  require('dap').repl.open()
end, { noremap = true, silent = true, desc = 'Debug: Open REPL' })

map('n', '<leader>dl', function()
  require('dap').run_last()
end, { noremap = true, silent = true, desc = 'Debug: Run last' })

map('n', '<leader>dt', function()
  require('dap').terminate()
end, { noremap = true, silent = true, desc = 'Debug: Terminate' })

map('n', '<leader>du', function()
  require('dapui').toggle()
end, { noremap = true, silent = true, desc = 'Debug: Toggle UI' })

-- ============================================================================
-- Markdown - Preview & TOC
-- ============================================================================

map('n', '<leader>mp', '<cmd>PeekOpen<CR>', { noremap = true, silent = true, desc = 'Preview: Open' })
map('n', '<leader>mc', '<cmd>PeekClose<CR>', { noremap = true, silent = true, desc = 'Preview: Close' })

-- ============================================================================
-- Markdown-specific keymaps (only active in markdown files)
-- ============================================================================

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    local opts = { buffer = true, noremap = true, silent = true }

    -- Formatting (Visual mode) - Use Ctrl for common editor shortcuts
    vim.keymap.set('v', '<C-b>', function()
      vim.cmd "normal! `<i**`>la**"
    end, vim.tbl_extend('force', opts, { desc = 'Bold text' }))

    vim.keymap.set('v', '<C-i>', function()
      vim.cmd "normal! `<i*`>la*"
    end, vim.tbl_extend('force', opts, { desc = 'Italic text' }))

    vim.keymap.set('v', '<leader>`', function()
      vim.cmd "normal! `<i`<Esc>`>la`<Esc>"
    end, vim.tbl_extend('force', opts, { desc = 'Inline code' }))

    -- Insert commands - <leader>i prefix (insert - only in markdown buffers)
    vim.keymap.set('n', '<leader>il', function()
      local text = vim.fn.input 'Link text: '
      local url = vim.fn.input 'URL: '
      if url ~= '' then
        local link = string.format('[%s](%s)', text, url)
        vim.api.nvim_put({ link }, 'c', true, true)
      end
    end, vim.tbl_extend('force', opts, { desc = 'Insert: Link' }))

    vim.keymap.set('n', '<leader>ii', function()
      local alt = vim.fn.input 'Alt text: '
      local url = vim.fn.input 'Image URL: '
      if url ~= '' then
        local line = string.format('![%s](%s)', alt, url)
        vim.api.nvim_put({ line }, 'l', true, true)
      end
    end, vim.tbl_extend('force', opts, { desc = 'Insert: Image' }))

    vim.keymap.set('n', '<leader>ic', function()
      local lang = vim.fn.input 'Language: '
      local lines = { '```' .. lang, '', '```' }
      vim.api.nvim_put(lines, 'l', true, true)
      vim.cmd 'normal! k'
    end, vim.tbl_extend('force', opts, { desc = 'Insert: Code block' }))

    vim.keymap.set('n', '<leader>it', function()
      local cols = tonumber(vim.fn.input 'Columns: ') or 2
      local header = '| ' .. string.rep('Column | ', cols)
      local separator = '| ' .. string.rep('--- | ', cols)
      local row = '| ' .. string.rep(' | ', cols)
      vim.api.nvim_put({ header, separator, row }, 'l', true, true)
    end, vim.tbl_extend('force', opts, { desc = 'Insert: Table' }))

    vim.keymap.set('n', '<leader>ih', function()
      vim.api.nvim_put({ '---' }, 'l', true, true)
    end, vim.tbl_extend('force', opts, { desc = 'Insert: Horizontal rule' }))

    vim.keymap.set('n', '<leader>ix', function()
      local text = vim.fn.input 'Task: '
      vim.api.nvim_put({ '- [ ] ' .. text }, 'l', true, true)
    end, vim.tbl_extend('force', opts, { desc = 'Insert: Checkbox' }))

    -- Headings - <leader>h prefix (heading)
    for i = 1, 6 do
      vim.keymap.set('n', '<leader>h' .. i, function()
        local line = vim.api.nvim_get_current_line()
        line = line:gsub('^#* *', '')
        vim.api.nvim_set_current_line(string.rep('#', i) .. ' ' .. line)
      end, vim.tbl_extend('force', opts, { desc = 'Heading: H' .. i }))
    end

    -- TOC commands - <leader>m prefix (markdown)
    vim.keymap.set('n', '<leader>mg', '<cmd>GenTocGFM<CR>', vim.tbl_extend('force', opts, { desc = 'Markdown: Generate TOC' }))
    vim.keymap.set('n', '<leader>mu', '<cmd>UpdateToc<CR>', vim.tbl_extend('force', opts, { desc = 'Markdown: Update TOC' }))
    vim.keymap.set('n', '<leader>md', '<cmd>RemoveToc<CR>', vim.tbl_extend('force', opts, { desc = 'Markdown: Delete TOC' }))
  end,
})
