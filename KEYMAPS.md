# Neovim Keymaps Reference

This document provides a comprehensive overview of all custom keymaps configured in this Neovim setup.

## Table of Contents
- [Leader Key](#leader-key)
- [Basic Navigation & Editing](#basic-navigation--editing)
- [Buffer Management](#buffer-management)
- [Window Management](#window-management)
- [Text Manipulation](#text-manipulation)
- [Insert Mode Improvements](#insert-mode-improvements)
- [File Operations & Finding](#file-operations--finding)
- [Terminal Operations](#terminal-operations)
- [Git Integration](#git-integration)
- [LSP Keymaps](#lsp-keymaps)
- [Plugin-Specific Keymaps](#plugin-specific-keymaps)
- [Which-Key Groups](#which-key-groups)

---

## Leader Key

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<Space>` | Normal/Visual | Disabled | Reserved as leader key |

---

## Basic Navigation & Editing

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-s>` | Normal | `:w` | Save current file |
| `<C-q>` | Normal | `:q` | Quit current window |
| `<Esc>` | Normal | `:noh` | Clear search highlights |
| `<C-a>` | Normal | `ggVG` | Select all content in buffer |
| `x` | Normal | `"_x` | Delete character without copying to register |
| `n` | Normal | `nzz` | Next search result (centered) |
| `N` | Normal | `Nzz` | Previous search result (centered) |
| `<C-u>` | Normal | `<C-u>zz` | Page up (centered) |

---

## Buffer Management

### Primary Navigation
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<Tab>` | Normal | `:bnext` | Go to next buffer |
| `<S-Tab>` | Normal | `:bprevious` | Go to previous buffer |

### Direct Buffer Access
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>1` | Normal | `:1buffer` | Go to buffer 1 |
| `<leader>2` | Normal | `:2buffer` | Go to buffer 2 |
| `<leader>3` | Normal | `:3buffer` | Go to buffer 3 |
| `<leader>4` | Normal | `:4buffer` | Go to buffer 4 |
| `<leader>5` | Normal | `:5buffer` | Go to buffer 5 |
| `<leader>6` | Normal | `:6buffer` | Go to buffer 6 |
| `<leader>7` | Normal | `:7buffer` | Go to buffer 7 |
| `<leader>8` | Normal | `:8buffer` | Go to buffer 8 |
| `<leader>9` | Normal | `:9buffer` | Go to buffer 9 |

### Buffer Management
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>bb` | Normal | `:buffer ` | Interactive buffer selection (prompts for name/number) |
| `<leader>bd` | Normal | `:bdelete` | Delete current buffer |
| `<leader>bo` | Normal | `:%bdelete\|edit#` | Close all other buffers except current |

---

## Window Management

### Window Navigation
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-h>` | Normal | `<C-w>h` | Move to left window |
| `<C-j>` | Normal | `<C-w>j` | Move to lower window |
| `<C-k>` | Normal | `<C-w>k` | Move to upper window |
| `<C-l>` | Normal | `<C-w>l` | Move to right window |

### Window Splitting
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>wv` | Normal | `<C-w>v` | Split window vertically |
| `<leader>wh` | Normal | `<C-w>s` | Split window horizontally |

### Window Operations
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>wc` | Normal | `<C-w>c` | Close current window |
| `<leader>wo` | Normal | `<C-w>o` | Close all other windows |
| `<leader>we` | Normal | `<C-w>=` | Make all windows equal size |
| `<leader>wr` | Normal | `<C-w>r` | Rotate windows |
| `<leader>wx` | Normal | `<C-w>x` | Exchange current window with next |

> **Note:** Use native `<C-w>` commands for additional operations:
> - `<C-w>+/-` : Resize height
> - `<C-w></>` : Resize width
> - `<C-w>H/J/K/L` : Move window to edge

---

## Text Manipulation

### Indentation (Visual Mode)
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<` | Visual | `<gv` | Decrease indentation and stay in visual mode |
| `>` | Visual | `>gv` | Increase indentation and stay in visual mode |

### Line Movement
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<M-k>` | Normal | `:move .-2<CR>==` | Move current line up (with auto-indent) |
| `<M-j>` | Normal | `:move .+1<CR>==` | Move current line down (with auto-indent) |
| `<M-k>` | Visual | `:move '<-2<CR>gv=gv` | Move selected lines up (with auto-indent) |
| `<M-j>` | Visual | `:move '>+1<CR>gv=gv` | Move selected lines down (with auto-indent) |

### Comments
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-/>` | Normal | `gcc` | Toggle comment on current line |
| `<C-/>` | Visual | `gc` | Toggle comment on selection |
| `gcc` | Normal | Comment.nvim | Toggle comment on current line |
| `gc` | Normal | Comment.nvim | Toggle comment on motion/selection |
| `gbc` | Normal | Comment.nvim | Block comment toggle |
| `gb` | Visual | Comment.nvim | Block comment motion/selection |
| `gcO` | Normal | Comment.nvim | Add comment above current line |
| `gco` | Normal | Comment.nvim | Add comment below current line |
| `gcA` | Normal | Comment.nvim | Add comment at end of current line |

### Copying & Pasting
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>y` | Normal/Visual | `"+y` | Yank to system clipboard |
| `<leader>Y` | Normal | `"+Y` | Yank entire line to system clipboard |
| `p` | Visual | `"_dP` | Paste without overwriting yank register |

### Macro Operations
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Q` | Normal | `@q` | Replay macro 'q' |
| `Q` | Visual | `:normal @q<CR>` | Apply macro 'q' to selection |

---

## Insert Mode Improvements

### Undo Breakpoints
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `,` | Insert | `,<C-g>u` | Insert comma and create undo breakpoint |
| `.` | Insert | `.<C-g>u` | Insert period and create undo breakpoint |
| `;` | Insert | `;<C-g>u` | Insert semicolon and create undo breakpoint |

### LSP Integration
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-Space>` | Insert | `vim.lsp.buf.signature_help` | Show LSP signature help |

---

## File Operations & Finding

### File Explorer
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `-` | Normal | `:Oil` | Open Oil.nvim file explorer |

### Built-in Finding
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>ff` | Normal | `:find **/*` | Find files using built-in find command |
| `<leader>fw` | Normal | `:grep -r "" .` | Find word in files using built-in grep |
| `<leader>fb` | Normal | `:ls<CR>:b<Space>` | Find buffers using ls then b command |

---

## Terminal Operations

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>et` | Normal | `:split \| terminal` | Open terminal in horizontal split |
| `<leader>eT` | Normal | `:vsplit \| terminal` | Open terminal in vertical split |
| `<Esc>` | Terminal | `<C-\><C-n>` | Exit terminal mode to normal mode |

---

## Git Integration

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>gg` | Normal | `:LazyGit` | Open LazyGit interface |

---

## LSP Keymaps
*These keymaps are only available when LSP is attached to the current buffer*

### Navigation
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `gd` | Normal | `vim.lsp.buf.definition` | Go to definition |
| `gD` | Normal | `vim.lsp.buf.declaration` | Go to declaration |
| `gi` | Normal | `vim.lsp.buf.implementation` | Go to implementation |
| `gr` | Normal | `vim.lsp.buf.references` | Go to references |

### Information
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `K` | Normal | `vim.lsp.buf.hover` | Show hover information |
| `<C-Space>` | Insert | `vim.lsp.buf.signature_help` | Show signature help |

---

## Plugin-Specific Keymaps

### Lazy Plugin Manager
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>lz` | Normal | `:Lazy` | Open Lazy plugin manager interface |

### Aerial (Code Outline)
*Buffer-specific when Aerial is active*
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `[a` | Normal | `:AerialPrev` | Go to previous symbol in outline |
| `]a` | Normal | `:AerialNext` | Go to next symbol in outline |

### Trouble (Diagnostics)
*When trouble window is open*
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `q` | Normal | Close | Close trouble window |
| `<CR>` | Normal | Jump | Jump to item under cursor |
| `<Tab>` | Normal | Jump | Jump to item under cursor |
| `<C-x>` | Normal | Split | Open item in horizontal split |
| `<C-v>` | Normal | VSplit | Open item in vertical split |
| `<C-t>` | Normal | Tab | Open item in new tab |
| `o` | Normal | Jump & Close | Jump to item and close trouble |
| `K` | Normal | Hover | Show hover information |
| `r` | Normal | Refresh | Refresh trouble list |
| `m` | Normal | Mode | Toggle trouble mode |
| `s` | Normal | Severity | Switch severity filter |
| `P` | Normal | Preview | Toggle preview |

### Oil.nvim (File Explorer)
*When in Oil buffer*
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<CR>` | Normal | Open | Open file/directory |
| `-` | Normal | Parent | Go to parent directory |
| `_` | Normal | Open cwd | Open current working directory |
| `` ` `` | Normal | Toggle hidden | Show/hide hidden files |
| `g?` | Normal | Help | Show help |
| `<C-h>` | Normal | Toggle hidden | Show/hide hidden files |
| `<C-r>` | Normal | Refresh | Refresh directory listing |

### Blink.cmp (Completion)
*When completion menu is open*
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-Space>` | Insert | Open/Docs | Open completion menu or docs |
| `<C-n>` | Insert | Next | Select next completion item |
| `<C-p>` | Insert | Previous | Select previous completion item |
| `<C-e>` | Insert | Close | Close completion menu |
| `<C-y>` | Insert | Accept | Accept selected completion |
| `<Up>` | Insert | Previous | Select previous completion item |
| `<Down>` | Insert | Next | Select next completion item |

---

## Which-Key Groups

The following prefixes are configured to show organized groups in which-key popup:

| Prefix | Group | Description |
|--------|-------|-------------|
| `<leader>b` | 📁 Buffer Operations | All buffer-related commands |
| `<leader>e` | ⚡ Execute & Terminal | Terminal and execution commands |
| `<leader>f` | 🔍 Find & Search | File finding and searching |
| `<leader>g` | 🌳 Git Operations | Git-related commands |
| `<leader>l` | 📡 LSP & Lazy | LSP and plugin manager commands |
| `<leader>w` | 🪟 Window Management | Window manipulation commands |

---

## Tips

1. **Learning Vim Motions**: This config preserves most native Vim keybindings. Learn the basics: `h/j/k/l`, `w/b/e`, `{/}`, `(/)`

2. **Buffer vs Tab**: This config uses buffers instead of tabs. Use `<Tab>`/`<S-Tab>` or `<leader>1-9` for navigation.

3. **Window Management**: Master `<C-w>` commands for advanced window operations beyond the mapped shortcuts.

4. **LSP Features**: When working with code, `gd` (go to definition) and `gr` (references) are your best friends.

5. **Search and Replace**: Use `/` for search, then `:%s//replacement/gc` for replace with confirmation.

6. **Oil.nvim**: Press `-` to open the file explorer. It behaves like a normal buffer - edit, save, and it applies changes.

---

*Generated from keymaps configuration - last updated: 2025-09-04*