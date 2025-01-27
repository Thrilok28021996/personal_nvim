
# Nvim custom setup for python

I have used this github as a reference: https://github.com/nvim-lua/kickstart.nvim . For any changes or need to add new plugs use this as a reference.

Note: Remove the previous installed neovim before cloning the repository.
Remove unnecessary files from this locations using this command

### required

rm -rf ~/.config/nvim

### optional but recommended

rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

or you can backup them with these commands in terminal

### required

mv ~/.config/nvim

### optional but recommended

mv ~/.local/share/nvim
mv ~/.local/state/nvim
mv ~/.cache/nvim

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
   using this command 'git clone https://github.com/Thrilok28021996/nvim.git ~/.config/nvim'
2. Then run the nvim command in the terminal
3. It will download all the plugins for the neovim setup
