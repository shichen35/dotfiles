-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local setkey = vim.keymap.set

-- yank into clipboard
setkey("x", "<leader>y", '"+y', { noremap = true, desc = "Copy to system clipboard" })

-- Moving lines up and down in visual mode
setkey("x", "J", ":m '>+1<CR>gv=gv")
setkey("x", "K", ":m '<-2<CR>gv=gv")

-- Remove newbie crutches in Normal Mode
setkey("n", "<Up>", ':echoe "Use k"<CR>', { silent = true })
setkey("n", "<Down>", ':echoe "Use j"<CR>', { silent = true })
setkey("n", "<Left>", ':echoe "Use h"<CR>', { silent = true })
setkey("n", "<Right>", ':echoe "Use l"<CR>', { silent = true })

-- Remove arrow keys in Insert Mode
setkey("i", "<Up>", "<nop>", { silent = true })
setkey("i", "<Down>", "<nop>", { silent = true })
setkey("i", "<Left>", "<nop>", { silent = true })
setkey("i", "<Right>", "<nop>", { silent = true })

setkey("n", "<leader>il", ":set invlist<CR>", { silent = true })
