# Neovim IDE Configuration

A lean, modern Neovim IDE configuration built on native Neovim 0.11+ features with minimal external plugins.

## Features

- **Native-First** — Leverages Neovim 0.11+ built-ins: LSP completion, snippet engine, project root, TOC, image paste, zen mode, TODO highlights, git float
- **~15 External Plugins** — Down from 39, with native replacements for 22 removed plugins
- **Language Support** — Python, C/C++, Lua, JavaScript/TypeScript, Markdown, Bash
- **Git Integration** — Gitsigns, native LazyGit float, native git permalink
- **AI Assistance** — CodeCompanion with Ollama (local LLM)
- **Markdown** — Render, preview, navigation, native TOC, native image paste

## Requirements

- **Neovim >= 0.11.0** (built with LuaJIT)
- **Git >= 2.19.0**
- **Nerd Font v3.0+** (recommended: JetBrainsMono Nerd Font)
- **ripgrep** — for grep search
- **fd** — for file finding
- **lazygit** — for git UI float (`<leader>lg`)
- **pngpaste** — for image paste on macOS (`brew install pngpaste`)
- **glow** — for markdown preview (`brew install glow`)
- **Ollama** — optional, for AI assistance

## Installation

### Fresh Machine Setup

```bash
# 1. Install system tools
brew install lua-language-server pyright ruff stylua black isort prettier
# ruff >= 0.5.3 required (runs as native LSP server)
brew install llvm          # clangd + clang-format
brew install cmake         # + pip install cmake-language-server
brew install codelldb      # C/C++ debugger
brew install bash-language-server
brew install ripgrep fd lazygit pngpaste glow

# 2. Backup existing config (if any)
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}

# 3. Clone this repository
git clone https://github.com/Thrilok28021996/personal_nvim.git ~/.config/nvim

# 4. Start Neovim — Lazy.nvim auto-installs plugins
nvim
```

> For tools not installed via brew, open `:Mason` inside Neovim to install them manually.

## File Structure

```
~/.config/nvim/
├── init.lua                      # Entry point
├── lazy-lock.json                # Plugin version lock
├── lua/
│   ├── core/
│   │   ├── options.lua           # Neovim options, autocmds, native features
│   │   ├── keymaps.lua           # All keybindings (single source of truth)
│   │   └── macros.lua            # Pre-defined macros & user commands
│   ├── plugins/
│   │   ├── autoformat.lua        # conform.nvim (formatting)
│   │   ├── codecompanion.lua     # AI assistance (Ollama)
│   │   ├── colorscheme.lua       # Catppuccin theme
│   │   ├── debugging.lua         # nvim-dap (debugging)
│   │   ├── fileexplorer.lua      # oil.nvim (file browser)
│   │   ├── fzf-lua.lua           # Fuzzy finder
│   │   ├── git-signs.lua         # Git decorations
│   │   ├── language.lua          # Native LSP (vim.lsp.config + ruff LSP, no plugin)
│   │   ├── mason.lua             # Tool installer UI (:Mason)
│   │   ├── misc.lua              # Native statusline, tabline, auto-pairs, indent guides
│   │   └── multicursor.lua       # vim-visual-multi
│   └── notemd/
│       ├── mkdnflow.lua          # Markdown navigation & links
│       ├── rendering-markdown.lua # render-markdown.nvim
│       └── tree-sitter.lua       # nvim-treesitter + text objects
└── README.md
```

## Native Features (No Plugins)

These are implemented in `lua/core/options.lua` and `lua/core/keymaps.lua`:

