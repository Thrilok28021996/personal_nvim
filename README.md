# Nvim custom setup for python

I have used this github as a reference: https://github.com/nvim-lua/kickstart.nvim . For any changes or need to add new plugs use this as a reference.

Note: Remove the previous installed neovim before cloning the repository.
Remove unnecessary files from this locations using this command

### To remove the previous configuration

```bash
rm -rf ~/.config/nvim
```

### optional but recommended to remove

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

### You can backup them with these commands in terminal

```bash
mv ~/.config/nvim{,.bak}
```

### optional but recommended to do

```bash
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

## Requirements

- Neovim >= 0.9.0 (needs to be built with LuaJIT)
- Git >= 2.19.0 (for partial clones support)
- a Nerd Font(v3.0 or greater) (optional, but needed to display some icons)
- lazygit (optional)
- a C compiler for nvim-treesitter. See here
- for telescope.nvim (optional)
  - live grep: ripgrep
  - find files: fd

1. Clone the git repository to the .config folder
   using this command:
   ```bash
   git clone https://github.com/Thrilok28021996/personal_nvim.git ~/.config/nvim
   ```
2. Then run the nvim command in the terminal
3. It will download all the plugins for the neovim setup

## Plugins we have used

### Programming Plugins

1. File Explorer --> Oil
2. Color Scheme --> Catppuccin
3. which keys --> Which-Key
4. Auto Format --> Conform
5. Terminal --> Toggle Terminal
6. Auto complete --> Blink
7. Programming Language --> nvim-lspconfig
8. Linting --> nvim-lint
9. Mason(Programming Language Installer) --> Mason
10. Misc --> Mini.nvim,Indentscope,pick,statusline,pairs,icons,tabline
11. Comments (ToDo) --> Todo-comments
12. Command Line --> Noice
13. Git Signs --> Git Signs
14. Git Integration --> Lazy Git

### Note Making Plugins

1. Markdown Rendering --> Render Markdown
2. Markdown Preview --> Peek
3. Table Mode --> Vim Table Mode
4. Add Images --> Image clip
5. Hight Lighting --> Tree Sitter

### Markdown

Install deno first in debian and add the plugin next to use peek as markdown-preview

### Jupyter Notebook

To run the jupyter-notebook

### Requirements

- 💻 Linux, macOS and Windows (CMD, PowerShell, WSL2)
- Neovim >= v0.8
- 🦊 Firefox

  - Other browsers are not supported due to their limitation with Selenium (see #49)

- 🦎 Mozilla geckodriver

  - May already be installed with Firefox. Check geckodriver -V

- 🐍 Python >= 3.8

  - Supported Python installation methods include system-level and Conda

- 📔 Jupyter Notebook >= 6.2

  - Jupyter Lab is not supported

  ```console

  # jupyter-console is optional and used for `:JupyniumKernelOpenInTerminal`

  pip install notebook nbclassic jupyter-console
  ```

Important note about Notebook 7 (breaking change!)

Jupynium does not support Notebook 7 yet. In the meantime, you can change the

default_notebook_URL = "localhost:8888/nbclassic"

in require("jupynium").setup({ ... }) to use the classic (Notebook 6) interface with Jupynium. This is the new default setting from now on.

Don't forget to upgrade your notebook and install nbclassic (pip install --upgrade notebook nbclassic) when you set this.

For more details. GO to this link: https://github.com/kiyoon/jupynium.nvim?utm_source=chatgpt.com
