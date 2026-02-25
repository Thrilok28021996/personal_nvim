# Neovim IDE Configuration

A complete, modern Neovim IDE configuration with native features and minimal plugins.

## Features

- **180+ Keymaps** - Complete development environment
- **Native-First Approach** - Leverages Neovim 0.11+ built-in features
- **Language Support** - Python, C++, Lua, JavaScript, Markdown, and more
- **Git Integration** - LazyGit, gitsigns, gitlinker
- **AI Assistance** - CodeCompanion with Ollama (local LLM)
- **Note-Taking** - Full markdown support with preview, TOC, image pasting
- **Performance** - Fast startup, minimal bloat

## Requirements

- **Neovim >= 0.11.0** (built with LuaJIT)
- **Git >= 2.19.0**
- **Nerd Font v3.0+** (recommended: JetBrainsMono Nerd Font)
- **Node.js** (for LSP servers)
- **Python 3.8+** (for Python LSP)
- **ripgrep** (for search)
- **fd** (for file finding)
- **lazygit** (optional, for git UI)
- **Ollama** (optional, for AI assistance)

## Installation

### Clean Install

```bash
# Backup existing config
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

# Clone this repository
git clone https://github.com/Thrilok28021996/personal_nvim.git ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

### First Launch

On first launch, Lazy.nvim will automatically install all plugins. Wait for installation to complete, then restart Neovim.

## File Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lazy-lock.json              # Plugin version lock
├── lua/
│   ├── core/
│   │   ├── options.lua         # Neovim options & autocmds
│   │   ├── keymaps.lua         # All keybindings (single source of truth)
│   │   └── macros.lua          # Pre-defined macros & commands
│   ├── plugins/
│   │   ├── autocompletion.lua  # Blink.cmp (completion)
│   │   ├── autoformat.lua      # Conform.nvim (formatting)
│   │   ├── codecompanion.lua   # AI assistance (Ollama)
│   │   ├── colorscheme.lua     # Catppuccin theme
│   │   ├── comments.lua        # Comment toggling
│   │   ├── debugging.lua       # DAP (debugging)
│   │   ├── fileexplorer.lua    # Oil.nvim (file browser)
│   │   ├── git-signs.lua       # Git decorations
│   │   ├── gitlinker.lua       # Git permalink/blame links
│   │   ├── language.lua        # Native LSP configuration (no plugin)
│   │   ├── lazygit.lua         # LazyGit integration
│   │   ├── linting.lua         # nvim-lint
│   │   ├── mason.lua           # LSP/formatter installer
│   │   ├── misc.lua            # Native features (statusline, tabline, auto-pairs)
│   │   ├── multicursor.lua     # vim-visual-multi
│   │   ├── project.lua         # Project management
│   │   ├── search-replace.lua  # Search/replace UI (Spectre)
│   │   ├── symbols.lua         # Aerial (symbol outline)
│   │   ├── tasks.lua           # Overseer (task runner)
│   │   ├── testing.lua         # Neotest (testing framework)
│   │   ├── todo-comments.lua   # TODO highlighting
│   │   ├── undotree.lua        # Undo tree visualization
│   │   └── which-key.lua       # Keymap help
│   └── notemd/
│       ├── img-clip.lua        # Image pasting
│       ├── markdown-preview.lua # Live preview (Peek)
│       ├── markdown-toc.lua    # TOC generation
│       ├── mkdnflow.lua        # Markdown navigation
│       ├── rendering-markdown.lua # Markdown rendering
│       ├── tree-sitter.lua     # Syntax highlighting & text objects
│       └── zen-mode.lua        # Distraction-free writing
└── README.md
```

## Keymaps Reference

**Leader key:** `<Space>`

All keymaps are centralized in `lua/core/keymaps.lua` (single source of truth).

### 1. Editor Operations

#### File Operations
| Key | Mode | Description |
|-----|------|-------------|
| `<C-s>` | n | Save file |
| `<C-q>` | n | Quit Neovim |
| `x` | n | Delete char (no yank) |

#### Selection & Clipboard
| Key | Mode | Description |
|-----|------|-------------|
| `<C-a>` | n | Select all |
| `gp` | n | Select last pasted text |
| `<leader>y` | n, v | Yank to system clipboard |
| `<leader>Y` | n | Yank line to system clipboard |
| `p` | x | Paste without yanking replaced text |