| Feature              | Native Implementation                                  |
| -------------------- | ------------------------------------------------------ |
| LSP Completion       | `vim.lsp.completion.enable()` in LspAttach             |
| Snippets             | `vim.snippet` (Neovim 0.11+)                           |
| Project Root         | `vim.fs.root()` + BufEnter autocmd for auto-cd         |
| TODO Highlighting    | `vim.fn.matchadd()` with BufWinEnter autocmd           |
| Markdown TOC         | `:GenTocGFM` / `:UpdateToc` user commands              |
| Markdown preview     | `glow` CLI in native float (`<leader>mp`)              |
| Image Paste          | `:PasteImage` via `pngpaste` (macOS)                   |
| Task runner          | Native `:make` + `<leader>rr` run current file        |
| Zen Mode             | Save/restore 8 window options (`<leader>tz`)           |
| LazyGit Float        | `nvim_open_win` + `termopen` (`<leader>lg`)            |
| Git Permalink        | Native `git show` + remote URL parsing (`<leader>gy`)  |
| Comment Toggle       | Native `gc` / `gcc` (Neovim 0.10+)                    |
| Statusline           | Custom `vim.o.statusline` with LSP info                |
| Tabline              | Custom `vim.o.tabline` with BufAdd/Delete/Enter caching |
| Auto-pairs           | `InsertCharPre` + `BracketPairs` autocmd               |
| Indent Guides        | `vim.o.listchars` with `leadmultispace`                |

## Keymaps Reference

**Leader key:** `<Space>`

All keymaps are centralized in `lua/core/keymaps.lua` (single source of truth).

### 1. Editor Operations

#### File Operations

| Key     | Mode | Description           |
| ------- | ---- | --------------------- |
| `<C-s>` | n    | Save file             |
| `<C-q>` | n    | Quit Neovim           |
| `x`     | n    | Delete char (no yank) |

#### Selection & Clipboard

| Key         | Mode | Description                         |
| ----------- | ---- | ----------------------------------- |
| `<C-a>`     | n    | Select all                          |
| `gp`        | n    | Select last pasted text             |
| `<leader>y` | n, v | Yank to system clipboard            |
| `<leader>Y` | n    | Yank line to system clipboard       |
| `p`         | x    | Paste without yanking replaced text |

#### Search & Replace

| Key          | Mode | Description                        |
| ------------ | ---- | ---------------------------------- |
| `n` / `N`    | n    | Next/prev search result (centered) |
| `<Esc>`      | n    | Clear search highlight             |
| `<leader>nh` | n    | Clear highlight                    |
| `<leader>sr` | n    | Search & replace word under cursor |
| `<leader>ra` | n    | Replace word under cursor          |
| `<leader>rw` | n    | Remove trailing whitespace         |
| `<leader>rp` | n, v | Replace word in file / selection   |
| `<leader>*`  | n    | Search word in project (quickfix)  |
| `<leader>/`  | n    | Search in project (fuzzy)          |

#### Text Manipulation

| Key                     | Mode | Description                          |
| ----------------------- | ---- | ------------------------------------ |
| `<A-j>` / `<A-k>`       | n    | Move line down / up                  |
| `<leader>ld`            | n, v | Duplicate line / selection           |
| `J` / `K`               | v    | Move lines down / up                 |
| `<` / `>`               | v    | Indent left / right (keep selection) |
| `]<Space>` / `[<Space>` | n    | Insert blank line below / above      |
| `J`                     | n    | Join lines (keep cursor)             |
| `+`                     | n    | Increment number                     |

#### Scrolling

| Key               | Mode | Description                      |
| ----------------- | ---- | -------------------------------- |
| `<C-d>` / `<C-u>` | n    | Half page down / up (centered)   |
| `{` / `}`         | n    | Prev / next paragraph (centered) |

### 2. Navigation

#### Buffers

| Key                 | Mode | Description             |
| ------------------- | ---- | ----------------------- |
| `<Tab>` / `<S-Tab>` | n    | Next / previous buffer  |
| `<leader>bb`        | n    | Alternate buffer        |
| `<leader>bc`        | n    | Close current buffer    |
| `<leader>bC`        | n    | Close all other buffers |

#### Windows

| Key                      | Mode | Description              |
| ------------------------ | ---- | ------------------------ |
| `<C-h/j/k/l>`            | n    | Navigate between windows |
| `<C-Up/Down/Left/Right>` | n    | Resize windows           |
| `<leader>wv`             | n    | Split vertical           |
| `<leader>wh`             | n    | Split horizontal         |
| `<leader>we`             | n    | Equal window sizes       |
| `<leader>wc`             | n    | Close current window     |
| `<leader>wo`             | n    | Close other windows      |
| `<leader>wz`             | n    | Toggle window zoom       |

