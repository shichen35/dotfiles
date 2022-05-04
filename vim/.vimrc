" You want Vim, not vi. When Vim finds a vimrc, 'nocompatible' is set anyway.
" We set it explicitely to make our position clear!
set nocompatible
set termguicolors

if empty(glob("~/.vim/autoload/plug.vim"))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

filetype plugin indent on
syntax on
set backspace=indent,eol,start " Make backspace work as you would expect.
set shiftwidth=4
set shiftround
set tabstop=4 softtabstop=4
set expandtab
set autoindent
set hidden                     " Buffer should still exist if window is closed
set laststatus=2               " Always show statusline.
set display+=lastline          " Show as much as possible of the last line.
set splitright                 " Vertical windows should be split to right
set splitbelow                 " Horizontal windows should split to bottom
set noerrorbells
set nowrap
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set hls
set smartcase
set ignorecase
set wildmode=list:full
set path+=**
set nu rnu
set noshowmode
set showcmd                    " Show me what I'm typing
set ttyfast
set scrolloff=2
set sidescrolloff=4
set sidescroll=1
set encoding=utf-8
set fileformats=unix,mac
set nrformats+=alpha           " Make CTRL-A and CTRL-X work for alphabet characters
set omnifunc=ale#completion#OmniFunc

"vim-plug
call plug#begin('~/.vim/plugged')
" Plug 'joshdick/onedark.vim'
" Plug 'sheerun/vim-polyglot'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Plug 'posva/vim-vue'
" Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-easy-align'
Plug 'will133/vim-dirdiff'
Plug 'Yggdroot/indentLine'
Plug 'ap/vim-css-color'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/is.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'rust-lang/rust.vim'
call plug#end()

" Autocomplete on tab
imap <Tab> <c-x><c-o>
" Use space as <leader>
nmap <space> <bslash>
command! Config execute ":tabnew ~/.vimrc"
command! Reload execute ":source ~/.vimrc"
nmap <C-l> :set invhlsearch<CR>
nmap <C-h> :set invlist<CR>
"Automatically insert a matching brace in Vim
imap {<CR> {<CR>}<CR><Up><C-o>O

nmap <leader>u :UndotreeToggle<CR>
nmap , @@
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
xmap <leader>p "_dp
" moving lines up and down in visual mode
xmap J :m '>+1<CR>gv=gv
xmap K :m '<-2<CR>gv=gv

" NERDTree shortcuts
nmap <leader>n :NERDTreeFocus<CR>
nmap <leader>nt :NERDTreeToggle<CR>
nmap <leader>nf :NERDTreeFind<CR>

" Ale shortcuts
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Pressing ,ss will toggle and untoggle spell checking
nmap <leader>ss :setlocal spell!<cr>

"if has('nvim')
"    " Neovim specific commands
"    "autocmd TermOpen * startinsert
"    nmap <leader>cpp :tabnew %<bar>te echo "\# Compiling program... \#" && g++ -std=c++17 -o %:r.out %<CR>
"    nmap <leader>c :tabnew %<bar>te echo "\# Compiling program... \#" && gcc -o %:r.out %<CR>
"    nmap <leader>x :tabnew %<bar>te echo "\# Running program... \#" && ./%:r.out<CR>
"else
"    " Standard vim specific commands
"    " o
"    nmap <leader>cpp :!clear && echo "\# Compiling program... \#" && g++ -o %:r.out % -std=c++17<CR>
"    nmap <leader>c :!clear && echo "\# Compiling program... \#" && gcc -o %:r.out %<CR>
"    nmap <leader>x :!clear && echo "\# Running program... \#" && ./%:r.out<CR>
"endif

nmap <leader>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        set splitbelow
        :term gcc % -o %:r.out && time ./%:r.out
    elseif &filetype == 'cpp'
        set splitbelow
        exec "!g++ -std=c++11 % -Wall -o %<"
        :term time ./%<
    elseif &filetype == 'python'
        set splitbelow
        :term python3 %
    elseif &filetype == 'html'
        silent! exec "!open % &"
    elseif &filetype == 'markdown'
        exec "InstantMarkdownPreview"
    elseif &filetype == 'javascript'
        set splitbelow
        :term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
    elseif &filetype == 'go'
        set splitbelow
        :term go run %
    endif
endfunc

autocmd CompleteDone * pclose

autocmd InsertEnter,InsertLeave * call ToggleInsertMode()
function! ToggleInsertMode()
    set cul!
    set nornu!
endfunction
set bg=dark
colorscheme gruvbox
hi CursorLine term=bold cterm=bold ctermbg=233
"hi Search ctermfg=NONE ctermbg=237 cterm=bold

highlight ColorColumn ctermbg=234 guibg=#303030
nmap <leader>cc :call ToggleColorColumn()<CR>
function! ToggleColorColumn()
    if &colorcolumn == ""
        let &colorcolumn="".join(range(81,winwidth(0)),",")
    else
        let &colorcolumn=""
    endif
endfunction

" Remove newbie crutches in Command Mode
"cmap <Down> <Nop>
"cmap <Left> <Nop>
"cmap <Right> <Nop>
"cmap <Up> <Nop>

" " Remove newbie crutches in Insert Mode
" imap <Down> <Nop>
" imap <Left> <Nop>
" imap <Right> <Nop>
" imap <Up> <Nop>

" Remove newbie crutches in Normal Mode
nmap <silent><Down> :echoe "Use j"<CR>
nmap <silent><Left> :echoe "Use h"<CR>
nmap <silent><Right> :echoe "Use l"<CR>
nmap <silent><Up> :echoe "Use k"<CR>

" " Remove newbie crutches in Visual Mode
" xmap <Down> <Nop>
" xmap <Left> <Nop>
" xmap <Right> <Nop>
" xmap <Up> <Nop>

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
                    \ },
                \ 'component': {
                    \  'filename': '%n:%t'
                    \ }
                    \ }

function! ScrollIndicator()
    "let l:line_no_indicator_chars = ['⎺', '⎻', '─', '⎼', '⎽']
    let l:line_no_indicator_chars = [
                \ '>      ',
                \ '=>     ',
                \ '==>    ',
                \ '===>   ',
                \ '====>  ',
                \ '=====> ',
                \ '======>',
                \ '=======',
                \ ]
    let l:current_line = line('.')
    let l:total_lines = line('$')
    let l:line_no_fraction = floor(l:current_line) / floor(l:total_lines)
    if l:current_line == l:total_lines
        let l:index = len(l:line_no_indicator_chars) - 1
    else
        let l:index = float2nr(l:line_no_fraction * len(l:line_no_indicator_chars))
    endif
    return string(float2nr(l:line_no_fraction * 100)).'% ['.l:line_no_indicator_chars[l:index].']'
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

autocmd FileType c,cpp setlocal equalprg=clang-format

"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""

" vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

let g:ale_linters = {'c': ['gcc'],'rust': ['analyzer']}
let g:ale_c_cc_options = '-std=gnu17 -Wall'

let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }

