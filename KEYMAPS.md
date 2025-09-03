---
id: KEYMAPS
aliases: []
tags: []
---

# Neovim Configuration - Complete Keymap Reference

> **Accurate mapping of all keybindings in this builtin-focused Neovim configuration**

This document contains all keymaps as they actually exist in the configuration. All keymaps use `<Space>` as the leader key and emphasize Neovim's builtin functionality enhanced with essential plugins.

---

## 🚀 Essential Quick Reference

| Keymap      | Action           | Description                    |
| ----------- | ---------------- | ------------------------------ |
| `<Space>`   | Leader Key       | All custom commands start here |
| `<C-s>`     | Save File        | Quick save current file         |
| `<C-q>`     | Quit             | Quick quit                      |
| `<Esc>`     | Clear Highlights | Remove search highlights        |
| `-`         | File Explorer    | Oil.nvim directory editing     |
| `<leader>?` | Show Keymaps     | Display all available keymaps  |

---

## 📁 Buffer Management & Navigation

### Direct Buffer Access
```
<leader>1-9   - Go directly to buffer 1-9 (:1buffer, :2buffer, etc.)
<Tab>         - Next buffer (:bnext)
<S-Tab>       - Previous buffer (:bprevious)
```

### Buffer Operations (<leader>b)
```
<leader>bb    - Go to buffer (interactive :buffer command)
<leader>bd    - Delete current buffer (:bdelete)
<leader>bo    - Close all other buffers
<leader>bn    - Next buffer (:bnext)
<leader>bp    - Previous buffer (:bprevious)
```

---

## 🔍 Find & Search Operations (<leader>f)

### Core File & Search Operations
```
<leader>ff    - Find files by name (builtin :find with wildcards)
<leader>fb    - List all buffers (builtin :buffers)
<leader>fr    - Recent files (builtin :browse oldfiles)
<leader>fw    - Grep in project (builtin :grep with ripgrep)
<leader>fc    - Find in current buffer (builtin /)
<leader>fs    - Search word in current file (builtin /)
<leader>fg    - Grep word under cursor (builtin :grep)
<leader>fh    - Find help topics (builtin :help)
<leader>ft    - Find all TODO comments (builtin :grep)
-             - File explorer (Oil.nvim)
```

### Native Search Commands
```
/             - Search forward in buffer
?             - Search backward in buffer
*             - Search word under cursor forward
#             - Search word under cursor backward
n             - Next search result (centered)
N             - Previous search result (centered)
:noh          - Clear search highlights
```

---

## 🪟 Window Management

### Window Creation & Management (<leader>w)
```
<leader>wv    - Split window vertically (<C-w>v)
<leader>wh    - Split window horizontally (<C-w>s)
<leader>wc    - Close window (<C-w>c)
<leader>wo    - Close all other windows (<C-w>o)
<leader>we    - Make windows equal size (<C-w>=)
<leader>wr    - Rotate windows (<C-w>r)
<leader>wx    - Exchange windows (<C-w>x)
```

### Window Navigation
```
<C-h>         - Move to left window
<C-j>         - Move to down window
<C-k>         - Move to up window
<C-l>         - Move to right window
```

### Native Window Commands (Use <C-w> prefix)
```
<C-w>=        - Make splits equal size
<C-w>c        - Close current split
<C-w>o        - Close all other splits (focus mode)
<C-w>q        - Quit current window
<C-w>+/-      - Resize height
<C-w></>      - Resize width
<C-w>r/R/x    - Rotate/exchange windows
<C-w>H/J/K/L  - Move windows to edges
```

---

## 🛠️ LSP & Code Intelligence

### LSP Navigation (Buffer-local)
```
gd            - Go to definition
gD            - Go to declaration
gi            - Go to implementation
gr            - Go to references
gy            - Go to type definition
K             - Hover documentation
<C-k>         - Signature help (insert mode)
```

### LSP Actions & Operations (<leader>c, <leader>l)
```
<leader>ca    - Code actions
<leader>rn    - Rename symbol
<leader>cf    - Format code (normal & visual)
<leader>df    - Show diagnostic float
<leader>lwa   - Add workspace folder
<leader>lwr   - Remove workspace folder
<leader>lwl   - List workspace folders
<leader>lz    - Open Lazy plugin manager
```

### Diagnostic Navigation
```
]d            - Next diagnostic (buffer-local, centered)
[d            - Previous diagnostic (buffer-local, centered)
]e            - Next error (centered)
[e            - Previous error (centered)
]w            - Next warning (centered)
[w            - Previous warning (centered)
```

---

## 📝 Text Editing & Manipulation

### Enhanced Text Operations
```
<C-u>         - Page up (centered)
<C-a>         - Select all content
x             - Delete character without copying to register
<M-j>         - Move line/selection down
<M-k>         - Move line/selection up
Q             - Replay macro q
```

