require "options"
require "keymaps"
require "lazy-init"
require "autocommands"

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.o.guifont = "JetBrainsMonoNL Nerd Font:h12" -- text below applies for VimScript
  vim.g.neovide_remember_window_size = false
end
