return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = "modern",
    delay = 500,
    win = {
      border = "rounded",
      padding = { 1, 2 },
    },
    layout = {
      width = { min = 20 },
      spacing = 3,
    },
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false, -- Help for operators like d, y, ... 
        motions = true, -- Help for motions
        text_objects = true, -- Help for text objects
        windows = true, -- Default bindings on <c-w>
        nav = true, -- Misc bindings to work with windows
        z = true, -- Bindings for folds, spelling and others prefixed with z
        g = true, -- Bindings for prefixed with g
      },
    },
    spec = {
      -- Numeric buffer access
      { "<leader>1", desc = "Go to buffer 1" },
      { "<leader>2", desc = "Go to buffer 2" },
      { "<leader>3", desc = "Go to buffer 3" },
      { "<leader>4", desc = "Go to buffer 4" },
      { "<leader>5", desc = "Go to buffer 5" },
      { "<leader>6", desc = "Go to buffer 6" },
      { "<leader>7", desc = "Go to buffer 7" },
      { "<leader>8", desc = "Go to buffer 8" },
      { "<leader>9", desc = "Go to buffer 9" },
      
      -- Standalone keymaps (not in groups)
      { "<leader>?", desc = "Show all keymaps" },
      { "<leader>B", desc = "Set conditional breakpoint" },
      { "<leader>Y", desc = "Yank entire line to system clipboard" },
      { "<leader>y", desc = "Yank to system clipboard" },
      { "<leader>lz", desc = "Open Lazy (plugin manager)" },
      
      -- Groups (all keymaps within these groups are auto-detected from desc fields)
      { "<leader>a", group = "🗂️ Aerial Code Outline" },
      { "<leader>b", group = "📁 Buffer Operations" },
      { "<leader>c", group = "🛠️ Code Operations" },
      { "<leader>d", group = "🐛 Debug Operations" },
      { "<leader>e", group = "⚡ Execute & Terminal" },
      { "<leader>f", group = "🔍 Find & Search" },
      { "<leader>g", group = "🌳 Git Operations" },
      { "<leader>i", group = "🖼️ Image Operations" },
      { "<leader>l", group = "📡 LSP & Lazy" },
      { "<leader>m", group = "📄 Markdown Operations" },
      { "<leader>o", group = "📚 Obsidian & Notes" },
      { "<leader>p", group = "🔍 Peek Definitions" },
      { "<leader>q", group = "💾 Session & Quit" },
      { "<leader>r", group = "📝 Render & Markdown" },
      { "<leader>t", group = "🧪 Test & Treesitter" },
      { "<leader>w", group = "🪟 Window Management" },
      { "<leader>x", group = "🔧 Trouble & Diagnostics" },
    },
  },
}