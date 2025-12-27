# Neovim IDE - Complete Feature Reference

## New Features Added

### 1. Neo-Tree (File Tree Explorer)
**Plugin**: `nvim-neo-tree/neo-tree.nvim`

**Keybindings:**
- `<leader>e` - Toggle file tree
- `<leader>E` - Reveal current file in tree

**Inside Neo-Tree:**
- `<CR>` or `<2-LeftMouse>` - Open file
- `<space>` - Toggle node (expand/collapse folder)
- `s` - Open in vertical split
- `S` - Open in horizontal split
- `t` - Open in new tab
- `a` - Add file
- `A` - Add directory
- `d` - Delete
- `r` - Rename
- `y` - Copy to clipboard
- `x` - Cut to clipboard
- `p` - Paste from clipboard
- `H` - Toggle hidden files
- `/` - Fuzzy finder
- `[g` / `]g` - Navigate to prev/next git modified file
- `q` - Close window
- `?` - Show help

**Features:**
- Git status indicators (modified, added, deleted, etc.)
- LSP diagnostics in tree
- File icons with colors
- 35-column width on left side
- Auto-follows current file

---

### 2. Trouble (Enhanced Diagnostics)
**Plugin**: `folke/trouble.nvim`

**Keybindings:**
- `<leader>xx` - Toggle diagnostics panel (all workspace)
- `<leader>xX` - Toggle diagnostics for current buffer
- `<leader>cs` - Toggle symbols list
- `<leader>cl` - Toggle LSP definitions/references
- `<leader>xL` - Toggle location list
- `<leader>xQ` - Toggle quickfix list

**Features:**
- Beautiful UI with icons for error types
- Auto-preview on hover
- Jump to errors with `<CR>`
- Filter by severity
- Multi-file diagnostic view
- Integrates with LSP, telescope, and more

---

### 3. UFO (Smart Code Folding)
**Plugin**: `kevinhwang91/nvim-ufo`

**Keybindings:**
- `zR` - Open all folds
- `zM` - Close all folds
- `zr` - Fold less (open one level)
- `zm` - Fold more (close one level)
- `zp` - Peek folded lines under cursor
- `zo` - Open fold under cursor (default)
- `zc` - Close fold under cursor (default)

**Features:**
- LSP-based intelligent folding
- Treesitter fallback
- Beautiful fold preview with line counts
- Fold column with visual indicators (▶/▼)
- Virtual text showing number of folded lines
- Preserves fold state

---

### 4. Navic (Breadcrumb Navigation)
**Plugin**: `SmiteshP/nvim-navic`

**Location:** Integrated into statusline (bottom of screen)

**Features:**
- Shows current code context (file > class > method > ...)
- Auto-updates as cursor moves
- LSP-powered (works with Pyright and Clangd)
- Displays in statusline: ` > ClassName > methodName`
- Click support for navigation

**No keybindings** - automatically displays in statusline

---

### 5. Octo (GitHub Integration)
**Plugin**: `pwntester/octo.nvim`

**Main Keybindings:**
- `<leader>go` - Open Octo menu
- `<leader>goi` - List GitHub issues
- `<leader>gop` - List GitHub pull requests
- `<leader>gor` - List GitHub repositories
- `<leader>gos` - Search GitHub

**Inside Issue/PR View:**
- `<space>ic` - Close issue/PR
- `<space>io` - Reopen issue/PR
- `<space>ca` - Add comment
- `<space>cd` - Delete comment
- `]c` / `[c` - Next/previous comment
- `<C-b>` - Open in browser
- `<C-y>` - Copy URL to clipboard
- `<space>aa` - Add assignee
- `<space>la` - Add label
- `<space>r+` - Add 👍 reaction
- `<space>rh` - Add ❤️ reaction
- `<space>rr` - Add 🚀 reaction

**Pull Request Specific:**
- `<space>po` - Checkout PR
- `<space>pm` - Merge PR
- `<space>psm` - Squash and merge
- `<space>pc` - List PR commits
- `<space>pf` - List changed files
- `<space>pd` - Show PR diff
- `<space>va` - Add reviewer
- `<space>vs` - Start review
- `<space>vr` - Resume review

**Features:**
- View and manage issues
- Review pull requests
- Add comments and reactions
- Merge PRs from Neovim
- Browse commits and files
- Full GitHub workflow support

---

## Existing Features (Already Configured)

### File Navigation
- **Oil.nvim**: `-` (minus key) - Minimal file browser
- **Mini.pick**:
  - `<leader>ff` - Find files
  - `<leader>fw` - Find word (grep)
  - `<leader>fb` - Find buffers

