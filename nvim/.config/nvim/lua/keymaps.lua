-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
keymap("n", "j", [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
keymap("n", "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { silent = true })
keymap("n", "<C-j>", "<C-w>j", { silent = true })
keymap("n", "<C-k>", "<C-w>k", { silent = true })
keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", { silent = true })
keymap("n", "<C-Down>", ":resize +2<CR>", { silent = true })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", { silent = true })
keymap("n", "<S-h>", ":bprevious<CR>", { silent = true })

-- Toggle highlights
keymap("n", "<leader>h", "<cmd>set hlsearch!<CR>", {silent = true, desc = "Toggle highlights"})

-- TermSelect
keymap("n", "<leader>gt", "<cmd>TermSelect<CR>", {silent = true, desc = "Select Terminal"})

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", { silent = true })

-- Better paste
keymap("v", "p", 'P', { silent = true })

-- Ctrl + C to ESC
keymap("i", "<C-C>", "<ESC>", { silent = true })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", { silent = true })
keymap("v", ">", ">gv", { silent = true })

-- Plugins --

-- Alpha
keymap("n", "<leader>a", ":Alpha<CR>", { silent = true })

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { silent = true })

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { silent = true })
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { silent = true })
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { silent = true })
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { silent = true })
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", { silent = true })
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { silent = true })
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { silent = true })
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", { silent = true })
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", { silent = true })

-- Lsp
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", { silent = true })

-- Highlight Lines
keymap("n", "<leader>hl", "<cmd>call matchadd('Cursor', '\\%'.line('.').'l',10,line('.') + 100)<CR>", { silent = true })
keymap("n", "<leader>hd", "<cmd>call matchdelete(line('.') + 100)<CR>", { silent = true })
keymap("n", "<leader>hc", "<cmd>call clearmatches()<CR>", { silent = true })


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

nnoremap <leader>r :call CompileRun()<CR>

func! CompileRun()
	exec "w"
	if &filetype == 'c'
		set splitbelow
		:sp
		:term gcc % -o %:r.out && ./%:r.out
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:term ./%<
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!open % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
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
	endif
endfunc
]])