#### File Navigation

| Key          | Mode | Description                 |
| ------------ | ---- | --------------------------- |
| `-`          | n    | Open parent directory (Oil) |
| `<leader>ff` | n    | Find files (fuzzy)          |
| `<leader>fw` | n    | Find word in files (grep)   |
| `<leader>fb` | n    | Find buffers                |
| `<leader>fr` | n    | Find recent files           |

#### Jumps & Changes

| Key                         | Mode | Description                 |
| --------------------------- | ---- | --------------------------- |
| `<leader>jo` / `<leader>ji` | n    | Jump older / newer position |
| `g;` / `g,`                 | n    | Go to older / newer change  |

#### Marks & Registers

| Key          | Mode | Description               |
| ------------ | ---- | ------------------------- |
| `<leader>'`  | n    | Show all marks            |
| `<leader>M`  | n    | Delete all marks          |
| `dm`         | n    | Delete specific mark      |
| `<leader>"`  | n    | Show all registers        |
| `<leader>R`  | n    | Clear specific register   |
| `<leader>re` | n    | Preview register contents |
| `<leader>rC` | n    | Clear all registers       |

### 3. Code Features

#### Folding

| Key         | Mode | Description                         |
| ----------- | ---- | ----------------------------------- |
| `za` / `zA` | n    | Toggle fold / all folds recursively |
| `zo` / `zO` | n    | Open fold / all recursively         |
| `zc` / `zC` | n    | Close fold / all recursively        |
| `zm` / `zM` | n    | Fold more / close all               |
| `zr` / `zR` | n    | Fold less / open all                |
| `zf`        | v    | Create fold from selection          |
| `zd` / `zE` | n    | Delete fold / eliminate all         |
| `zj` / `zk` | n    | Next / prev fold                    |

#### Diagnostics

| Key          | Mode | Description                |
| ------------ | ---- | -------------------------- |
| `]e` / `[e`  | n    | Next / prev error          |
| `]w` / `[w`  | n    | Next / prev warning        |
| `<leader>de` | n    | Show only errors           |
| `<leader>dw` | n    | Show errors & warnings     |
| `<leader>da` | n    | Show all diagnostics       |
| `<leader>dq` | n    | Diagnostics to quickfix    |
| `<leader>dL` | n    | Diagnostics to loclist     |
| `<leader>xd` | n    | Toggle diagnostics display |

#### Quickfix & Location Lists

| Key          | Mode | Description                |
| ------------ | ---- | -------------------------- |
| `]q` / `[q`  | n    | Next / prev quickfix item  |
| `]Q` / `[Q`  | n    | Last / first quickfix item |
| `]l` / `[l`  | n    | Next / prev loclist item   |
| `<leader>xq` | n    | Toggle quickfix list       |
| `<leader>xl` | n    | Toggle location list       |

#### Spell Checking

| Key          | Mode | Description             |
| ------------ | ---- | ----------------------- |
| `<leader>sz` | n    | Toggle spell check      |
| `]z` / `[z`  | n    | Next / prev misspelling |
| `<leader>z=` | n    | Spell suggestions       |
| `<leader>zg` | n    | Add word to dictionary  |

#### LSP Code Actions & Refactoring

| Key          | Mode | Description           |
| ------------ | ---- | --------------------- |
| `<leader>re` | v    | Extract to function   |
| `<leader>ri` | n    | Inline variable       |
| `<leader>io` | n    | Organize imports      |
| `<leader>ia` | n    | Add missing imports   |
| `<leader>ir` | n    | Remove unused imports |
| `<leader>ev` | v    | Extract variable      |
| `<leader>ec` | v    | Extract constant      |

#### Diff Mode

