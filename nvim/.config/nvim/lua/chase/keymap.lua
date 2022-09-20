vim.cmd([[
" Use space as <leader>
let mapleader = "\<Space>"

nmap <leader>l :set invlist<CR>
nmap <leader>h :set hls!<CR>
nnoremap / :set hls<CR>/

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

" Remove newbie crutches in Normal Mode
nmap <silent><Down> :echoe "Use j"<CR>
nmap <silent><Left> :echoe "Use h"<CR>
nmap <silent><Right> :echoe "Use l"<CR>
nmap <silent><Up> :echoe "Use k"<CR>

nmap <leader>cc :call ToggleColorColumn()<CR>
highlight ColorColumn ctermbg=234 guibg=#303030
function! ToggleColorColumn()
    if &colorcolumn == ""
        let &colorcolumn="".join(range(81,winwidth(0)),",")
    else
        let &colorcolumn=""
    endif
endfunction

" Autocomplete on tab
imap <Tab> <c-x><c-o>

" telescope
" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
" nnoremap <silent> <leader>fa :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>fa :CodeActionMenu<CR>

" easy motion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
nmap <Leader>/ <Plug>(easymotion-sn)
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1


let g:lightline = {
            \ 'colorscheme': 'powerline',
            \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'readonly', 'filename', 'modified' ] ],
                \   'right': [ [ 'lineinfo' ],
                \              [ 'percent' ],
                \              [ 'fileformat', 'fileencoding', 'filetype'] ]
                \ },
                \ 'component_function': {
                    \   'percent': 'ScrollIndicator',
                    \   'lineinfo': 'LightlineLineinfo',
                    \ },
                \ 'component': {
                    \  'filename': '%n:%t'
                    \ }
                    \ }

function! LightlineLineinfo()
    let l:current_line = printf('%3d', line('.'))
    let l:max_line = printf('%d', line('$'))
    let l:current_col = printf('%-2d', col('.'))
    let l:lineinfo = ' ' . l:current_line . '/' . l:max_line . ':' . l:current_col
    return l:lineinfo
endfunction

function! ScrollIndicator()
    let l:line_no_indicator_chars = ['⎺', '⎻', '─', '⎼', '⎽']
    let l:current_line = line('.')
    let l:total_lines = line('$')
    let l:line_no_fraction = floor(l:current_line) / floor(l:total_lines)
    if l:current_line == l:total_lines
        let l:index = len(l:line_no_indicator_chars) - 1
    else
        let l:index = float2nr(l:line_no_fraction * len(l:line_no_indicator_chars))
    endif
    let l:percentage = printf("%3d%%",float2nr(l:line_no_fraction * 100))
    "return l:percentage . ' ['.l:line_no_indicator_chars[l:index].']'
    return l:line_no_indicator_chars[l:index]
endfunction

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

