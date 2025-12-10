# AI Coding Assistants - Quick Guide

## Your Tools

### 1. Gen.nvim - ⚡ Fast & Simple
**Best for:** Quick tasks, simple prompts, instant responses

**Commands:**
- `<Space>gg` - Quick AI prompt
- `<Space>gc` - Simple chat

**Example:**
```
<Space>gg
Select: "Chat"
Type: "explain this code"
Get instant answer in popup window
Press 'q' to close
```

### 2. Avante.nvim - 🎯 Advanced & Powerful
**Best for:** Complex refactoring, precise edits, code generation

**Commands:**
- `<Space>aa` - Toggle sidebar chat
- `<Space>ae` - Edit with AI (inline)
- `<Space>ar` - Refresh

**Example:**
```
<Space>aa
Sidebar opens
Type: "refactor this function"
Review AI's suggestions
Press 'ct' to accept changes
Press 'co' to keep your code
```

---

## When to Use Which?

### Use Gen.nvim for:
- ✅ Quick explanations
- ✅ Simple fixes
- ✅ Fast questions
- ✅ **Speed is priority**

### Use Avante for:
- ✅ Complex refactoring
- ✅ Precise code edits
- ✅ Multi-step changes
- ✅ **Accuracy is priority**

---

## Configuration

Both tools use **qwen2.5-coder:14b** via Ollama (local & free).

### Files
- `lua/plugins/gen-nvim.lua` - Gen configuration
- `lua/plugins/avante.lua` - Avante configuration

### Change Model
Edit the respective config file and change:
```lua
model = 'qwen2.5-coder:14b',  -- Change to your preferred model
```

### Available Models
- `qwen2.5-coder:7b` - Faster (6GB RAM)
- `qwen2.5-coder:14b` - Current (10GB RAM) ⭐
- `qwen2.5-coder:32b` - Best quality (20GB+ RAM)

---

## Quick Start

1. **Ensure Ollama is running:**
   ```bash
   ollama serve
   ```

2. **Restart Neovim:**
   ```bash
   :qa!
   nvim
   ```

3. **Try Gen (fast):**
   ```
   <Space>gg
   Select "Chat"
   Ask anything!
   ```

4. **Try Avante (powerful):**
   ```
   <Space>aa
   Chat opens in sidebar
   Ask for code generation!
   ```

---

## Troubleshooting

### "Connection refused"
```bash
# Start Ollama
ollama serve
```

### Slow responses
- Use smaller model: `qwen2.5-coder:7b`
- Close other apps
- Check system resources

### Plugin not working
```vim
:Lazy sync
:qa!
nvim
```

---

## Summary

- **Gen** = ChatGPT-style (fast prompts)
- **Avante** = Cursor AI-style (advanced editing)

Both use the same local model (qwen2.5-coder:14b) via Ollama.

**Choose based on your task complexity!** 🚀

---

**Configuration based on official docs:**
- [Gen.nvim GitHub](https://github.com/David-Kunz/gen.nvim)
- [Avante.nvim GitHub](https://github.com/yetone/avante.nvim)
- [Avante Custom Providers](https://github.com/yetone/avante.nvim/wiki/Custom-providers)
- [Avante Migration Guide](https://github.com/yetone/avante.nvim/wiki/Provider-configuration-migration-guide)
