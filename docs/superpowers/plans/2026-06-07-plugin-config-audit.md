# Plugin Config Audit Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Audit all 19 plugin configurations against current official docs and apply corrections.

**Architecture:** Each task covers one plugin group — fetch docs via context7, diff against current config in `init.lua` / `lua/plugins/misc.lua` / `lua/plugins/language.lua`, apply only doc-backed changes, verify nvim starts cleanly, commit.

**Tech Stack:** Neovim 0.12.2, vim.pack (built-in plugin manager), Lua, context7 for doc retrieval.

---

## Verification command (used after every task)

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected output: `OK` with exit code 0. Any Lua error means a config regression.

---

## Files in scope

| File | Plugins configured there |
|------|--------------------------|
| `/Users/thrilok/.config/nvim/init.lua` | All plugins (main config) |
| `/Users/thrilok/.config/nvim/lua/plugins/misc.lua` | statusline, tabline, auto-pairs |
| `/Users/thrilok/.config/nvim/lua/plugins/language.lua` | LSP configs (pyright, clangd, lua_ls, cmake, ruff) |

---

### Task 1: catppuccin/nvim

**Files:**
- Modify: `/Users/thrilok/.config/nvim/init.lua` (catppuccin setup block, ~lines 55-72)

- [ ] **Step 1: Fetch catppuccin docs**

Use context7:
```
resolve library: catppuccin/nvim
fetch docs: setup options, integrations
```

- [ ] **Step 2: Compare current config against docs**

Current config:
```lua
require('catppuccin').setup {
  integrations = {
    treesitter      = true,
    gitsigns        = true,
    fzf             = true,
    render_markdown = true,
    dap             = true,
    dap_ui          = true,
  },
}
```

Check: Are all integration names still valid? Any new integrations for plugins we use (oil, conform, mason, codecompanion, minuet)? Any deprecated keys?

- [ ] **Step 3: Apply any doc-backed changes to init.lua**

Only change keys that docs confirm are renamed, deprecated, or newly available. If nothing changed, skip this step and note "catppuccin: no changes".

- [ ] **Step 4: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 5: Commit**

```bash
git -C /Users/thrilok/.config/nvim add init.lua
git -C /Users/thrilok/.config/nvim commit -m "fix(catppuccin): update config per current docs"
```

If no changes: skip commit.

---

### Task 2: stevearc/oil.nvim

**Files:**
- Modify: `/Users/thrilok/.config/nvim/init.lua` (oil setup block)

- [ ] **Step 1: Fetch oil.nvim docs**

Use context7:
```
resolve library: stevearc/oil.nvim
fetch docs: setup options, columns, keymaps, view_options
```

- [ ] **Step 2: Compare current config**

