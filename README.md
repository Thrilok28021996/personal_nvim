# Neovim IDE Configuration

A complete, modern Neovim IDE configuration with native features and minimal plugins.

## Features

- **170+ Essential IDE Features** - Complete development environment
- **Native-First Approach** - Leverages Neovim 0.11+ built-in features
- **Language Support** - Python, C++, Lua, JavaScript, Markdown, and more
- **Git Integration** - Built-in lazygit, gitsigns, GitHub (Octo)
- **AI Assistance** - Avante.nvim integration
- **Note-Taking** - Full markdown/Obsidian support
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
│   │   ├── options.lua         # Neovim options
│   │   ├── keymaps.lua         # All keybindings
│   │   └── macros.lua          # Pre-defined macros & commands
│   ├── plugins/                # Plugin configurations
│   │   ├── autocompletion.lua  # Blink.cmp (completion)
│   │   ├── autoformat.lua      # Conform.nvim (formatting)
│   │   ├── avante.lua          # AI assistance
│   │   ├── colorscheme.lua     # Catppuccin theme
│   │   ├── debugging.lua       # DAP (debugging)
│   │   ├── fileexplorer.lua    # Oil.nvim (file browser)
│   │   ├── git-signs.lua       # Git integration
│   │   ├── language.lua        # LSP configuration
│   │   ├── lazygit.lua         # LazyGit integration
│   │   ├── linting.lua         # nvim-lint
│   │   ├── mason.lua           # LSP/formatter installer
│   │   ├── misc.lua            # Native features (statusline, tabline, auto-pairs)
│   │   ├── multicursor.lua     # vim-visual-multi
│   │   ├── octo.lua            # GitHub integration
│   │   ├── project.lua         # Project management
│   │   ├── search-replace.lua  # Search/replace UI
│   │   ├── symbols.lua         # Aerial (symbol outline)
│   │   ├── tasks.lua           # Task runner
│   │   ├── testing.lua         # Neotest (testing framework)
│   │   ├── todo-comments.lua   # TODO highlighting
│   │   ├── undotree.lua        # Undo tree visualization
│   │   └── which-key.lua       # Keymap help
│   └── notemd/                 # Note-taking plugins
│       ├── img-clip.lua        # Image pasting
│       ├── markdown-preview.lua # Live preview
│       ├── markdown-toc.lua    # TOC generation
│       ├── mkdnflow.lua        # Markdown navigation
│       ├── rendering-markdown.lua # Markdown rendering
│       ├── tree-sitter.lua     # Syntax highlighting
│       └── zen-mode.lua        # Distraction-free writing
└── README.md                   # This file
```

## Essential Keymaps

**Leader key:** `<Space>`

### File Operations
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Browse buffers
- `<leader>e` - Toggle file explorer
- `<leader>w` - Save file
- `<leader>q` - Quit

### Buffer/Window Management
- `<Tab>` / `<S-Tab>` - Next/previous buffer
- `<leader>bc` - Close current buffer
- `<leader>bC` - Close other buffers
- `<leader>v` - Split vertical
- `<leader>wh` - Split horizontal
- `<C-h/j/k/l>` - Navigate windows

### LSP & Code
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>f` - Format document
- `[d` / `]d` - Next/prev diagnostic

### Git
- `<leader>gg` - LazyGit
- `<leader>gb` - Git blame
- `<leader>gp` - Git preview hunk
- `<leader>gs` - Git stage hunk
- `<leader>gr` - Git reset hunk

### Search & Replace
- `<leader>sr` - Search and replace
- `/` - Search forward
- `?` - Search backward
- `*` - Search word under cursor

### Utilities
- `<leader>u` - Undo tree
- `<leader>xx` - Toggle diagnostics
- `<leader>?` - Show all keymaps
- `<C-d>` - Multi-cursor (select word)

### Terminal
- `<C-\>` - Toggle terminal
- `<C-t>` - New terminal tab

### AI Assistant (Avante)
- `<leader>aa` - Ask AI
- `<leader>ae` - Edit with AI
- `<leader>ar` - Refresh AI

## Plugins

### Core IDE Features
- **lazy.nvim** - Plugin manager
- **nvim-lspconfig** - LSP client
- **mason.nvim** - LSP/tool installer
- **nvim-treesitter** - Syntax highlighting
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

### Git Integration
- **gitsigns.nvim** - Git decorations
- **lazygit.nvim** - LazyGit UI
- **octo.nvim** - GitHub integration

### Productivity
- **todo-comments.nvim** - TODO highlighting
- **neotest** - Testing framework
- **overseer.nvim** - Task runner
- **project.nvim** - Project management
- **avante.nvim** - AI assistance

### Markdown/Notes
- **render-markdown.nvim** - Markdown rendering
- **peek.nvim** - Markdown preview
- **mkdnflow.nvim** - Markdown navigation
- **img-clip.nvim** - Image pasting
- **markdown-toc.nvim** - TOC generation
- **zen-mode.nvim** - Distraction-free

### Native Features (No Plugins)
- **Statusline** - Custom native statusline with LSP info
- **Tabline** - Native buffer tabline
- **Auto-pairs** - Native bracket pairing
- **Indent guides** - Native indent visualization

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

## Pre-defined Macros

26 developer macros available in registers a-z:
- `@a` - Add semicolon to end of line
- `@b` - Wrap word in double quotes
- `@c` - Wrap word in single quotes
- `@d` - Wrap word in backticks
- `@e` - Wrap word in parentheses
- `@f` - Wrap word in square brackets
- `@g` - Wrap word in curly braces
- `@h` - Convert snake_case to camelCase
- `@i` - Convert camelCase to snake_case
- `@p` - Add Python print statement
- `@r` - Add JavaScript console.log
- `@s` - Add C++ std::cout
- `@u` - Uppercase word
- `@v` - Lowercase word
- See `lua/core/macros.lua` for full list

## Customization

- **Options**: Edit `lua/core/options.lua`
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
