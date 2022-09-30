vim.g.mapleader = " "

vim.cmd([[
nmap <leader>l :set invlist<CR>
nmap <leader>h :set hls!<CR>
nnoremap / :set hls<CR>/

" define line highlight color
highlight LineHighlight cterm=bold ctermbg=darkgray guibg=darkgray
" highlight the current line
nnoremap <silent> <Leader>ll :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>
" clear all the highlighted lines
nnoremap <silent> <Leader>lc :call clearmatches()<CR>

"Automatically insert a matching brace in Vim
imap <silent> {<CR> {<CR>}<CR><Up><C-o>O

nmap <leader>u :UndotreeToggle<CR>

imap <C-e> <C-o><S-a>
imap <c-a> <c-o><s-i>

" yank into clipboard
nmap <leader>y "+y
xmap <leader>y "+y
nmap <leader>Y gg"+yG

" delete without yanking
nmap <leader>d "_d
xmap <leader>d "_d

" replace currently selected text with default register
" without yanking it
xmap <leader>p "_dP

" moving lines up and down in visual mode
xmap J :m '>+1<CR>gv=gv
xmap K :m '<-2<CR>gv=gv

" MERDTree shortcuts
nmap <leader>nn :NERDTreeFocus<CR>
nmap <leader>nt :NERDTreeToggle<CR>
nmap <leader>nf :NERDTreeFind<CR>

" Remove newbie crutches in Normal Mode
nmap <silent><Down> :echoe "Use j"<CR>
nmap <silent><Left> :echoe "Use h"<CR>
nmap <silent><Right> :echoe "Use l"<CR>
nmap <silent><Up> :echoe "Use k"<CR>

"nmap <leader>cl :call ToggleColorColumn()<CR>
"highlight ColorColumn ctermbg=234 guibg=#303030
"function! ToggleColorColumn()
"    if &colorcolumn == ""
"        let &colorcolumn="".join(range(81,winwidth(0)),",")
"    else
"        let &colorcolumn=""
"    endif
"endfunction

" EasyAlign
xmap ga <Plug>(EasyAlign)

" cycle through colorschemes
func! NextColors()
    let idx = index(g:colour_scheme_list, g:colors_name)
    return (idx + 1 >= len(g:colour_scheme_list) ? g:colour_scheme_list[0] : g:colour_scheme_list[idx + 1])
endfunc
nnoremap <silent> <leader>cc :exe "colorscheme " .. NextColors()<CR>

" Autocomplete on tab
" imap <Tab> <c-x><c-o>

" telescope
" Using Lua functions
nnoremap <silent> <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <silent> <leader>fa <cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>
nnoremap <silent> <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <silent> <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <silent> <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <silent> <leader>fl <cmd>lua require('telescope.builtin').treesitter()<cr>
nnoremap <silent> <leader>ft :split<cr> :terminal<cr>a

" vsnip
" Expand or jump
imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>'
" Jump forward or backward
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" dap-ui
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl <Cmd>lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>do <Cmd>lua require'dapui'.toggle()<CR>
nnoremap <silent> <leader>k <Cmd>lua require'dapui'.eval()<CR>


" cmp
" Code navigation shortcuts
" as found in :help lsp
" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
"nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
"nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
"nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>

" Quick-fix
"nnoremap <silent> ca    <cmd>lua vim.lsp.buf.code_action()<CR>

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration

" easy motion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
nmap <Leader>/ <Plug>(easymotion-sn)
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

augroup CHEN_SHI
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    " autocmd VimEnter * :VimApm
    " autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END

nnoremap <leader>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		set splitbelow
		:sp
		:term gcc % -o %:r.out && time ./%:r.out
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:term time ./%<
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!open % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	elseif &filetype == 'rust'
		set splitbelow
		:sp
		:term cargo run .
	endif
endfunc
]])

