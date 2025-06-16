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

-- clear highlights
map('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true, desc = 'Clear highlights' })

-- save file
map('n', '<C-s>', '<cmd> w <CR>', { noremap = true, silent = true, desc = 'Save the File' })
-- -- Comment
map('n', '<C-/>', 'gcc', { desc = 'Comment the lines', remap = true })
map('v', '<C-/>', 'gc', { desc = 'Comment the lines', remap = true })
-- save file without auto-formatting
-- [[ map('n', '<leader>sn', '<cmd>noautocmd w <CR>', {noremap=true,silent=true}) ]]

-- quit file
map('n', '<C-q>', '<cmd> q <CR>', { noremap = true, silent = true, desc = 'Quit the IDE' })

-- delete single character without copying into register
map('n', 'x', '"_x', { noremap = true, silent = true, desc = 'Delete single character' })

-- Resize with arrows
-- map('n', '<Up>', ':resize -2<CR>', { noremap = true, silent = true, desc = 'Save the File' })
-- map('n', '<Down>', ':resize +2<CR>', { noremap = true, silent = true, desc = 'Save the File' })
-- map('n', '<Left>', ':vertical resize -2<CR>', { noremap = true, silent = true, desc = 'Save the File' })
-- map('n', '<Right>', ':vertical resize +2<CR>', { noremap = true, silent = true, desc = 'Save the File' })

-- Navigate buffers
map('n', '<Tab>', '<CMD>bnext<CR>', { noremap = true, silent = true, desc = 'Go to next Tab' })
map('n', '<S-Tab>', '<CMD>bprevious<CR>', { noremap = true, silent = true, desc = 'Go to previous tab' })
map('n', '<leader>tx', '<CMD>bdel<CR>', { remap = true, silent = true, desc = 'Close the current buffer' })
-- map('n', '<leader>1', "<cmd>lua require('bufferline').go_to_buffer(1)<CR>", opts)
-- map('n', '<leader>2', "<cmd>lua require('bufferline').go_to_buffer(2)<CR>", opts)
-- map('n', '<leader>3', "<cmd>lua require('bufferline').go_to_buffer(3)<CR>", opts)
-- map('n', '<leader>4', "<cmd>lua require('bufferline').go_to_buffer(4)<CR>", opts)
-- keymap('n', '<leader>5', "<cmd>lua require('bufferline').go_to_buffer(5)<CR>", opts)
-- map('n', '<leader>6', "<cmd>lua require('bufferline').go_to_buffer(6)<CR>", opts)
-- map('n', '<leader>7', "<cmd>lua require('bufferline').go_to_buffer(7)<CR>", opts)
-- map('n', '<leader>8', "<cmd>lua require('bufferline').go_to_buffer(8)<CR>", opts)
-- map('n', '<leader>9', "<cmd>lua require('bufferline').go_to_buffer(9)<CR>", opts)

-- window management
map('n', '<leader>v', '<C-w>v', { noremap = true, silent = true, desc = 'split window vertically' })
map('n', '<leader>h', '<C-w>s', { noremap = true, silent = true, desc = 'split window horizontally' })
map('n', '<leader>we', '<C-w>=', { noremap = true, silent = true, desc = 'make split windows equal width & height' })
map('n', '<leader>wc', '<CMD>close<CR>', { noremap = true, silent = true, desc = 'close current split window' })

-- Navigate between splits
map('n', '<C-k>', '<CMD>wincmd k<CR>', { noremap = true, silent = true, desc = 'Go to UP Window' })
map('n', '<C-j>', '<CMD>wincmd j<CR>', { noremap = true, silent = true, desc = 'GO to Down Window' })
map('n', '<C-h>', '<CMD>wincmd h<CR>', { noremap = true, silent = true, desc = 'Go to Left Window' })
map('n', '<C-l>', '<CMD>wincmd l<CR>', { noremap = true, silent = true, desc = 'Go to Right Window' })

-- Stay in indent mode
map('v', '<', '<gv', { noremap = true, silent = true, desc = 'Left Indent' })
map('v', '>', '>gv', { noremap = true, silent = true, desc = 'Right Indent' })

-- Keep last yanked when pasting
map('v', 'p', '"_dP', { noremap = true, silent = true, desc = 'Paste the yanked content' })

-- Search and replace
map('n', '<leader>sr', [[:%s///gc<Left><Left><Left>]], { desc = 'Prompted search and replace with confirmation' })

-- Explicitly yank to system clipboard (highlighted and entire row)
map({ 'n', 'v' }, '<leader>y', [["+y]])
map('n', '<leader>Y', [["+Y]])

-- Map Ctrl+a to select all in normal mode
map('n', '<C-a>', 'ggVG', { noremap = true, silent = true, desc = 'Select the All the content of the file' })
-- Lazy
map('n', '<leader>l', '<CMD>Lazy<CR>', { desc = 'Open Lazy' })
-- File Explorer
map('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- Fuzzy Finding
map('n', '<leader>ff', '<CMD>FzfLua files<CR>', { desc = 'Find Files' })
map('n', '<leader>fw', '<CMD>FzfLua live_grep<CR>', { desc = 'Find the word' })
map('n', '<leader>fb', '<CMD>FzfLua buffers<CR>', { desc = 'Find the buffers' })

-- Org-Mode Productivity Keymaps
-- Quick Capture
map('n', '<leader>oc', '<cmd>lua require("orgmode").action("capture.prompt")<CR>', { desc = 'Org Capture' })
map('n', '<leader>ot', '<cmd>lua require("orgmode").action("capture.refile", {key = "t"})<CR>', { desc = 'Capture Task' })
map('n', '<leader>on', '<cmd>lua require("orgmode").action("capture.refile", {key = "n"})<CR>', { desc = 'Capture Note' })
map('n', '<leader>oj', '<cmd>lua require("orgmode").action("capture.refile", {key = "j"})<CR>', { desc = 'Journal Entry' })
map('n', '<leader>op', '<cmd>lua require("orgmode").action("capture.refile", {key = "p"})<CR>', { desc = 'New Project' })
map('n', '<leader>om', '<cmd>lua require("orgmode").action("capture.refile", {key = "m"})<CR>', { desc = 'Meeting Notes' })
map('n', '<leader>oi', '<cmd>lua require("orgmode").action("capture.refile", {key = "i"})<CR>', { desc = 'Capture Idea' })
map('n', '<leader>or', '<cmd>lua require("orgmode").action("capture.refile", {key = "r"})<CR>', { desc = 'Add Reference' })

-- Agenda and Navigation
map('n', '<leader>oa', '<cmd>lua require("orgmode").action("agenda.prompt")<CR>', { desc = 'Org Agenda' })
map('n', '<leader>ol', '<cmd>lua require("orgmode").action("agenda.agenda")<CR>', { desc = 'Agenda List' })
map('n', '<leader>os', '<cmd>lua require("orgmode").action("agenda.tags")<CR>', { desc = 'Search by Tags' })

-- File Navigation
map('n', '<leader>of', '<cmd>e ~/Documents/orgfiles/<CR>', { desc = 'Open Org Files Directory' })
map('n', '<leader>oT', '<cmd>e ~/Documents/orgfiles/tasks.org<CR>', { desc = 'Open Tasks' })
map('n', '<leader>oN', '<cmd>e ~/Documents/orgfiles/notes.org<CR>', { desc = 'Open Notes' })
map('n', '<leader>oJ', '<cmd>e ~/Documents/orgfiles/journal.org<CR>', { desc = 'Open Journal' })
map('n', '<leader>oP', '<cmd>e ~/Documents/orgfiles/projects.org<CR>', { desc = 'Open Projects' })
map('n', '<leader>oM', '<cmd>e ~/Documents/orgfiles/meetings.org<CR>', { desc = 'Open Meetings' })
map('n', '<leader>oI', '<cmd>e ~/Documents/orgfiles/ideas.org<CR>', { desc = 'Open Ideas' })
map('n', '<leader>oR', '<cmd>e ~/Documents/orgfiles/references.org<CR>', { desc = 'Open References' })

-- Org-Roam Integration
map('n', '<leader>rf', '<cmd>lua require("org-roam").capture_node()<CR>', { desc = 'Create Roam Note' })
map('n', '<leader>rt', '<cmd>lua require("org-roam").toggle()<CR>', { desc = 'Toggle Roam Buffer' })
map('n', '<leader>rn', '<cmd>lua require("org-roam").find_node()<CR>', { desc = 'Find Roam Node' })
map('n', '<leader>ri', '<cmd>lua require("org-roam").insert_node()<CR>', { desc = 'Insert Roam Link' })

-- Markdown/Obsidian Productivity Keymaps
-- Quick Note Creation
map('n', '<leader>mn', '<cmd>ObsidianNew<CR>', { desc = 'New Obsidian Note' })
map('n', '<leader>mt', '<cmd>ObsidianTemplate task-template<CR>', { desc = 'New Task' })
map('n', '<leader>mp', '<cmd>ObsidianTemplate project-template<CR>', { desc = 'New Project' })
map('n', '<leader>mm', '<cmd>ObsidianTemplate meeting-template<CR>', { desc = 'New Meeting Note' })
map('n', '<leader>mi', '<cmd>ObsidianTemplate idea-template<CR>', { desc = 'New Idea' })
map('n', '<leader>mc', '<cmd>ObsidianTemplate person-template<CR>', { desc = 'New Contact' })
map('n', '<leader>mb', '<cmd>ObsidianTemplate book-template<CR>', { desc = 'New Book Note' })
map('n', '<leader>ma', '<cmd>ObsidianTemplate area-template<CR>', { desc = 'New Area' })

-- Daily Notes
map('n', '<leader>md', '<cmd>ObsidianToday<CR>', { desc = "Today's Daily Note" })
map('n', '<leader>my', '<cmd>ObsidianYesterday<CR>', { desc = "Yesterday's Daily Note" })
map('n', '<leader>mD', '<cmd>ObsidianDailies<CR>', { desc = 'Browse Daily Notes' })

-- Navigation and Search
map('n', '<leader>mf', '<cmd>ObsidianQuickSwitch<CR>', { desc = 'Quick Switch Notes' })
map('n', '<leader>ms', '<cmd>ObsidianSearch<CR>', { desc = 'Search Obsidian' })
map('n', '<leader>mw', '<cmd>ObsidianWorkspace<CR>', { desc = 'Switch Workspace' })
map('n', '<leader>mg', '<cmd>ObsidianFollowLink<CR>', { desc = 'Follow Link' })
map('n', '<leader>mB', '<cmd>ObsidianBacklinks<CR>', { desc = 'Show Backlinks' })
map('n', '<leader>mT', '<cmd>ObsidianTags<CR>', { desc = 'Browse Tags' })

-- Link Management
map('n', '<leader>ml', '<cmd>ObsidianLink<CR>', { desc = 'Link Selection' })
map('n', '<leader>mL', '<cmd>ObsidianLinkNew<CR>', { desc = 'Link to New Note' })
map('v', '<leader>ml', '<cmd>ObsidianLink<CR>', { desc = 'Link Selection' })
map('v', '<leader>mL', '<cmd>ObsidianLinkNew<CR>', { desc = 'Link to New Note' })

-- Markdown Utilities
map('n', '<leader>mr', '<cmd>ObsidianRename<CR>', { desc = 'Rename Note' })
map('n', '<leader>me', '<cmd>ObsidianExtractNote<CR>', { desc = 'Extract to New Note' })
map('n', '<leader>mo', '<cmd>ObsidianOpen<CR>', { desc = 'Open in Obsidian App' })

-- Markdown Preview
map('n', '<leader>mvp', '<cmd>MarkdownPreviewToggle<CR>', { desc = 'Toggle Markdown Preview' })
map('n', '<leader>mvs', '<cmd>MarkdownPreview<CR>', { desc = 'Start Markdown Preview' })
map('n', '<leader>mvx', '<cmd>MarkdownPreviewStop<CR>', { desc = 'Stop Markdown Preview' })

-- Table Mode
map('n', '<leader>mtt', '<cmd>TableModeToggle<CR>', { desc = 'Toggle Table Mode' })
map('n', '<leader>mtr', '<cmd>TableModeRealign<CR>', { desc = 'Realign Table' })
map('n', '<leader>mtd', '<cmd>Tableize<CR>', { desc = 'Create Table from Delimiter' })

-- Image Paste
map('n', '<leader>mip', '<cmd>PasteImage<CR>', { desc = 'Paste Image' })
map('v', '<leader>mip', '<cmd>PasteImage<CR>', { desc = 'Paste Image' })

-- File Navigation (Obsidian Vault)
map('n', '<leader>mof', '<cmd>e ~/Documents/obsidian/<CR>', { desc = 'Open Obsidian Vault' })
map('n', '<leader>mot', '<cmd>e ~/Documents/obsidian/templates/<CR>', { desc = 'Open Templates' })
map('n', '<leader>mod', '<cmd>e ~/Documents/obsidian/daily/<CR>', { desc = 'Open Daily Notes' })

-- Quick Markdown Formatting (in insert mode)
map('i', '<C-b>', '****<Left><Left>', { desc = 'Bold Text' })
map('i', '<C-i>', '**<Left>', { desc = 'Italic Text' })
map('i', '<C-u>', '<Esc>yypVr=A<CR>', { desc = 'Underline Header' })

-- Checkbox toggles
map('n', '<leader>x', '<cmd>lua require("obsidian").util.toggle_checkbox()<CR>', { desc = 'Toggle Checkbox' })
