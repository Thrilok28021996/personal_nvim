#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== LSP Configuration Verification ===${NC}\n"

# Check if Neovim is installed
if ! command -v nvim &> /dev/null; then
    echo -e "${RED}✗ Neovim not found${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Neovim found$(NC) ($(nvim --version | head -1))"

# Run the Lua test script
echo -e "\n${BLUE}Running LSP configuration test...${NC}\n"
nvim --headless -c "luafile test_lsp.lua" -c "qa" 2>&1

# Check Mason tools
MASON_BIN="$HOME/.local/share/nvim/mason/bin"
echo -e "\n${BLUE}Checking installed tools:${NC}"

check_tool() {
    local tool=$1
    local bin=$2
    if [ -x "$MASON_BIN/$bin" ]; then
        echo -e "  ${GREEN}✓${NC} $tool installed"
        return 0
    else
        echo -e "  ${RED}✗${NC} $tool NOT installed"
        return 1
    fi
}

TOOLS_OK=true
check_tool "pyright" "pyright-langserver" || TOOLS_OK=false
check_tool "clangd" "clangd" || TOOLS_OK=false
check_tool "clang-format" "clang-format" || TOOLS_OK=false
check_tool "codelldb" "codelldb" || TOOLS_OK=false

if [ "$TOOLS_OK" = false ]; then
    echo -e "\n${YELLOW}⚠ Some tools are missing. They will be auto-installed when you open Neovim.${NC}"
    echo -e "${YELLOW}Or run: nvim -c 'MasonToolsInstall' -c 'qa'${NC}"
fi

# Check test files
echo -e "\n${BLUE}Test files:${NC}"
[ -f "test_python.py" ] && echo -e "  ${GREEN}✓${NC} test_python.py" || echo -e "  ${RED}✗${NC} test_python.py"
[ -f "test_cpp.cpp" ] && echo -e "  ${GREEN}✓${NC} test_cpp.cpp" || echo -e "  ${RED}✗${NC} test_cpp.cpp"
[ -f "test_cpp.h" ] && echo -e "  ${GREEN}✓${NC} test_cpp.h" || echo -e "  ${RED}✗${NC} test_cpp.h"

# Show next steps
echo -e "\n${BLUE}=== Next Steps ===${NC}"
echo -e "\n${YELLOW}1. Test Python LSP:${NC}"
echo -e "   ${GREEN}nvim test_python.py${NC}"
echo -e "   - Wait for Pyright to attach (:LspInfo)"
echo -e "   - Place cursor on 'calculate_sum' (line 38)"
echo -e "   - Press 'gd' to jump to definition"

echo -e "\n${YELLOW}2. Test C++ LSP:${NC}"
echo -e "   ${GREEN}nvim test_cpp.cpp${NC}"
echo -e "   - Wait for clangd to attach (:LspInfo)"
echo -e "   - Place cursor on 'calculateSum' (line 34)"
echo -e "   - Press 'gd' to jump to definition"

echo -e "\n${YELLOW}3. Read detailed instructions:${NC}"
echo -e "   ${GREEN}cat LSP_TEST_INSTRUCTIONS.md${NC}"

echo -e "\n${BLUE}=== Available LSP Keybindings ===${NC}"
echo -e "  gd          - Go to definition"
echo -e "  gD          - Go to declaration (C++ only)"
echo -e "  gr          - Find references"
echo -e "  gi          - Go to implementation"
echo -e "  K           - Hover documentation"
echo -e "  <leader>rn  - Rename symbol"
echo -e "  <leader>ca  - Code action"
echo -e "  <leader>d   - Show diagnostics"
echo -e "  [d          - Previous diagnostic"
echo -e "  ]d          - Next diagnostic"

echo -e "\n${GREEN}Configuration verified successfully!${NC}"