| Key          | Mode | Description           |
| ------------ | ---- | --------------------- |
| `]c` / `[c`  | n    | Next / prev diff hunk |
| `do` / `dp`  | n    | Diff obtain / put     |
| `<leader>gd` | n    | Enable diff mode      |
| `<leader>gD` | n    | Disable diff mode     |

#### URL & Treesitter

| Key          | Mode | Description                  |
| ------------ | ---- | ---------------------------- |
| `gx`         | n    | Open URL under cursor        |
| `<leader>Ti` | n    | Inspect highlight/treesitter |
| `<leader>TT` | n    | Open treesitter tree         |

### 4. Development Tools

#### Debugging (DAP)

| Key          | Mode | Description            |
| ------------ | ---- | ---------------------- |
| `<leader>db` | n    | Toggle breakpoint      |
| `<leader>dB` | n    | Conditional breakpoint |
| `<leader>dc` | n    | Continue               |
| `<leader>di` | n    | Step into              |
| `<leader>do` | n    | Step over              |
| `<leader>dO` | n    | Step out               |
| `<leader>dr` | n    | Open REPL              |
| `<leader>dl` | n    | Run last               |
| `<leader>dt` | n    | Terminate              |
| `<leader>du` | n    | Toggle debug UI        |

#### Terminal

| Key           | Mode | Description                |
| ------------- | ---- | -------------------------- |
| `<C-t>`       | n    | Open terminal              |
| `<leader>ht`  | n    | Terminal horizontal split  |
| `<leader>vt`  | n    | Terminal vertical split    |
| `<leader>tt`  | n    | Toggle terminal (bottom)   |
| `<Esc>`       | t    | Exit terminal mode         |
| `<C-h/j/k/l>` | t    | Navigate from terminal     |
| `<leader>ts`  | v    | Send selection to terminal |

#### Code Execution

| Key          | Mode | Description                              |
| ------------ | ---- | ---------------------------------------- |
| `<leader>rr` | n    | Run current file (auto-detects language) |

Supports: Python, JavaScript/TypeScript, Lua, Bash, Ruby, Go, Rust, C, C++

#### File Operations

| Key          | Mode | Description                 |
| ------------ | ---- | --------------------------- |
| `<leader>fR` | n    | Rename current file         |
| `<leader>fD` | n    | Delete current file         |
| `<leader>fy` | n    | Copy file path to clipboard |
| `<leader>fn` | n    | Copy file name to clipboard |
| `<leader>fx` | n    | Make file executable        |

#### Language-Specific

| Key          | Mode | Description                            |
| ------------ | ---- | -------------------------------------- |
| `<leader>ch` | n    | C/C++: Toggle header/source            |
| `<leader>dp` | n    | Insert debug print (Python/JS/C++/Lua) |

#### Macros

| Key          | Mode | Description                |
| ------------ | ---- | -------------------------- |
| `<leader>qq` | n    | Record macro to register q |
| `<leader>qw` | n    | Play macro q               |
| `<leader>qe` | n    | Replay last macro          |
| `<leader>qm` | n    | Edit macro                 |

### 5. UI Toggles

| Key          | Mode | Description                         |
| ------------ | ---- | ----------------------------------- |
| `<leader>tn` | n    | Toggle relative numbers             |
| `<leader>tw` | n    | Toggle line wrap                    |
| `<leader>tc` | n    | Toggle conceal                      |
| `<leader>xf` | n    | Toggle format on save               |
| `<leader>tz` | n    | Toggle Zen Mode (native, no plugin) |

### 6. Project

| Key          | Mode | Description                           |
| ------------ | ---- | ------------------------------------- |
| `<leader>pr` | n    | Show project root (`vim.fs.root()`)   |
| `<leader>pc` | n    | CD to project root                    |

Auto-cd triggers on `BufEnter` via `vim.fs.root()` scanning for `.git`, `pyproject.toml`, `package.json`, `Makefile`, `CMakeLists.txt`.

### 7. Plugin Integrations

#### Lazy.nvim (Plugin Manager)

| Key         | Mode | Description              |
| ----------- | ---- | ------------------------ |
| `<leader>L` | n    | Open Lazy plugin manager |

