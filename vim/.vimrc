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
set hidden
set laststatus=2 " Always show statusline.
set display+=lastline  " Show as much as possible of the last line.
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
set showcmd
set ttyfast
set scrolloff=2
set sidescrolloff=4
set sidescroll=1
set encoding=utf-8

"vim-plug
call plug#begin('~/.vim/plugged')
" Plug 'joshdick/onedark.vim'
" Plug 'sheerun/vim-polyglot'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Plug 'posva/vim-vue'
Plug 'ap/vim-css-color'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/is.vim'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
call plug#end()

command! Config execute ":tabnew ~/.vimrc"
nnoremap <C-l> :set invhlsearch<CR>
nnoremap <C-h> :set invlist<CR>
"Automatically insert a matching brace in Vim
inoremap {<CR> {<CR>}<C-o>O
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap , @@
inoremap <C-e> <C-o><S-a>
inoremap <c-a> <c-o><s-i>
" yank into clipboard
nnoremap <leader>y "+y
xnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
" delete without yanking
nnoremap <leader>d "_d
xnoremap <leader>d "_d
" replace currently selected text with default register
" without yanking it
xnoremap <leader>p "_dp
" moving lines up and down in visual mode
xnoremap J :m '>+1<CR>gv=gv
xnoremap K :m '<-2<CR>gv=gv

" NERDTree shortcuts
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

" Ale shortcuts
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"if has('nvim')
"    " Neovim specific commands
"    "autocmd TermOpen * startinsert
"    nnoremap <leader>cpp :tabnew %<bar>te echo "\# Compiling program... \#" && g++ -std=c++17 -o %:r.out %<CR>
"    nnoremap <leader>c :tabnew %<bar>te echo "\# Compiling program... \#" && gcc -o %:r.out %<CR>
"    nnoremap <leader>x :tabnew %<bar>te echo "\# Running program... \#" && ./%:r.out<CR>
"else
"    " Standard vim specific commands
"    " o
"    nnoremap <leader>cpp :!clear && echo "\# Compiling program... \#" && g++ -o %:r.out % -std=c++17<CR>
"    nnoremap <leader>c :!clear && echo "\# Compiling program... \#" && gcc -o %:r.out %<CR>
"    nnoremap <leader>x :!clear && echo "\# Running program... \#" && ./%:r.out<CR>
"endif

autocmd InsertEnter,InsertLeave * call ToggleInsertMode()
function! ToggleInsertMode()
    set cul!
    set nornu!
endfunction
set bg=dark
colorscheme gruvbox
hi CursorLine term=bold cterm=bold ctermbg=233
"hi Search ctermfg=NONE ctermbg=237 cterm=bold

highlight ColorColumn ctermbg=234 guibg=black
nnoremap <leader>cc :call ToggleColorColumn()<CR>
function! ToggleColorColumn()
    if &colorcolumn == ""
        let &colorcolumn="".join(range(81,winwidth(0)),",")
    else
        let &colorcolumn=""
    endif
endfunction

" Remove newbie crutches in Command Mode
"cnoremap <Down> <Nop>
"cnoremap <Left> <Nop>
"cnoremap <Right> <Nop>
"cnoremap <Up> <Nop>

" Remove newbie crutches in Insert Mode
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>

" Remove newbie crutches in Normal Mode
nnoremap <silent><Down> :echoe "Use j"<CR>
nnoremap <silent><Left> :echoe "Use h"<CR>
nnoremap <silent><Right> :echoe "Use l"<CR>
nnoremap <silent><Up> :echoe "Use k"<CR>

" Remove newbie crutches in Visual Mode
xnoremap <Down> <Nop>
xnoremap <Left> <Nop>
xnoremap <Right> <Nop>
xnoremap <Up> <Nop>

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'percent': 'ScrollIndicator',
      \ }
      \ }

function! ScrollIndicator()
    "let l:line_no_indicator_chars = ['⎺', '⎻', '─', '⎼', '⎽']
    let l:line_no_indicator_chars = [
        \ '>         ',
        \ '=>        ',
        \ '==>       ',
        \ '===>      ',
        \ '====>     ',
        \ '=====>    ',
        \ '======>   ',
        \ '=======>  ',
        \ '========> ',
        \ '=========>',
        \ '==========',
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

let g:ale_linters = {'c': ['gcc']}
let g:ale_c_cc_options = '-std=gnu17 -Wall'