#### Search & Replace
| Key | Mode | Description |
|-----|------|-------------|
| `n` / `N` | n | Next/prev search result (centered) |
| `<Esc>` | n | Clear search highlight |
| `<leader>nh` | n | Clear highlight |
| `<leader>sr` | n | Search & replace (interactive) |
| `<leader>ra` | n | Replace word under cursor |
| `<leader>rw` | n | Remove trailing whitespace |
| `<leader>rp` | n, v | Replace word in file / selection |
| `<leader>*` | n | Search word in project (quickfix) |
| `<leader>/` | n | Search in project (fuzzy) |

#### Text Manipulation
| Key | Mode | Description |
|-----|------|-------------|
| `<A-j>` / `<A-k>` | n | Move line down / up |
| `<leader>ld` | n, v | Duplicate line / selection |
| `J` / `K` | v | Move lines down / up |
| `<` / `>` | v | Indent left / right (keep selection) |
| `]<Space>` / `[<Space>` | n | Insert blank line below / above |
| `J` | n | Join lines (keep cursor) |
| `+` | n | Increment number |

#### Comments
| Key | Mode | Description |
|-----|------|-------------|
| `<C-/>` | n | Toggle comment (line) |
| `<C-/>` | v | Toggle comment (selection) |
| `<leader>cb` | n | Create comment box |

#### Visual Block & Alignment
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>vb` | n | Enter visual block mode |
| `<leader>al` / `<leader>ac` / `<leader>ar` | v | Align left / center / right |

#### Scrolling
| Key | Mode | Description |
|-----|------|-------------|
| `<C-d>` / `<C-u>` | n | Half page down / up (centered) |
| `{` / `}` | n | Prev / next paragraph (centered) |

### 2. Navigation

#### Buffers
| Key | Mode | Description |
|-----|------|-------------|
| `<Tab>` / `<S-Tab>` | n | Next / previous buffer |
| `<leader>bb` | n | Alternate buffer |
| `<leader>bc` | n | Close current buffer |
| `<leader>bC` | n | Close all other buffers |

#### Windows
| Key | Mode | Description |
|-----|------|-------------|
| `<C-h/j/k/l>` | n | Navigate between windows |
| `<C-Up/Down/Left/Right>` | n | Resize windows |
| `<leader>wv` | n | Split vertical |
| `<leader>wh` | n | Split horizontal |
| `<leader>we` | n | Equal window sizes |
| `<leader>wc` | n | Close current window |
| `<leader>wo` | n | Close other windows |
| `<leader>wz` | n | Toggle window zoom |

#### File Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `-` | n | Open parent directory (Oil) |
| `<leader>ff` | n | Find files (fuzzy) |
| `<leader>fw` | n | Find word in files (grep) |
| `<leader>fb` | n | Find buffers |
| `<leader>fr` | n | Find recent files |

#### Jumps & Changes
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>jo` / `<leader>ji` | n | Jump older / newer position |
| `g;` / `g,` | n | Go to older / newer change |

#### Marks & Registers
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>'` | n | Show all marks |
| `<leader>M` | n | Delete all marks |
| `dm` | n | Delete specific mark |
| `<leader>"` | n | Show all registers |
| `<leader>R` | n | Clear specific register |
| `<leader>re` | n | Preview register contents |
| `<leader>rC` | n | Clear all registers |

### 3. Code Features

#### Folding
| Key | Mode | Description |
|-----|------|-------------|
| `za` / `zA` | n | Toggle fold / all folds recursively |
| `zo` / `zO` | n | Open fold / all recursively |
| `zc` / `zC` | n | Close fold / all recursively |
| `zm` / `zM` | n | Fold more / close all |
| `zr` / `zR` | n | Fold less / open all |
| `zf` | v | Create fold from selection |
| `zd` / `zE` | n | Delete fold / eliminate all |
| `zj` / `zk` | n | Next / prev fold |

#### Diagnostics
| Key | Mode | Description |
|-----|------|-------------|
| `]e` / `[e` | n | Next / prev error |
| `]w` / `[w` | n | Next / prev warning |
| `<leader>de` | n | Show only errors |
| `<leader>dw` | n | Show errors & warnings |
| `<leader>da` | n | Show all diagnostics |
| `<leader>dq` | n | Diagnostics to quickfix |
| `<leader>dL` | n | Diagnostics to loclist |
| `<leader>xd` | n | Toggle diagnostics display |

#### Quickfix & Location Lists
| Key | Mode | Description |
|-----|------|-------------|
| `]q` / `[q` | n | Next / prev quickfix item |
| `]Q` / `[Q` | n | Last / first quickfix item |
| `]l` / `[l` | n | Next / prev loclist item |
| `<leader>xq` | n | Toggle quickfix list |
| `<leader>xl` | n | Toggle location list |