#### Make / Build (native)

| Key          | Mode | Description    |
| ------------ | ---- | -------------- |
| `<leader>om` | n    | Run `:make`    |
| `<leader>ob` | n    | `make build`   |
| `<leader>ot` | n    | `make test`    |

#### Markdown

| Key               | Mode   | Description                            |
| ----------------- | ------ | -------------------------------------- |
| `<leader>mp`      | n      | Markdown: Preview in glow float (`q` to close) |
| `<leader>mi`      | n      | Markdown: Paste image (native pngpaste)|
| `<C-b>`           | v (md) | Bold selection                         |
| `<C-i>`           | v (md) | Italic selection                       |
| `<leader>il`      | n (md) | Insert link                            |
| `<leader>ic`      | n (md) | Insert code block                      |
| `<leader>h1`-`h6` | n (md) | Set heading level                      |
| `<leader>mg`      | n (md) | Generate TOC (native `:GenTocGFM`)     |
| `<leader>mu`      | n (md) | Update TOC (native `:UpdateToc`)       |

#### Snippet Navigation (native vim.snippet)

| Key       | Mode | Description           |
| --------- | ---- | --------------------- |
| `<Tab>`   | i, s | Snippet: Jump next    |
| `<S-Tab>` | i, s | Snippet: Jump prev    |

#### LSP (Buffer-local via LspAttach)

Native completion (`vim.lsp.completion.enable()`), inlay hints, codelens, and semantic tokens auto-enable on LSP attach. Server configs in `lua/plugins/language.lua`.

| Key          | Mode | Description            |
| ------------ | ---- | ---------------------- |
| `gd`         | n    | Go to definition       |
| `gD`         | n    | Go to declaration      |
| `gy`         | n    | Go to type definition  |
| `gO`         | n    | Document symbols       |
| `<leader>dd` | n    | Show diagnostics float |
| `<leader>ql` | n    | Diagnostics to loclist |
| `<leader>ws` | n    | Workspace symbols      |
| `<leader>cI` | n    | Incoming calls         |
| `<leader>co` | n    | Outgoing calls         |
| `<C-k>`      | i    | Signature help         |
| `<leader>ih` | n    | Toggle inlay hints     |
| `<leader>cl` | n    | Run code lens          |
| `<leader>cL` | n    | Refresh code lens      |

#### Git

| Key          | Mode | Description                        |
| ------------ | ---- | ---------------------------------- |
| `<leader>lg` | n    | Open LazyGit (native float)        |
| `<leader>gy` | n, v | Yank git permalink (native)        |
| `]T` / `[T`  | n    | Next / prev TODO (native search)   |
| `<leader>ft` | n    | Search TODOs in project            |

#### CodeCompanion (AI)

| Key          | Mode | Description                          |
| ------------ | ---- | ------------------------------------ |
| `<leader>cc` | n, v | AI: Toggle Chat (sidebar)            |
| `<leader>cn` | n    | AI: New Chat                         |
| `<leader>ca` | n, v | AI: Actions (fzf prompt library)     |
| `<leader>ci` | n, v | AI: Inline Prompt                    |
| `<leader>cx` | v    | AI: Add selection to Chat            |
| `:cc`        | cmd  | Expands to `:CodeCompanion`          |

**Inside the chat buffer:**

| Key     | Description                          |
| ------- | ------------------------------------ |
| `<CR>`  | Send message                         |
| `<C-s>` | Send message (insert mode)           |
| `q`     | Stop current request                 |
| `gx`    | Clear chat buffer                    |
| `gy`    | Yank last codeblock                  |
| `gf`    | Fold all codeblocks                  |
| `gs`    | Toggle system prompt                 |
| `ga`    | Switch adapter                       |
| `[[/]]` | Jump between chat headers            |

**Slash commands (type `/` in chat):**

