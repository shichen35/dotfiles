-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap('', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
keymap('n', 'j', [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
keymap('n', 'k', [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })

-- Normal --
-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', { silent = true })
keymap('n', '<C-j>', '<C-w>j', { silent = true })
keymap('n', '<C-k>', '<C-w>k', { silent = true })
keymap('n', '<C-l>', '<C-w>l', { silent = true })

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', { silent = true })
keymap('n', '<C-Down>', ':resize +2<CR>', { silent = true })
keymap('n', '<C-Left>', ':vertical resize -2<CR>', { silent = true })
keymap('n', '<C-Right>', ':vertical resize +2<CR>', { silent = true })

-- Navigate buffers
keymap('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
keymap('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })

-- Toggle highlights
keymap(
  'n',
  '<leader>ht',
  '<cmd>set hlsearch!<CR>',
  { silent = true, desc = 'Toggle highlights' }
)

-- TermSelect
keymap(
  'n',
  '<leader>st',
  '<cmd>TermSelect<CR>',
  { silent = true, desc = 'Select Terminal' }
)

-- Close buffers
keymap('n', '<S-q>', '<cmd>Bdelete!<CR>', { silent = true })

-- Better paste
keymap('v', 'p', 'P', { silent = true })

-- Find and replace all selected
keymap(
  'v',
  '<leader>s',
  "y:<C-U>let replacement = input('Enter replacement string: ') <bar> %s/<C-R>\"/\\=replacement/g<CR>",
  { silent = true, desc = 'Find and replace all selected' }
)

-- Ctrl + C to ESC
keymap('i', '<C-C>', '<ESC>', { silent = true })

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', { silent = true })
keymap('v', '>', '>gv', { silent = true })

-- Plugins --

-- Lazy
keymap(
  'n',
  '<leader>lz',
  '<cmd>Lazy<CR>',
  { desc = 'Lazy plugin List', silent = true }
)

-- Git
keymap(
  'n',
  '<leader>gl',
  '<cmd>lua _LAZYGIT_TOGGLE()<CR>',
  { desc = 'Toggle Lazygit', silent = true }
)
keymap(
  'n',
  '<leader>gg',
  '<cmd>lua _GITUI_TOGGLE()<CR>',
  { desc = 'Toggle GitUI', silent = true }
)

-- Lsp
keymap(
  'n',
  '<leader>lf',
  '<cmd>lua require("conform").format({ async = true, lsp_fallback = true })<cr>',
  { silent = true }
)

-- Highlight Lines
keymap(
  'n',
  '<leader>hl',
  "<cmd>call matchadd('Cursor', '\\%'.line('.').'l',10,line('.') + 100)<CR>",
  { silent = true }
)
keymap(
  'n',
  '<leader>hd',
  "<cmd>call matchdelete(line('.') + 100)<CR>",
  { silent = true }
)
keymap('n', '<leader>hc', '<cmd>call clearmatches()<CR>', { silent = true })

-- tab
keymap('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
keymap('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
keymap('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
keymap('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
keymap('n', '<leader><tab>c', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
keymap('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

vim.cmd [[
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
		exec "!g++ -std=c++20 % -Wall -o %<"
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
]]
