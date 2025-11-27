-- Installation script for LSP tools
print("Starting LSP tools installation...")

-- Wait for plugins to load
vim.wait(2000, function() return false end)

-- Initialize Mason
local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  print("Error: Mason not loaded")
  return
end

local installer_ok, installer = pcall(require, "mason-tool-installer")
if not installer_ok then
  print("Error: mason-tool-installer not loaded")
  return
end

print("Mason and installer loaded successfully")

-- Trigger installation
installer.check_install(true)

print("Installation triggered. Waiting for completion...")

-- Wait for installation
vim.wait(60000, function() return false end)

print("Installation process completed")