### Visual Mode Enhancements
```
<             - Left indent (stay in visual mode)
>             - Right indent (stay in visual mode)
p             - Paste without affecting register
```

### System Clipboard
```
<leader>y     - Yank to system clipboard (normal & visual)
<leader>Y     - Yank entire line to system clipboard
```

### Comments (Custom Implementation)
```
gcc           - Toggle comment line
<C-/>         - Toggle comment line
<C-/> (visual) - Toggle comment for selection
```

### Native Text Operations
```
gu/gU/g~      - Change case (lowercase/uppercase/toggle)
J/gJ          - Join lines (with/without spaces)
>>/<< (visual) - Indent/unindent selection
=             - Auto-indent
```

---

## 🌳 Git Operations (<leader>g)

### Git Commands (Builtin Focus)
```
<leader>lg    - LazyGit (external git UI)
<leader>gd    - Git diff (builtin :!git diff)
<leader>gs    - Git status (builtin :!git status)
<leader>gl    - Git log (builtin :!git log --oneline -10)
<leader>gb    - Git blame current file (builtin :!git blame %)
```

### Native Git Commands (Direct Usage)
```
:!git diff         - Show diff
:!git status       - Show status  
:!git log          - Show log
:!git blame %      - Blame current file
:!git add %        - Stage current file
:!git commit       - Make commit
```

---

## 🐛 Debugging (DAP) (<leader>d)

### Debug Control (Function Keys)
```
<F5>          - Start/Continue debugging
<F1>          - Step into
<F2>          - Step over
<F3>          - Step out
<F7>          - Toggle debug UI
```

### Debug Operations
```
<leader>db    - Toggle breakpoint
<leader>B     - Set conditional breakpoint
<leader>dr    - Open REPL
<leader>dl    - Run last debug session
<leader>dh    - Hover variables (normal & visual)
<leader>dp    - Preview variables (normal & visual)
<leader>dF    - Show frames
<leader>ds    - Show scopes
```

---

## 🧪 Testing & Code Navigation (<leader>t)

### Test Execution (Neotest)
```
<leader>tr    - Run nearest test
<leader>tf    - Run file tests
<leader>td    - Debug nearest test
<leader>ts    - Toggle test summary
<leader>to    - Show test output
<leader>tO    - Toggle output panel
<leader>tS    - Stop tests
<leader>tw    - Toggle watch mode
```

### Treesitter Operations
```
<leader>tc    - Toggle Treesitter context
<leader>th    - Show TS highlight groups
<leader>tg    - Toggle TS playground
```

### Treesitter Text Objects & Navigation
```
# Text objects (defined in tree-sitter.lua):
af/if         - Around/inside function
ac/ic         - Around/inside class
aa/ia         - Around/inside parameter
ab/ib         - Around/inside block
al/il         - Around/inside loop
ai/ii         - Around/inside conditional
ak/ik         - Around/inside comment
as/is         - Around/inside statement
ad/id         - Around/inside call
ar/ir         - Around/inside assignment

# Movement between objects:
]f/[f         - Next/previous function start
]c/[c         - Next/previous class start
]a/[a         - Next/previous parameter
]b/[b         - Next/previous block
]l/[l         - Next/previous loop
]i/[i         - Next/previous conditional
]d/[d         - Next/previous call

# Selection expansion:
<C-space>     - Initialize/expand selection
<C-g>         - Expand to scope (changed from <C-s> to avoid conflict)
<C-backspace> - Shrink selection

# Swap operations:
<leader>tsn   - Swap next parameter
<leader>tsf   - Swap next function
<leader>tsp   - Swap previous parameter
<leader>tsF   - Swap previous function
```

### Peek Operations (<leader>p)
```
<leader>pf    - Peek function definition
<leader>pc    - Peek class definition
```

---

## 🔧 Trouble & Diagnostics (<leader>x)

### Trouble Panel Operations
```
<leader>xx    - Toggle Trouble
<leader>xw    - Workspace Diagnostics
<leader>xd    - Document Diagnostics
<leader>xq    - Quickfix List
<leader>xl    - Location List
<leader>xr    - LSP References
```

---

## 🗂️ Aerial Code Outline (<leader>a)

### Aerial Operations
```
<leader>as    - Toggle code outline
<leader>an    - Next symbol
<leader>ap    - Previous symbol
<leader>ao    - Open outline
<leader>ac    - Close outline
<leader>at    - Toggle tree view
{             - Previous symbol (buffer-local when aerial attached)
}             - Next symbol (buffer-local when aerial attached)
```

---

## 📚 Obsidian & Note-Taking (<leader>o)

