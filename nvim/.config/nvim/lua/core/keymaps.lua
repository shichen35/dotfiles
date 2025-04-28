-- Shorten function name
local map = vim.keymap.set

-- Remap space as leader key
map("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
map("n", "j", [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
map("n", "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })

-- Normal --
-- Better window navigation
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", { silent = true })
map("n", "<C-Down>", ":resize +2<CR>", { silent = true })
map("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
map("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- Navigate buffers
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Toggle highlights
map("n", "<leader>ht", "<cmd>set hlsearch!<CR>", { silent = true, desc = "Toggle highlights" })

-- TermSelect
map("n", "<leader>st", "<cmd>TermSelect<CR>", { silent = true, desc = "Select Terminal" })

-- Close buffers
map("n", "<S-q>", "<cmd>Bdelete!<CR>", { silent = true })

-- Better paste
map("v", "p", "P", { silent = true })

-- Find and replace all selected
map(
  "v",
  "<leader>s",
  "y:<C-U>let replacement = input('Enter replacement string: ') <bar> %s/<C-R>\"/\\=replacement/g<CR>",
  { silent = true, desc = "Find and replace all selected" }
)

-- Ctrl + C to ESC
map("i", "<C-C>", "<ESC>", { silent = true })

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", { silent = true })
map("v", ">", ">gv", { silent = true })

-- Plugins --

-- Lazy
map("n", "<leader>lz", "<cmd>Lazy<CR>", { desc = "Lazy plugin List", silent = true })

-- Git
map("n", "<leader>gl", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "Toggle Lazygit", silent = true })
map("n", "<leader>gg", "<cmd>lua _GITUI_TOGGLE()<CR>", { desc = "Toggle GitUI", silent = true })

-- Lsp
map(
  "n",
  "<leader>lf",
  '<cmd>lua require("conform").format({ async = true, lsp_fallback = true })<cr>',
  { silent = true }
)

-- Highlight Lines
map("n", "<leader>hl", "<cmd>call matchadd('Cursor', '\\%'.line('.').'l',10,line('.') + 100)<CR>", { silent = true })
map("n", "<leader>hd", "<cmd>call matchdelete(line('.') + 100)<CR>", { silent = true })
map("n", "<leader>hc", "<cmd>call clearmatches()<CR>", { silent = true })

-- tab
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>c", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

vim.cmd([[
nmap <leader>il :set invlist<CR>

" yank into clipboard
nmap <leader>y "+y
xmap <leader>y "+y
nmap <leader>Y gg"+yG

" delete without yanking
nmap <leader>pd "_d
xmap <leader>pd "_d

" replace currently selected text with default register
" without yanking it
xmap <leader>pp "_dP

" moving lines up and down in visual mode
xmap J :m '>+1<CR>gv=gv
xmap K :m '<-2<CR>gv=gv

" Remove newbie crutches in Normal Mode
nmap <silent><Down> :echoe "Use j"<CR>
nmap <silent><Left> :echoe "Use h"<CR>
nmap <silent><Right> :echoe "Use l"<CR>
nmap <silent><Up> :echoe "Use k"<CR>

" Remove arrow keys in Insert Mode
imap <silent><Down> <nop>
imap <silent><Left> <nop>
imap <silent><Right> <nop>
imap <silent><Up> <nop>

nnoremap <leader>r :call CompileRun()<CR>

func! CompileRun()
	exec "w"
	if &filetype == 'c'
		set splitbelow
		:sp
		:term mkdir -p bin && gcc % -g -o bin/%:t:r && ./bin/%:t:r
	elseif &filetype == 'cpp'
		set splitbelow
		:sp
    :term mkdir -p bin && g++ -std=c++20 % -Wall -o bin/%:t:r && ./bin/%:t:r
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!open % &"
	elseif &filetype == 'markdown'
		exec "PeekOpen"
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	elseif &filetype == 'rust'
		set splitbelow
		:sp
		:term cargo run .
	elseif &filetype == 'typescript'
		set splitbelow
		:sp
		:term tsc % && node %:r.js
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term node %:r.js
	elseif &filetype == 'java'
		set splitbelow
		:sp
		:term java %:r.java
	endif
endfunc
]])