### LSP (Python & C/C++)
- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Find references
- `gi` - Go to implementation
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `<leader>d` - Show diagnostic
- `[d` / `]d` - Next/prev diagnostic

### Debugging (DAP)
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Conditional breakpoint
- `<leader>dc` - Continue
- `<leader>di` - Step into
- `<leader>do` - Step over
- `<leader>dO` - Step out
- `<leader>dr` - Open REPL
- `<leader>du` - Toggle UI

### Testing (Neotest)
- `<leader>tr` - Run nearest test
- `<leader>tf` - Run file tests
- `<leader>ta` - Run all tests
- `<leader>ts` - Toggle summary
- `<leader>to` - Show output
- `<leader>td` - Debug test

### Code Outline (Aerial)
- `<leader>a` - Toggle outline
- `<leader>A` - Toggle navigation
- `[s` / `]s` - Next/prev symbol

### Git
- `<leader>lg` - Open LazyGit
- Git signs in gutter (auto)

### Build/Tasks (Overseer)
- `<leader>or` - Run task
- `<leader>ot` - Toggle task list
- `<leader>ob` - Build

### Search/Replace (Spectre)
- `<leader>S` - Toggle Spectre
- `<leader>sw` - Search current word
- `<leader>sp` - Search in file

### Project
- `<leader>fp` - Find projects
- `<leader>pr` - Show project root

### AI Assistance
- **Gen.nvim**: `<leader>g*` - Fast prompts
- **Avante.nvim**: `<leader>aa` - AI chat

### Markdown (Extensive Support)
- `<leader>mp` - Preview
- `<leader>z` - Zen mode
- `<leader>h1` to `<leader>h6` - Set heading levels
- `<leader>mg` - Generate TOC
- Many more formatting commands

---

## Quick Start Guide

1. **File Navigation:**
   - Press `<leader>e` to open file tree
   - Press `<leader>ff` to fuzzy find files
   - Press `-` for minimal file browser

2. **Code Navigation:**
   - Press `gd` to go to definition
   - Check statusline for breadcrumbs showing current location
   - Press `<leader>a` for code outline

3. **Diagnostics:**
   - Press `<leader>xx` to see all errors/warnings
   - Press `[d` / `]d` to navigate diagnostics
   - Statusline shows diagnostic count

4. **Folding:**
   - Press `zM` to fold everything
   - Press `zR` to unfold everything
   - Press `zp` to peek at folded code

5. **GitHub:**
   - Press `<leader>goi` to view issues
   - Press `<leader>gop` to view PRs
   - Review code directly in Neovim

6. **Debugging:**
   - Press `<leader>db` to set breakpoint
   - Press `<leader>dc` to start debugging
   - Press `<leader>du` to show debug UI

---

## Installation Status

All plugins are now configured and will auto-install on next Neovim startup via Lazy.nvim.

**To install now:**
```bash
nvim
# Wait for Lazy.nvim to install all plugins
# Then restart Neovim
```

## System Requirements

**Required Tools:**
- `git` - For version control
- `gh` (GitHub CLI) - For Octo.nvim GitHub integration
- `ripgrep` - For searching
- `fd` or `find` - For file finding
- Node.js - For some language servers

**Optional:**
- `lazygit` - Enhanced git UI
- Python tools: `pyright`, `black`, `ruff`, `isort`
- C++ tools: `clangd`, `clang-format`

---

## Configuration Files

- **Main config**: `init.lua`
- **Keymaps**: `lua/core/keymaps.lua`
- **Options**: `lua/core/options.lua`
- **Plugins**: `lua/plugins/*.lua`
- **Markdown**: `lua/notemd/*.lua`

---

## What Makes This a Complete IDE?

✅ **File Management**: Neo-tree + Oil.nvim
✅ **Code Intelligence**: LSP with breadcrumbs
✅ **Diagnostics**: Trouble.nvim panel
✅ **Code Navigation**: Go to def, find refs, outline
✅ **Code Folding**: Smart LSP-based folding
✅ **Debugging**: Full DAP with UI
✅ **Testing**: Neotest with pytest/gtest
✅ **Git Integration**: Signs + LazyGit + GitHub (Octo)
✅ **Build System**: Overseer tasks
✅ **Search/Replace**: Multi-file with Spectre
✅ **Autocompletion**: Blink.cmp with LSP
✅ **Formatting**: Auto-format on save
✅ **AI Assistant**: Gen.nvim + Avante
✅ **Project Management**: Auto-detect roots
✅ **Markdown Support**: Comprehensive

**Completion Level: 100%** 🎉

Your Neovim is now a fully-featured IDE!
