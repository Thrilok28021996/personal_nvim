-- Pure Native LSP Configuration (Neovim 0.11+/0.12+)
-- No plugins required - uses vim.lsp.config and vim.lsp.enable

-- ============================================================================
-- LSP Server Configurations
-- ============================================================================

-- Python LSP (Pyright)
vim.lsp.config.pyright = {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'pyrightconfig.json', '.git' },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'basic',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
}

-- C++ LSP (clangd)
vim.lsp.config.clangd = {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
    '--completion-style=detailed',
    '--function-arg-placeholders',
    '--fallback-style=llvm',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    '.git',
  },
  capabilities = {
    offsetEncoding = { 'utf-16' },
  },
}

-- Lua LSP (lua_ls) for Neovim config editing
vim.lsp.config.lua_ls = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      completion = { callSnippet = 'Replace' },
      telemetry = { enable = false },
      hint = { enable = true },
    },
  },
}

-- CMake LSP
vim.lsp.config.cmake = {
  cmd = { 'cmake-language-server' },
  filetypes = { 'cmake' },
  root_markers = { 'CMakeLists.txt', 'cmake', '.git' },
}

-- Ruff LSP (Python linting + import sorting, replaces nvim-lint ruff)
-- Runs alongside pyright: pyright handles types, ruff handles style/linting
-- Requires: ruff >= 0.5.3 (brew install ruff)
vim.lsp.config.ruff = {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  -- Disable capabilities ruff doesn't support, defer to pyright
  capabilities = {
    hoverProvider = false,
  },
  init_options = {
    settings = {
      showSyntaxErrors = true,
    },
  },
}

-- ============================================================================
-- Native Diagnostics Configuration
-- ============================================================================

vim.diagnostic.config {
  virtual_text = {
    prefix = '●',
    source = 'if_many',
    spacing = 4,
    current_line = true, -- 0.11+: only show at cursor line (reduces noise)
  },
  float = {
    border = 'rounded',
    source = true,
    -- 0.12+: DiagnosticRelatedInformation shown in float
    -- gf in diagnostic float jumps to related locations
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '󰀪',
      [vim.diagnostic.severity.HINT] = '󰌶',
      [vim.diagnostic.severity.INFO] = '󰋽',
    },
    -- 0.12 breaking: signs can no longer be configured via :sign-define
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

-- ============================================================================
-- Enable LSP servers
-- ============================================================================
-- LspAttach (keymaps, inlay hints, codelens, document color, linked editing,
-- semantic tokens) is in lua/core/keymaps.lua Section 8.7
--
-- 0.12+: vim.lsp.enable() now starts/stops clients as necessary and detaches
-- non-applicable LSP clients automatically.
-- Use :lsp to interactively manage clients, :checkhealth vim.lsp for status.
-- Code lenses now display as virtual lines (not just virtual text).
vim.lsp.enable({ 'pyright', 'clangd', 'lua_ls', 'cmake', 'ruff' })