#### Spell Checking
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sz` | n | Toggle spell check |
| `]z` / `[z` | n | Next / prev misspelling |
| `<leader>z=` | n | Spell suggestions |
| `<leader>zg` | n | Add word to dictionary |

#### LSP Code Actions & Refactoring
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>re` | v | Extract to function |
| `<leader>ri` | n | Inline variable |
| `<leader>io` | n | Organize imports |
| `<leader>ia` | n | Add missing imports |
| `<leader>ir` | n | Remove unused imports |
| `<leader>ev` | v | Extract variable |
| `<leader>ec` | v | Extract constant |

#### Diff Mode
| Key | Mode | Description |
|-----|------|-------------|
| `]c` / `[c` | n | Next / prev diff hunk |
| `do` / `dp` | n | Diff obtain / put |
| `<leader>gd` | n | Enable diff mode |
| `<leader>gD` | n | Disable diff mode |

#### URL & Treesitter
| Key | Mode | Description |
|-----|------|-------------|
| `gx` | n | Open URL under cursor |
| `<leader>Ti` | n | Inspect highlight/treesitter |
| `<leader>TT` | n | Open treesitter tree |

### 4. Development Tools

#### Testing (Neotest)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>tr` | n | Test: Run nearest |
| `<leader>tf` | n | Test: Run file |
| `<leader>ta` | n | Test: Run all |
| `<leader>ts` | n | Test: Toggle summary |
| `<leader>to` | n | Test: View output |
| `<leader>tp` | n | Test: Toggle panel |
| `<leader>tS` | n | Test: Stop |
| `<leader>td` | n | Test: Debug (DAP) |
| `]t` / `[t` | n | Next / prev failed test |

#### Debugging (DAP)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dB` | n | Conditional breakpoint |
| `<leader>dc` | n | Continue |
| `<leader>di` | n | Step into |
| `<leader>do` | n | Step over |
| `<leader>dO` | n | Step out |
| `<leader>dr` | n | Open REPL |
| `<leader>dl` | n | Run last |
| `<leader>dt` | n | Terminate |
| `<leader>du` | n | Toggle debug UI |

#### Terminal
| Key | Mode | Description |
|-----|------|-------------|
| `<C-t>` | n | Open terminal |
| `<leader>ht` | n | Terminal horizontal split |
| `<leader>vt` | n | Terminal vertical split |
| `<leader>tt` | n | Toggle terminal (bottom) |
| `<Esc>` | t | Exit terminal mode |
| `<C-h/j/k/l>` | t | Navigate from terminal |
| `<leader>ts` | v | Send selection to terminal |

#### Code Execution
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>rr` | n | Run current file (auto-detects language) |

Supports: Python, JavaScript/TypeScript, Lua, Bash, Ruby, Go, Rust, C, C++

#### File Operations
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>fR` | n | Rename current file |
| `<leader>fD` | n | Delete current file |
| `<leader>fy` | n | Copy file path to clipboard |
| `<leader>fn` | n | Copy file name to clipboard |
| `<leader>fx` | n | Make file executable |

#### Language-Specific
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ch` | n | C/C++: Toggle header/source |
| `<leader>dp` | n | Insert debug print (Python/JS/C++/Lua) |

#### Macros
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>qq` | n | Record macro to register q |
| `<leader>qw` | n | Play macro q |
| `<leader>qe` | n | Replay last macro |
| `<leader>qm` | n | Edit macro |

### 5. UI Toggles

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>tn` | n | Toggle relative numbers |
| `<leader>tw` | n | Toggle line wrap |
| `<leader>tc` | n | Toggle conceal |
| `<leader>xf` | n | Toggle format on save |
| `<leader>tz` | n | Toggle Zen Mode |

### 6. Sessions & Projects

#### Sessions
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ss` | n | Save session |
| `<leader>sl` | n | Load session |
| `<leader>sd` | n | Delete session |
| `<leader>sS` | n | Save named session |
| `<leader>sL` | n | Load session from list |

#### Projects
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>fp` | n | Find projects |
| `<leader>pr` | n | Show project root |
| `<leader>pc` | n | CD to project root |

### 7. Plugin Integrations

#### Lazy.nvim (Plugin Manager)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>L` | n | Open Lazy plugin manager |

#### Aerial (Code Outline)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cs` | n | Toggle code outline |
| `<leader>cS` | n | Toggle aerial navigation |
| `[s` / `]s` | n | Prev / next symbol |

#### Overseer (Task Runner)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ot` | n | Task: Toggle |
| `<leader>or` | n | Task: Run |
| `<leader>oo` | n | Task: Open |
| `<leader>oq` | n | Task: Quick action |
| `<leader>ob` | n | Task: Build |

#### Spectre (Search & Replace)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>S` | n | Toggle Spectre |
| `<leader>sw` | n, v | Search word / selection with Spectre |
| `<leader>sp` | n | Search in current file |

#### Markdown
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>mp` | n | Markdown: Preview open |
| `<leader>mc` | n | Markdown: Preview close |
| `<leader>mi` | n | Markdown: Paste image |
| `<C-b>` | v (md) | Bold selection |
| `<C-i>` | v (md) | Italic selection |
| `<leader>il` | n (md) | Insert link |
| `<leader>ic` | n (md) | Insert code block |
| `<leader>h1`-`h6` | n (md) | Set heading level |
| `<leader>mg` | n (md) | Generate TOC |
| `<leader>mu` | n (md) | Update TOC |

#### Snippet Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `<Tab>` | i, s | Snippet: Jump next (or Tab) |
| `<S-Tab>` | i, s | Snippet: Jump prev (or S-Tab) |

#### LSP (Buffer-local via LspAttach)

Inlay hints auto-enable, codelens auto-refreshes, and semantic tokens start
automatically when a capable LSP server attaches. Server configs and
diagnostics are in `lua/plugins/language.lua`.

| Key | Mode | Description |
|-----|------|-------------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gy` | n | Go to type definition |
| `gO` | n | Document symbols |
| `<leader>dd` | n | Show diagnostics float |
| `<leader>ql` | n | Diagnostics to loclist |
| `<leader>ws` | n | Workspace symbols |
| `<leader>cI` | n | Incoming calls |
| `<leader>co` | n | Outgoing calls |
| `<C-k>` | i | Signature help |
| `<leader>ih` | n | Toggle inlay hints |
| `<leader>cl` | n | Run code lens |
| `<leader>cL` | n | Refresh code lens |

#### CodeCompanion (AI)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cc` | n, v | AI: Toggle Chat |
| `<leader>ca` | n, v | AI: Actions |
| `<leader>ci` | n, v | AI: Inline Prompt |
| `<leader>cx` | v | AI: Add to Chat |
| `:cc` | cmd | Expands to `:CodeCompanion` |

#### LazyGit
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>lg` | n | Open LazyGit |

#### Undotree
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>u` | n | Toggle Undotree |

#### gitlinker
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gy` | n, v | Yank git permalink |
| `<leader>gY` | n, v | Open git permalink |
| `<leader>gb` | n, v | Yank git blame link |
| `<leader>gB` | n, v | Open git blame |

#### TODO Comments
| Key | Mode | Description |
|-----|------|-------------|
| `]T` / `[T` | n | Next / prev TODO |
| `<leader>ft` | n | TODOs to quickfix |

#### Conform (Autoformat)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cf` | n, v | Format buffer / selection |

#### Which-Key
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>?` | n | Buffer local keymaps |

#### Multi-Cursor (vim-visual-multi)

Config (`vim.g.VM_maps`) is in `lua/plugins/multicursor.lua`.

| Key | Mode | Description |
|-----|------|-------------|
| `<C-n>` | n | Select word under cursor (add cursor) |

### 8. Native Neovim 0.11+ Defaults (No Custom Keymaps Needed)

These are built-in and work automatically:

| Key | Description |
|-----|-------------|
| `grn` | Rename symbol |
| `grr` | Find references |
| `gri` | Go to implementation |
| `gra` | Code action |
| `gO` | Document symbols |
| `K` | Hover documentation |
| `<C-S>` | Signature help |
| `[d` / `]d` | Previous / next diagnostic |

### 9. Treesitter Text Objects & Motions

Configured in `notemd/tree-sitter.lua`:

| Key | Description |
|-----|-------------|
| `]f` / `[f` | Next / prev function |
| `]C` / `[C` | Next / prev class |
| `]a` / `[a` | Next / prev parameter |
| `]l` / `[l` | Next / prev loop |
| `]i` / `[i` | Next / prev conditional |
| `<leader>a` / `<leader>A` | Swap parameter next / prev |
| `af` / `if` | Around / inside function |
| `ac` / `ic` | Around / inside class |
| `as` / `is` | Around / inside statement |
| `ai` / `ii` | Around / inside conditional |
| `al` / `il` | Around / inside loop |
| `aa` / `ia` | Around / inside parameter |
| `ab` / `ib` | Around / inside block |
| `aC` / `iC` | Around / inside comment |

### Which-Key Groups

| Prefix | Group |
|--------|-------|
| `<leader>b` | Buffer |
| `<leader>c` | Code/AI |
| `<leader>d` | Diagnostics/Debug |
| `<leader>f` | Find/File |
| `<leader>g` | Git/Diff |
| `<leader>h` | Help |
| `<leader>i` | Imports |
| `<leader>j` | Jump |
| `<leader>l` | Line/LazyGit |
| `<leader>m` | Markdown |
| `<leader>o` | Overseer |
| `<leader>p` | Project |
| `<leader>q` | Macro |
| `<leader>r` | Replace/Run |
| `<leader>s` | Session/Search |
| `<leader>t` | Toggle/Test/Terminal |
| `<leader>v` | Visual/Terminal |
| `<leader>w` | Window/Split |
| `<leader>x` | Diagnostics/Quickfix |

## Plugins

### Core IDE
- **lazy.nvim** - Plugin manager
- **Native LSP** - Built-in `vim.lsp.config` (no plugin needed)
- **mason.nvim** - LSP/tool installer
- **nvim-treesitter** - Syntax highlighting & text objects
- **blink.cmp** - Auto-completion
- **conform.nvim** - Code formatting
- **nvim-lint** - Linting
- **nvim-dap** - Debugging

### UI & Navigation
- **catppuccin** - Color scheme
- **which-key.nvim** - Keymap helper
- **oil.nvim** - File explorer
- **aerial.nvim** - Symbol outline
- **undotree** - Undo history
- **vim-visual-multi** - Multi-cursor

### Git
- **gitsigns.nvim** - Git decorations
- **lazygit.nvim** - LazyGit UI
- **gitlinker.nvim** - Git permalink & blame links

### Productivity
- **todo-comments.nvim** - TODO highlighting
- **overseer.nvim** - Task runner
- **project.nvim** - Project management
- **nvim-spectre** - Search & replace UI
- **codecompanion.nvim** - AI assistance (Ollama)

### Markdown/Notes
- **render-markdown.nvim** - Markdown rendering
- **peek.nvim** - Markdown preview
- **mkdnflow.nvim** - Markdown navigation
- **img-clip.nvim** - Image pasting
- **markdown-toc.nvim** - TOC generation
- **zen-mode.nvim** - Distraction-free writing
- **twilight.nvim** - Focus dimming

### Native Features (No Plugins)
- **Statusline** - Custom native statusline with LSP info
- **Tabline** - Native buffer tabline
- **Auto-pairs** - Native bracket pairing
- **Indent guides** - Native indent visualization

## Pre-defined Macros

26 developer macros available in registers a-z (see `lua/core/macros.lua`):

| Register | Action |
|----------|--------|
| `@a` | Add semicolon to end of line |
| `@b` | Wrap word in double quotes |
| `@c` | Wrap word in single quotes |
| `@d` | Wrap word in backticks |
| `@e` | Wrap word in parentheses |
| `@f` | Wrap word in square brackets |
| `@g` | Wrap word in curly braces |
| `@h` | Convert snake_case to camelCase |
| `@i` | Convert camelCase to snake_case |
| `@p` | Add Python print statement |
| `@r` | Add JavaScript console.log |
| `@s` | Add C++ std::cout |
| `@u` | Uppercase word |
| `@v` | Lowercase word |

## Commands

### Build Systems
- `:CMakeConfigure` - Configure CMake project
- `:CMakeBuild` - Build CMake project
- `:CMakeRun` - Configure, build, and run
- `:Make [target]` - Run make
- `:MakeClean` - Clean build

### Language Helpers
- `:PyTypeHint [type]` - Add Python type hint
- `:PyDocstring` - Add Python docstring template
- `:PyDataclass` - Convert to Python dataclass
- `:CppClass [name]` - Create C++ class template
- `:CppNamespace [name]` - Wrap in C++ namespace
- `:CppIncludeGuard` - Add C++ include guard

### Macro Helpers
- `:ShowMacros` - View all recorded macros
- `:SaveMacro [register]` - Save macro for persistence
- `:WrapWith <open> <close>` - Wrap selection
- `:MacroOnPattern <pattern> <register>` - Apply macro to pattern

## Customization

- **Options & Autocmds**: Edit `lua/core/options.lua`
- **Keymaps**: Edit `lua/core/keymaps.lua`
- **Plugins**: Add/modify files in `lua/plugins/`
- **LSP Servers**: Configure in `lua/plugins/language.lua`
- **Formatters**: Configure in `lua/plugins/autoformat.lua`

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
:Mason             " Open Mason installer
:MasonUpdate       " Update Mason registries
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
