# Plugin Config Audit Design

**Date:** 2026-06-07  
**Scope:** Full audit of all 19 plugins against current official docs  
**Files touched:** `init.lua`, `lua/plugins/misc.lua`, `lua/plugins/language.lua`

## Goal

Update every plugin configuration in the neovim config to match the current official documentation. No new plugins. No structural changes. Surgical updates only.

## Plugins in Scope

| Plugin | Config location |
|--------|----------------|
| catppuccin/nvim | init.lua |
| stevearc/oil.nvim | init.lua |
| mg979/vim-visual-multi | init.lua |
| nvim-treesitter/nvim-treesitter | init.lua |
| nvim-treesitter/nvim-treesitter-textobjects | init.lua |
| lewis6991/gitsigns.nvim | init.lua |
| stevearc/conform.nvim | init.lua |
| MeanderingProgrammer/render-markdown.nvim | init.lua |
| jakewvincent/mkdnflow.nvim | init.lua |
| williamboman/mason.nvim | init.lua |
| ibhagwan/fzf-lua | init.lua |
| milanglacier/minuet-ai.nvim | init.lua |
| nvim-lua/plenary.nvim | init.lua (dep only) |
| olimorris/codecompanion.nvim | init.lua |
| nvim-neotest/nvim-nio | init.lua (dep only) |
| rcarriga/nvim-dap-ui | init.lua |
| theHamsta/nvim-dap-virtual-text | init.lua |
| mfussenegger/nvim-dap-python | init.lua |
| mfussenegger/nvim-dap | init.lua |

## Phases

### 1. Doc Fetch
Use context7 to retrieve official docs for each plugin. Plugins not indexed in context7 are marked "no doc available" — those configs are left as-is unless a known issue is identified from the codebase.

### 2. Gap Analysis
For each plugin, compare current config against fetched docs. Flag:
- Deprecated or renamed options
- New options that are relevant to the existing usage pattern
- Incorrect default overrides (options set to their default — no-ops)
- Missing required fields from current doc

### 3. Change Proposal
Present all proposed changes as a consolidated list, grouped by plugin. User approves or rejects per plugin before any file is touched.

### 4. Implementation
Apply approved changes only. Each change must trace directly to a doc finding. No opportunistic cleanups outside the flagged items.

### 5. Review
Code review pass on the final diff.

## Constraints

- Do not add plugins not in the current list
- Do not restructure file layout
- Do not change plugin manager (vim.pack stays)
- Do not alter keymaps unless a plugin API changed them
- Max 3 files mutated: `init.lua`, `lua/plugins/misc.lua`, `lua/plugins/language.lua`

## Success Criteria

Every plugin config:
1. Has no deprecated options (per current docs)
2. Uses current recommended API patterns
3. Has no missing required fields flagged by docs
4. Retains all existing behavior that was intentional
