-- Org treesitter parser setup utility
-- This module helps install and configure the org-mode treesitter parser

local M = {}

function M.install_org_parser()
  local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
  
  -- Add org parser configuration from milisims/tree-sitter-org
  parser_config.org = {
    install_info = {
      url = 'https://github.com/milisims/tree-sitter-org',
      revision = 'main',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    filetype = 'org',
  }
  
  print("✓ Org parser configuration added successfully.")
  print("Run ':TSInstall org' to install the parser.")
  print("After installation, restart Neovim to enable org-mode plugins.")
end

function M.check_org_parser()
  local parsers = require('nvim-treesitter.parsers')
  if parsers.has_parser('org') then
    print("✓ Org parser is installed and available")
    print("✓ Org-mode plugins should work properly now")
    return true
  else
    print("✗ Org parser is not installed")
    print("Run ':SetupOrgParser' then ':TSInstall org' to install")
    return false
  end
end

-- Auto-setup function that can be called from init.lua
function M.auto_setup()
  local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
  
  -- Only add configuration if not already present
  if not parser_config.org then
    parser_config.org = {
      install_info = {
        url = 'https://github.com/milisims/tree-sitter-org',
        revision = 'main',
        files = { 'src/parser.c', 'src/scanner.cc' },
      },
      filetype = 'org',
    }
  end
end

return M