Current:
```lua
require('oil').setup {
  columns      = { 'size' },
  view_options = { show_hidden = true },
  keymaps = {
    ['g?']    = 'actions.show_help',    ['<CR>']  = 'actions.select',
    ['<C-v>'] = 'actions.select_vsplit', ['<C-s>'] = 'actions.select_split',
    ['<C-t>'] = 'actions.select_tab',   ['<C-p>'] = 'actions.preview',
    ['<C-c>'] = 'actions.close',        ['<C-l>'] = 'actions.refresh',
    ['-']     = 'actions.parent',       ['_']     = 'actions.open_cwd',
    ['`']     = 'actions.cd',           ['~']     = 'actions.tcd',
    ['gs']    = 'actions.change_sort',  ['gx']    = 'actions.open_external',
    ['g.']    = 'actions.toggle_hidden', ['g\\']  = 'actions.toggle_trash',
  },
}
```

Check: Renamed action names? New useful columns (permissions, mtime, icon)? New view_options? Deprecated keymaps?

- [ ] **Step 3: Apply doc-backed changes**

- [ ] **Step 4: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 5: Commit**

```bash
git -C /Users/thrilok/.config/nvim add init.lua
git -C /Users/thrilok/.config/nvim commit -m "fix(oil): update config per current docs"
```

---

### Task 3: nvim-treesitter + nvim-treesitter-textobjects

**Files:**
- Modify: `/Users/thrilok/.config/nvim/init.lua` (treesitter setup block, BufReadPost callback)

- [ ] **Step 1: Fetch treesitter docs**

Use context7:
```
resolve library: nvim-treesitter/nvim-treesitter
fetch docs: setup options, ensure_installed, highlight, auto_install
```

Then:
```
resolve library: nvim-treesitter/nvim-treesitter-textobjects
fetch docs: textobjects.move, textobjects.select, textobjects.swap
```

- [ ] **Step 2: Compare current config**

Current:
```lua
require('nvim-treesitter').setup {
  ensure_installed = {
    'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query',
    'markdown', 'python', 'bash', 'json', 'yaml', 'toml', 'cmake', 'make',
  },
  auto_install = true,
  highlight    = { enable = true },
  textobjects  = {
    move   = { enable = true, goto_next_start = { ... }, goto_next_end = { ... }, goto_previous_start = { ... }, goto_previous_end = { ... } },
    select = { enable = true, lookahead = true, keymaps = { ... } },
    swap   = { enable = true, swap_next = { ... }, swap_previous = { ... } },
  },
}
```

Check: Is `require('nvim-treesitter').setup` still the correct API (vs `require('nvim-treesitter.configs').setup`)? Any deprecated textobject query names? New move targets available?

- [ ] **Step 3: Apply doc-backed changes**

- [ ] **Step 4: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 5: Commit**

```bash
git -C /Users/thrilok/.config/nvim add init.lua
git -C /Users/thrilok/.config/nvim commit -m "fix(treesitter): update config per current docs"
```

---

### Task 4: lewis6991/gitsigns.nvim

**Files:**
- Modify: `/Users/thrilok/.config/nvim/init.lua` (gitsigns setup block)

- [ ] **Step 1: Fetch gitsigns docs**

Use context7:
```
resolve library: lewis6991/gitsigns.nvim
fetch docs: setup options, signs, signs_staged, on_attach
```

- [ ] **Step 2: Compare current config**

Current:
```lua
require('gitsigns').setup {
  signs        = { add = { text = '+' }, change = { text = '~' }, delete = { text = '_' }, topdelete = { text = '‾' }, changedelete = { text = '~' } },
  signs_staged = { add = { text = '+' }, change = { text = '~' }, delete = { text = '_' }, topdelete = { text = '‾' }, changedelete = { text = '~' } },
  on_attach = function(bufnr)
    if _G.gitsigns_on_attach then _G.gitsigns_on_attach(bufnr) end
  end,
}
```

Check: New sign types? Renamed sign keys? New options like `word_diff`, `attach_to_untracked`, `current_line_blame`?

- [ ] **Step 3: Apply doc-backed changes**

- [ ] **Step 4: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 5: Commit**

```bash
git -C /Users/thrilok/.config/nvim add init.lua
git -C /Users/thrilok/.config/nvim commit -m "fix(gitsigns): update config per current docs"
```

---

### Task 5: stevearc/conform.nvim

**Files:**
- Modify: `/Users/thrilok/.config/nvim/init.lua` (conform setup block)

- [ ] **Step 1: Fetch conform docs**

Use context7:
```
resolve library: stevearc/conform.nvim
fetch docs: setup options, formatters_by_ft, format_on_save, lsp_format
```

- [ ] **Step 2: Compare current config**

Current:
```lua
require('conform').setup {
  formatters_by_ft = {
    lua        = { 'stylua' },    markdown   = { 'prettier' },
    python     = { 'isort', 'black' }, json  = { 'prettier' },
    javascript = { 'prettier' },  typescript = { 'prettier' },
    c          = { 'clang-format' }, cpp     = { 'clang-format' },
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
    return { timeout_ms = 1000, lsp_format = 'fallback' }
  end,
}
```

Check: Is `lsp_format = 'fallback'` still valid (vs `lsp_fallback`)? New formatter options? `stop_after_first` for formatter lists? `default_format_opts`?

- [ ] **Step 3: Apply doc-backed changes**

- [ ] **Step 4: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 5: Commit**

```bash
git -C /Users/thrilok/.config/nvim add init.lua
git -C /Users/thrilok/.config/nvim commit -m "fix(conform): update config per current docs"
```

---

### Task 6: MeanderingProgrammer/render-markdown.nvim

**Files:**
- Modify: `/Users/thrilok/.config/nvim/init.lua` (render-markdown setup block)

- [ ] **Step 1: Fetch render-markdown docs**

Use context7:
```
resolve library: MeanderingProgrammer/render-markdown.nvim
fetch docs: setup options, heading, code, bullet, checkbox, quote, pipe_table, link
```

- [ ] **Step 2: Compare current config**

Current (abridged):
```lua
require('render-markdown').setup {
  file_types   = { 'markdown' },
  render_modes = { 'n', 'c' },
  heading      = { enabled = true, sign = true, icons = { ... }, backgrounds = { ... } },
  code         = { enabled = true, sign = true, style = 'full', left_pad = 2, right_pad = 2, width = 'block', border = 'thin', highlight = 'RenderMarkdownCode' },
  bullet       = { enabled = true, icons = { '●', '○', '◆', '◇' }, highlight = 'RenderMarkdownBullet' },
  checkbox     = { enabled = true, unchecked = { icon = '󰄱 ' }, checked = { icon = '󰱒 ' } },
  quote        = { enabled = true, icon = '▋', highlight = 'RenderMarkdownQuote' },
  pipe_table   = { enabled = true, style = 'full', cell = 'padded' },
  link         = { enabled = true, image = '󰥶 ', hyperlink = '󰌹 ' },
  inline_code  = { enabled = true, highlight = 'RenderMarkdownCode' },
  latex        = { enabled = false },
}
```

Check: New top-level keys? Renamed `render_modes` (now `enabled` + mode config)? New checkbox states? Deprecated options?

- [ ] **Step 3: Apply doc-backed changes**

- [ ] **Step 4: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 5: Commit**

```bash
git -C /Users/thrilok/.config/nvim add init.lua
git -C /Users/thrilok/.config/nvim commit -m "fix(render-markdown): update config per current docs"
```

---

### Task 7: jakewvincent/mkdnflow.nvim

**Files:**
- Modify: `/Users/thrilok/.config/nvim/init.lua` (mkdnflow setup block)

- [ ] **Step 1: Fetch mkdnflow docs**

Use context7:
```
resolve library: jakewvincent/mkdnflow.nvim
fetch docs: setup options, modules, mappings, to_do, links, tables
```

- [ ] **Step 2: Compare current config**

Current (abridged):
```lua
require('mkdnflow').setup {
  modules     = { bib = true, buffers = true, conceal = true, cursor = true, folds = false, links = true, lists = true, maps = true, paths = true, tables = true, yaml = false },
  create_dirs = true,
  perspective = { priority = 'first', fallback = 'current', root_tell = false, nvim_wd_heel = false, update = false },
  links       = { style = 'markdown', name_is_source = false, conceal = false, context = 0, implicit_extension = nil, transform_implicit = false,
    transform_explicit = function(t) return t:gsub(' ', '-'):lower() end,
  },
  to_do = {
    statuses     = { not_started = { marker = ' ' }, in_progress = { marker = '-' }, complete = { marker = 'X' } },
    status_order = { 'not_started', 'in_progress', 'complete' },
    status_propagation = { up = true, down = false },
  },
  tables   = { trim_whitespace = true, format_on_move = true, auto_extend_rows = false, auto_extend_cols = false },
  mappings = { ... },
}
```

Check: New modules available? Renamed to_do keys? New table options? Deprecated perspective keys?

- [ ] **Step 3: Apply doc-backed changes**

- [ ] **Step 4: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 5: Commit**

```bash
git -C /Users/thrilok/.config/nvim add init.lua
git -C /Users/thrilok/.config/nvim commit -m "fix(mkdnflow): update config per current docs"
```

---

### Task 8: williamboman/mason.nvim

**Files:**
- Modify: `/Users/thrilok/.config/nvim/init.lua` (mason setup block)

- [ ] **Step 1: Fetch mason docs**

Use context7:
```
resolve library: williamboman/mason.nvim
fetch docs: setup options, ui icons, PATH
```

- [ ] **Step 2: Compare current config**

Current:
```lua
require('mason').setup {
  ui = { icons = { package_installed = '✓', package_pending = '➜', package_uninstalled = '✗' } },
}
```

Check: New UI options (border, width, height)? `PATH` option to control mason bin ordering? Renamed `ui` keys?

- [ ] **Step 3: Apply doc-backed changes**

- [ ] **Step 4: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 5: Commit**

```bash
git -C /Users/thrilok/.config/nvim add init.lua
git -C /Users/thrilok/.config/nvim commit -m "fix(mason): update config per current docs"
```

---

### Task 9: ibhagwan/fzf-lua

**Files:**
- Modify: `/Users/thrilok/.config/nvim/init.lua` (fzf-lua setup block)

- [ ] **Step 1: Fetch fzf-lua docs**

Use context7:
```
resolve library: ibhagwan/fzf-lua
fetch docs: setup options, winopts, files, grep, fzf_opts, previewers
```

- [ ] **Step 2: Compare current config**

Current:
```lua
fzf.setup {
  'fzf-native',
  fzf_opts = { ['--layout'] = 'reverse' },
  winopts  = { height = 0.85, width = 0.80, row = 0.35, col = 0.50, preview = { layout = 'flex', flip_columns = 120 } },
  files    = { cmd = 'fd --type f --hidden --exclude .git' },
  grep     = { rg_opts = '--column --line-number --no-heading --color=always --smart-case' },
}
```

Check: New winopts (scrollbar, title)? Renamed preview keys? New profile names? `defaults` key? `ui_select` options?

- [ ] **Step 3: Apply doc-backed changes**

- [ ] **Step 4: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 5: Commit**

```bash
git -C /Users/thrilok/.config/nvim add init.lua
git -C /Users/thrilok/.config/nvim commit -m "fix(fzf-lua): update config per current docs"
```

---

### Task 10: milanglacier/minuet-ai.nvim

**Files:**
- Modify: `/Users/thrilok/.config/nvim/init.lua` (minuet setup block, InsertEnter callback)

- [ ] **Step 1: Fetch minuet docs**

Use context7:
```
resolve library: milanglacier/minuet-ai.nvim
fetch docs: setup options, provider_options, openai_fim_compatible, virtualtext keymap
```

- [ ] **Step 2: Compare current config**

Current:
```lua
require('minuet').setup {
  provider       = 'openai_fim_compatible',
  n_completions  = 1,
  context_window = 512,
  throttle       = 1200,
  debounce       = 400,
  provider_options = {
    openai_fim_compatible = {
      api_key   = 'lm-studio',
      name      = 'LMStudio',
      end_point = 'http://localhost:1234/v1/completions',
      model     = 'qwen2.5-coder',
      optional  = { max_tokens = 56, top_p = 0.9 },
    },
  },
  virtualtext = {
    auto_trigger_ft        = { '*' },
    auto_trigger_ignore_ft = { 'TelescopePrompt', 'fzf', 'oil', 'mason', 'help', 'markdown' },
    keymap = {
      accept         = '<A-a>',
      accept_line    = '<A-l>',
      accept_n_lines = '<A-n>',
      next           = '<A-]>',
      prev           = '<A-[>',
      dismiss        = '<A-e>',
    },
  },
}
```

Check: Renamed `end_point` (vs `endpoint`)? New provider options? `request_timeout`? New virtualtext options? `add_single_line_entry` option?

- [ ] **Step 3: Apply doc-backed changes**

- [ ] **Step 4: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 5: Commit**

```bash
git -C /Users/thrilok/.config/nvim add init.lua
git -C /Users/thrilok/.config/nvim commit -m "fix(minuet): update config per current docs"
```

---

### Task 11: olimorris/codecompanion.nvim

**Files:**
- Modify: `/Users/thrilok/.config/nvim/init.lua` (codecompanion setup block)

- [ ] **Step 1: Fetch codecompanion docs**

Use context7:
```
resolve library: olimorris/codecompanion.nvim
fetch docs: setup options, adapters, strategies, display.chat, display.diff, prompt_library
```

- [ ] **Step 2: Compare current config**

Current (abridged):
```lua
require('codecompanion').setup {
  adapters = {
    lmstudio = function()
      return require('codecompanion.adapters').extend('openai_compatible', {
        env    = { url = 'http://localhost:1234', api_key = 'lm-studio' },
        schema = { model = { default = 'qwen/qwen3.5-9b' }, temperature = { default = 0 }, max_tokens = { default = 4096 } },
      })
    end,
  },
  strategies = { chat = { adapter = 'lmstudio' }, inline = { adapter = 'lmstudio' }, agent = { adapter = 'lmstudio' } },
  display = {
    action_palette = { provider = 'fzf_lua', opts = { show_default_actions = true, show_default_prompt_library = true } },
    chat = { window = { layout = 'vertical', width = 0.35, position = 'right', border = 'rounded' }, show_token_count = true, show_settings = false, render_headers = true, start_in_insert_mode = false, fold_context = true, auto_scroll = true },
    diff = { enabled = true, layout = 'vertical', provider = 'default' },
  },
  prompt_library = { ... },
  opts = {
    log_level = 'ERROR',
    send_code = true,
    system_prompt = function(o) ... end,
  },
}
```

Check: `openai_compatible` adapter renamed? New display options (icons, separator)? `fold_context` still valid? New agent tool options? `strategies.agent.tools`?

- [ ] **Step 3: Apply doc-backed changes**

- [ ] **Step 4: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 5: Commit**

```bash
git -C /Users/thrilok/.config/nvim add init.lua
git -C /Users/thrilok/.config/nvim commit -m "fix(codecompanion): update config per current docs"
```

---

### Task 12: DAP stack (nvim-dap + nvim-dap-ui + nvim-dap-virtual-text + nvim-dap-python)

**Files:**
- Modify: `/Users/thrilok/.config/nvim/init.lua` (DAP setup block, setup_dap function)

- [ ] **Step 1: Fetch nvim-dap docs**

Use context7:
```
resolve library: mfussenegger/nvim-dap
fetch docs: setup, adapters, configurations, listeners
```

- [ ] **Step 2: Fetch nvim-dap-ui docs**

Use context7:
```
resolve library: rcarriga/nvim-dap-ui
fetch docs: setup options, layouts, elements, controls, icons
```

- [ ] **Step 3: Fetch nvim-dap-virtual-text docs**

Use context7:
```
resolve library: theHamsta/nvim-dap-virtual-text
fetch docs: setup options, display_callback, virt_text_pos
```

- [ ] **Step 4: Fetch nvim-dap-python docs**

Use context7:
```
resolve library: mfussenegger/nvim-dap-python
fetch docs: setup, test runner options
```

- [ ] **Step 5: Compare current config**

Current dapui setup:
```lua
dapui.setup {
  icons   = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
  layouts = {
    { elements = { { id = 'scopes', size = 0.25 }, 'breakpoints', 'stacks', 'watches' }, size = 40, position = 'left' },
    { elements = { 'repl', 'console' }, size = 0.25, position = 'bottom' },
  },
  controls = { icons = { pause = '', play = '', step_into = '', step_over = '', step_out = '', step_back = '', run_last = '↻', terminate = '□' } },
  floating = { border = 'rounded' },
}
```

Current virtual text setup:
```lua
require('nvim-dap-virtual-text').setup {
  highlight_changed_variables = true,
  virt_text_pos = 'inline',
  display_callback = function(v, _, _, _, o)
    return o.virt_text_pos == 'inline' and (' = ' .. v.value) or (v.name .. ' = ' .. v.value)
  end,
}
```

Check: `controls.enabled` required now? New element IDs in dap-ui? `nvim-dap-virtual-text` `display_callback` signature changed? `dap-python` setup path changed? New sign names?

- [ ] **Step 6: Apply doc-backed changes**

- [ ] **Step 7: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 8: Commit**

```bash
git -C /Users/thrilok/.config/nvim add init.lua
git -C /Users/thrilok/.config/nvim commit -m "fix(dap): update dap stack config per current docs"
```

---

### Task 13: mg979/vim-visual-multi

**Files:**
- Modify: `/Users/thrilok/.config/nvim/init.lua` (vim-visual-multi g: vars block)

- [ ] **Step 1: Fetch vim-visual-multi docs**

Use context7:
```
resolve library: mg979/vim-visual-multi
fetch docs: VM_theme, VM_maps, configuration variables
```

- [ ] **Step 2: Compare current config**

Current:
```lua
vim.g.VM_theme = 'iceblue'
vim.g.VM_maps  = { ['Find Under'] = '<C-n>', ['Find Subword Under'] = '<C-n>' }
```

Check: New theme names? Deprecated `VM_maps` keys? New global vars for behavior control?

- [ ] **Step 3: Apply doc-backed changes**

- [ ] **Step 4: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 5: Commit**

```bash
git -C /Users/thrilok/.config/nvim add init.lua
git -C /Users/thrilok/.config/nvim commit -m "fix(vim-visual-multi): update config per current docs"
```

---

### Task 14: Dependencies (plenary.nvim, nvim-nio)

**Files:**
- No config changes expected (pure dependency plugins)

- [ ] **Step 1: Fetch plenary docs**

Use context7:
```
resolve library: nvim-lua/plenary.nvim
fetch docs: overview, modules
```

- [ ] **Step 2: Fetch nvim-nio docs**

Use context7:
```
resolve library: nvim-neotest/nvim-nio
fetch docs: overview
```

- [ ] **Step 3: Confirm no config needed**

Both are dependency libraries with no user-facing setup calls in the config. Verify no `require('plenary').setup` or `require('nio').setup` is needed.

If docs show a required setup call: add it to init.lua before the plugin that depends on it. Otherwise note "no changes".

- [ ] **Step 4: Verify**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

---

### Task 15: Final integration check

**Files:** None modified

- [ ] **Step 1: Run full startup check**

```bash
nvim --headless -c "lua print('OK')" -c "quit" 2>&1
```

Expected: `OK`

- [ ] **Step 2: Check for deprecation warnings**

```bash
nvim --headless -c "checkhealth" -c "quit" 2>&1 | grep -i "warn\|error\|deprecat" | head -30
```

Review output. Any new warnings introduced by this audit should be fixed.

- [ ] **Step 3: Final commit if any fixes from Step 2**

```bash
git -C /Users/thrilok/.config/nvim add -p
git -C /Users/thrilok/.config/nvim commit -m "fix: resolve deprecation warnings from checkhealth"
```

- [ ] **Step 4: Tag the audit completion**

```bash
git -C /Users/thrilok/.config/nvim log --oneline -15
```

Confirm all task commits are present.
