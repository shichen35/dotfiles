if vim.g.vscode then
  -- VSCode extension
  vim.g.mapleader = " "
  require("config.keymaps")
else
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end