### Core Obsidian Operations
```
<leader>oo    - Open Obsidian app
<leader>on    - Create new note
<leader>oq    - Quick switch notes
<leader>os    - Search notes
<leader>ot    - Today's note
<leader>oy    - Yesterday's note
<leader>om    - Tomorrow's note
<leader>ob    - Show backlinks
<leader>oL    - Show links
<leader>oT    - Insert template
<leader>op    - Paste image (Obsidian)
<leader>or    - Rename note
<leader>od    - Open daily notes
<leader>ow    - Switch workspace
<leader>oc    - Toggle checkbox
```

### Visual Mode (Obsidian)
```
<leader>ol    - Create link from selection
<leader>oN    - Create new note from selection
```

### Markdown Link Navigation
```
gf            - Follow link under cursor (Obsidian enhanced)
<cr>          - Smart action (follow link or toggle checkbox)
```

---

## 📝 Render & Markdown (<leader>r, <leader>m)

### Render Markdown Operations
```
<leader>rm    - Toggle render markdown
<leader>rM    - Enable render markdown
<leader>rd    - Disable render markdown
```

### Markdown Operations
```
<leader>mp    - Open in external markdown editor
```

### Markdown-Specific (Buffer-local in .md files)
```
<leader>mh    - Add heading (prepend #)
<leader>mH    - Remove heading (remove #)
```

---

## 🖼️ Image Operations (<leader>i)

### Image Handling
```
<leader>ip    - Paste image from system clipboard
```

---

## ⚡ Execute & Terminal (<leader>e)

### Terminal Operations
```
<leader>et    - Open terminal
<Esc>         - Exit terminal mode (when in terminal)
```

---

## 💾 Session & Quit (<leader>q)

### Session Management (Builtin Commands)
```
<leader>qs    - Save session (:mksession! Session.vim)
<leader>ql    - Load session (:source Session.vim)
<leader>qw    - Save all files (:wall)
<leader>qq    - Quit all (:qa)
```

---

## 🚀 Navigation & Utilities

### Quickfix & Lists
```
<C-n>         - Next quickfix item (:cnext)
<C-p>         - Previous quickfix item (:cprev)
]t            - Next TODO comment
[t            - Previous TODO comment
```

### Undo & Breakpoints (Insert Mode)
```
,<C-g>u       - Undo breakpoint at comma (insert mode)
.<C-g>u       - Undo breakpoint at period (insert mode)
;<C-g>u       - Undo breakpoint at semicolon (insert mode)
```

---

## 🏗️ Pure Builtin Commands Reference

### Essential Native Commands (No Plugins Required)
```
:find {pattern}     - Find files recursively (supports wildcards)
:grep {pattern} .   - Search in project with ripgrep
:buffers           - List all open buffers
:buffer {name/num} - Switch to buffer by name or number
:bdelete           - Close current buffer
:bnext/:bprev      - Navigate between buffers
:oldfiles          - Show recently opened files
:help {topic}      - Built-in help system
:map               - Show all current keymaps
:noh               - Clear search highlights
:%s/old/new/gc     - Search and replace with confirmation

# Window Management:
<C-w>hjkl          - Navigate between splits
<C-w>v/<C-w>s      - Create vertical/horizontal splits
<C-w>=             - Make splits equal size
<C-w>c             - Close current split
<C-w>o             - Close all other splits (focus mode)

# Text Operations:
gu/gU/g~           - Change case operations
J/gJ               - Join lines (with/without spaces)
>>/<< (visual)     - Indent/unindent selection
=                  - Auto-indent selected text
```

---

## 🎯 Workflow Examples

### File Navigation Workflow
```
1. <leader>ff     → Find files by name (:find)
2. <leader>fb     → List open buffers (:buffers)
3. <Tab>/<S-Tab>  → Navigate between buffers
4. <leader>1-9    → Jump directly to buffer number
5. <leader>bd     → Close buffer when done
```

### Search & Replace Workflow
```
1. <leader>fw     → Search in project (:grep)
2. *              → Search word under cursor
3. n/N            → Navigate search results
4. :%s/old/new/gc → Replace with confirmation
```

### Code Development Workflow
```
1. <leader>ff     → Open file
2. gd/gr          → Navigate definitions/references
3. <leader>ca     → Code actions
4. <leader>rn     → Rename symbols
5. <leader>cf     → Format code
6. ]d/[d          → Navigate diagnostics
```

---

## 💡 Pro Tips

- Use `<leader>?` to see all available keymaps with which-key
- `*` + `:%s//new/gc` for quick search and replace workflow
- `<C-w>o` for instant focus mode (close all other windows)
- Native `:grep` with ripgrep is faster than many plugin alternatives
- Buffer numbers (`<leader>1-9`) are faster than fuzzy finding for frequent files

---

**Quick Help**: Press `<leader>?` to see all keymaps, or use `:map` for native keymap listing.

---

_Last updated: July 31, 2025 - Complete accuracy with actual keymaps.lua_  
_Configuration: Builtin-focused Neovim with essential plugin enhancements_  
_Total Keymaps: 100+ organized across logical prefixes and modes_