| Command    | Description                          |
| ---------- | ------------------------------------ |
| `/buffer`  | Include current buffer               |
| `/file`    | Include a file                       |
| `/symbols` | Include treesitter symbols           |
| `/fetch`   | Insert content from URL              |
| `/now`     | Insert current date/time             |
| `/explain` | Explain selected code                |
| `/fix`     | Fix bugs in selection                |
| `/tests`   | Generate unit tests                  |
| `/commit`  | Generate git commit message          |
| `/review`  | Code review                          |
| `/lsp`     | Explain LSP error on cursor          |
| `/doc`     | Add docstring (inline)               |

**Tools (type `@` in chat — agentic mode):**

| Tool              | Description                          |
| ----------------- | ------------------------------------ |
| `@cmd_runner`     | Execute shell commands               |
| `@editor`         | Edit buffer contents                 |
| `@read_file`      | Read file contents                   |
| `@create_file`    | Create new files                     |
| `@grep_search`    | Search file contents                 |
| `@file_search`    | Find files                           |
| `@web_fetch`      | Fetch URL content                    |
| `@full_stack_dev` | All tools combined (full agent)      |

#### Multi-Cursor (vim-visual-multi)

Config (`vim.g.VM_maps`) is in `lua/plugins/multicursor.lua`.

| Key     | Mode | Description                           |
| ------- | ---- | ------------------------------------- |
| `<C-n>` | n    | Select word under cursor (add cursor) |

#### Conform (Autoformat)

| Key          | Mode | Description               |
| ------------ | ---- | ------------------------- |
| `<leader>cf` | n, v | Format buffer / selection |

### 8. Native Neovim 0.11+ Defaults (No Custom Keymaps Needed)

| Key         | Description                |
| ----------- | -------------------------- |
| `grn`       | Rename symbol              |
| `grr`       | Find references            |
| `gri`       | Go to implementation       |
| `gra`       | Code action                |
| `gO`        | Document symbols           |
| `K`         | Hover documentation        |
| `<C-S>`     | Signature help             |
| `[d` / `]d` | Previous / next diagnostic |
| `gc` / `gcc`| Comment (selection / line) |

### 9. Treesitter Text Objects & Motions

Configured in `notemd/tree-sitter.lua`:

| Key                       | Description                 |
| ------------------------- | --------------------------- |
| `]f` / `[f`               | Next / prev function        |
| `]C` / `[C`               | Next / prev class           |
| `]a` / `[a`               | Next / prev parameter       |
| `]l` / `[l`               | Next / prev loop            |
| `]i` / `[i`               | Next / prev conditional     |
| `<leader>a` / `<leader>A` | Swap parameter next / prev  |
| `af` / `if`               | Around / inside function    |
| `ac` / `ic`               | Around / inside class       |
| `as` / `is`               | Around / inside statement   |
| `ai` / `ii`               | Around / inside conditional |
| `al` / `il`               | Around / inside loop        |
| `aa` / `ia`               | Around / inside parameter   |
| `ab` / `ib`               | Around / inside block       |
| `aC` / `iC`               | Around / inside comment     |

## Plugins

### Core IDE

- **lazy.nvim** — Plugin manager
- **Native LSP** — `vim.lsp.config` + `vim.lsp.enable`: pyright, clangd, lua_ls, cmake, ruff (ruff server replaces nvim-lint)
- **mason.nvim** — Tool installer UI (`:Mason`, `cmd`-lazy only)
- **nvim-treesitter** — Syntax highlighting & text objects
- **conform.nvim** — Code formatting
- **nvim-dap** + dap-ui + dap-virtual-text + dap-python — Debugging

### UI & Navigation

- **catppuccin** — Color scheme
- **oil.nvim** — File explorer
- **fzf-lua** — Fuzzy finder

### Git

- **gitsigns.nvim** — Git decorations (hunks, blame, signs)

### Productivity

- **codecompanion.nvim** — AI assistance (Ollama)
- **vim-visual-multi** — Multi-cursor

### Markdown/Notes

- **nvim-treesitter** — Syntax + text objects (shared with IDE)
- **render-markdown.nvim** — In-editor markdown rendering
- **mkdnflow.nvim** — Markdown navigation, links, tables, to-do lists

### Native (No Plugins)

