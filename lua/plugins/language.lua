-- Pure Native LSP Configuration (Neovim 0.11+)
-- No plugins required - uses vim.lsp.config and vim.lsp.enable

-- ============================================================================
-- LSP Server Configurations
-- ============================================================================

-- Python LSP (Pyright)
vim.lsp.config.pyright = {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
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
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '󰀪',
      [vim.diagnostic.severity.HINT] = '󰌶',
      [vim.diagnostic.severity.INFO] = '󰋽',
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

-- ============================================================================
-- LspAttach Autocmd
-- ============================================================================

-- Create augroup for LSP-related autocmds
local lsp_augroup = vim.api.nvim_create_augroup('UserConfigLSP', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_augroup,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf

    if not client then return end

    -- Native Inlay Hints (Neovim 0.10+)
    if client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = buf })
    end

    -- Custom keymaps (native defaults: grn, grr, gri, gra, gO, K, [d, ]d, <C-S>)
    local opts = { buffer = buf, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, vim.tbl_extend('force', opts, { desc = 'Go to type definition' }))
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'Show diagnostics' }))
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, vim.tbl_extend('force', opts, { desc = 'Diagnostics to loclist' }))

    -- Workspace & Call Hierarchy
    vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, vim.tbl_extend('force', opts, { desc = 'Workspace symbols' }))
    vim.keymap.set('n', '<leader>ci', vim.lsp.buf.incoming_calls, vim.tbl_extend('force', opts, { desc = 'Incoming calls' }))
    vim.keymap.set('n', '<leader>co', vim.lsp.buf.outgoing_calls, vim.tbl_extend('force', opts, { desc = 'Outgoing calls' }))

    -- Document symbols (native 0.11 - gO)
    vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, vim.tbl_extend('force', opts, { desc = 'Document symbols' }))

    -- Signature help in insert mode (native 0.11)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature help' }))

    -- Toggle inlay hints
    vim.keymap.set('n', '<leader>ih', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf }, { bufnr = buf })
    end, vim.tbl_extend('force', opts, { desc = 'Toggle inlay hints' }))

    -- LSP Code Lens (if supported)
    if client:supports_method('textDocument/codeLens') then
      vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, vim.tbl_extend('force', opts, { desc = 'Run code lens' }))
      vim.keymap.set('n', '<leader>cL', vim.lsp.codelens.refresh, vim.tbl_extend('force', opts, { desc = 'Refresh code lens' }))

      -- Auto-refresh code lens on save
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        buffer = buf,
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })
    end

    -- Note: Document highlight is handled by global CursorHold autocmd in keymaps.lua
    -- This avoids duplicate autocmds and improves performance

    -- Semantic Tokens (Neovim 0.11+)
    -- Provides enhanced syntax highlighting beyond treesitter
    -- Shows readonly, deprecated, async modifiers, etc.
    if client:supports_method('textDocument/semanticTokens') then
      vim.lsp.semantic_tokens.start(buf, client.id)
    end
  end,
})

-- ============================================================================
-- Enable LSP servers per filetype
-- ============================================================================

vim.api.nvim_create_autocmd('FileType', {
  group = lsp_augroup,
  pattern = 'python',
  callback = function() vim.lsp.enable('pyright') end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = lsp_augroup,
  pattern = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  callback = function() vim.lsp.enable('clangd') end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = lsp_augroup,
  pattern = 'lua',
  callback = function() vim.lsp.enable('lua_ls') end,
})

-- Return empty table (no plugin needed)
return {}
