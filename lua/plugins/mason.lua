-- Mason: tool installer UI — loaded only when :Mason is called
-- On a fresh machine, run :Mason and install the tools below,
-- or install via homebrew:
--
--   brew install lua-language-server pyright stylua black isort ruff prettier
--   # ruff >= 0.5.3 required — runs as LSP server (ruff server) replacing nvim-lint
--   brew install llvm          # provides clangd + clang-format
--   brew install cmake         # + pip install cmake-language-server
--   brew install codelldb      # C/C++ debugger
--   brew install bash-language-server  # optional
--
return {
  'williamboman/mason.nvim',
  cmd = 'Mason',
  opts = {
    ui = {
      icons = {
        package_installed   = '✓',
        package_pending     = '➜',
        package_uninstalled = '✗',
      },
    },
  },
}