| Feature           | Implementation                                    |
| ----------------- | ------------------------------------------------- |
| LSP Completion    | `vim.lsp.completion.enable()` in LspAttach        |
| Snippets          | `vim.snippet` built-in                            |
| Comment toggle    | Native `gc`/`gcc` (0.10+)                         |
| Project root      | `vim.fs.root()` + BufEnter auto-cd                |
| TODO highlights   | `vim.fn.matchadd()` patterns (BufWinEnter)        |
| Markdown TOC      | `:GenTocGFM` / `:UpdateToc` user commands         |
| Task runner       | Native `:make` (`<leader>om/ob/ot`) + `<leader>rr` |
| Image paste       | `:PasteImage` via `pngpaste` CLI                  |
| Zen mode          | Save/restore window options                       |
| LazyGit float     | `nvim_open_win` + `termopen`                      |
| Git permalink     | Native `git show` + remote URL parsing            |
| Statusline        | `vim.o.statusline` with LSP info                  |
| Tabline           | `vim.o.tabline` with BufAdd/Delete/Enter caching  |
| Auto-pairs        | `InsertCharPre` autocmd                           |
| Indent guides     | `vim.o.listchars` with `leadmultispace`           |

## Pre-defined Macros

26 developer macros in registers a-z (see `lua/core/macros.lua`):

| Register | Action                          |
| -------- | ------------------------------- |
| `@a`     | Add semicolon to end of line    |
| `@b`     | Wrap word in double quotes      |
| `@c`     | Wrap word in single quotes      |
| `@d`     | Wrap word in backticks          |
| `@e`     | Wrap word in parentheses        |
| `@f`     | Wrap word in square brackets    |
| `@g`     | Wrap word in curly braces       |
| `@h`     | Convert snake_case to camelCase |
| `@i`     | Convert camelCase to snake_case |
| `@p`     | Add Python print statement      |
| `@r`     | Add JavaScript console.log      |
| `@s`     | Add C++ std::cout               |
| `@u`     | Uppercase word                  |
| `@v`     | Lowercase word                  |

## Commands

### Markdown

- `:GenTocGFM` — Generate GitHub-flavored TOC at cursor
- `:UpdateToc` — Update existing TOC in file
- `:PasteImage` — Paste image from clipboard (macOS, requires `pngpaste`)

### Build Systems

- `:make` / `<leader>om` — Run make
- `:make build` / `<leader>ob` — Build target
- `:make test` / `<leader>ot` — Test target
- `:Make [target]` — Run make with target
- `:MakeClean` — Clean build

### Language Helpers

- `:PyTypeHint [type]` — Add Python type hint
- `:PyDocstring` — Add Python docstring template
- `:PyDataclass` — Convert to Python dataclass
- `:CppClass [name]` — Create C++ class template
- `:CppNamespace [name]` — Wrap in C++ namespace
- `:CppIncludeGuard` — Add C++ include guard

### Macro Helpers

- `:ShowMacros` — View all recorded macros
- `:SaveMacro [register]` — Save macro for persistence
- `:WrapWith <open> <close>` — Wrap selection
- `:MacroOnPattern <pattern> <register>` — Apply macro to pattern

## Customization

- **Options & Autocmds**: `lua/core/options.lua`
- **Keymaps**: `lua/core/keymaps.lua`
- **LSP Servers**: `lua/plugins/language.lua`
- **Formatters**: `lua/plugins/autoformat.lua`
- **Plugins**: files in `lua/plugins/` and `lua/notemd/`

## Troubleshooting

### Plugin Issues

```vim
:Lazy sync         " Update all plugins
:Lazy clean        " Remove unused plugins
:Lazy restore      " Restore from lazy-lock.json
```

### LSP Issues

```vim
:LspInfo           " Show LSP client info
:Mason             " Open Mason installer (install tools manually)
:checkhealth       " Check Neovim health
```

### Performance

```vim
:Lazy profile      " Show plugin load times
:checkhealth       " Check Neovim health
```

## License

MIT License - Feel free to use and modify.

## Credits

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
