" =============================================================================
" GENERAL SETTINGS
" =============================================================================
set nocompatible
set encoding=utf-8
scriptencoding utf-8
set fileformats=unix,mac

" Performance & UX
set termguicolors              " Enable true color support
set ttyfast                    " Faster scrolling
set lazyredraw                 " Don't redraw while executing macros
set updatetime=300             " Faster completion/diagnostics update (default 4000)
set shortmess+=c               " Shut off completion messages
set signcolumn=yes             " Always show sign column to prevent text shift
set hidden                     " Allow buffer switching without saving
set history=1000

" Indentation
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set shiftround
set backspace=indent,eol,start

" Search
set incsearch
set ignorecase
set smartcase
set hlsearch

" UI Layout
set number relativenumber
set laststatus=2               " Always show statusline
set display+=lastline          " Show as much as possible of the last line
set splitright                 " Vertical windows split to right
set splitbelow                 " Horizontal windows split to bottom
set scrolloff=5                " Keep 5 lines context when scrolling
set sidescrolloff=5
set nowrap
set noshowmode                 " distinct from 'showcmd', lightline handles mode
set showcmd
set wildmenu
set noerrorbells
set mouse=a

" Persistent Undo
if has("persistent_undo")
    let target_path = expand('~/.vim/undodir')
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif
    let &undodir=target_path
    set undofile
endif

" =============================================================================
" PLUGINS (Vim-Plug)
" =============================================================================
if empty(glob("~/.vim/autoload/plug.vim"))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" UI & Themes
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'

" Navigation & Search
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
Plug 'preservim/nerdtree'
Plug 'mbbill/undotree'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/is.vim'
Plug 'wellle/context.vim'

" Editing & Coding
Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Languages
Plug 'rust-lang/rust.vim'

call plug#end()

" =============================================================================
" THEME & APPEARANCE
" =============================================================================
set background=dark
try
    colorscheme gruvbox
catch
    colorscheme default
endtry

hi CursorLine term=bold cterm=bold ctermbg=233
highlight ColorColumn ctermbg=234 guibg=#303030

" Lightline Configuration
let g:lightline = {
            \ 'colorscheme': 'gruvbox',
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
    return ' ' . l:current_line . '/' . l:max_line . ':' . l:current_col
endfunction

function! ScrollIndicator()
    let l:chars = ['⎺', '⎻', '─', '⎼', '⎽']
    let l:ratio = 1.0 * line('.') / line('$')
    let l:idx = float2nr(l:ratio * (len(l:chars) - 1))
    return l:chars[l:idx]
endfunction

" =============================================================================
" MAPPINGS
" =============================================================================
let mapleader = "\<Space>"

" Config Management
command! Config tabnew ~/.vimrc
command! Reload source ~/.vimrc

" General
nnoremap <leader>l :set invlist<CR>
nnoremap <leader>h :set hls!<CR>
nnoremap / :set hls<CR>/

" Clipboard
noremap <leader>y "+y
noremap <leader>Y "+y$
noremap <leader>d "_d
noremap <leader>p "_dP

" Window Navigation (if not using Tmux navigator)
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Visual Moving
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Skim / Files
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>

" Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" NERDTree
nnoremap <leader>nn :NERDTreeFocus<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

" EasyMotion
map <Leader>/ <Plug>(easymotion-sn)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0

" Color Column Toggle
nnoremap <leader>cc :call ToggleColorColumn()<CR>
function! ToggleColorColumn()
    if &colorcolumn == ""
        let &colorcolumn="".join(range(81,winwidth(0)),",")
    else
        let &colorcolumn=""
    endif
endfunction

" Spell Check
nnoremap <leader>sp :setlocal spell!<CR>

" No Arrow Keys (Training Mode)
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" =============================================================================
" AUTOCOMMANDS & LANGUAGE SETTINGS
" =============================================================================

" ALE (Linting)
let g:ale_completion_enabled = 1
let g:ale_linters = {
            \ 'c': ['gcc'],
            \ 'rust': ['analyzer'],
            \ }
let g:ale_fixers = {
            \ 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'],
            \ 'javascript': ['prettier'],
            \ 'typescript': ['prettier'],
            \ 'json': ['prettier'],
            \ }
let g:rustfmt_autosave = 1
let g:ale_c_cc_options = '-std=gnu17 -Wall'
set omnifunc=ale#completion#OmniFunc

" ALE Mappings
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <leader>gd <Plug>(ale_go_to_definition)
nmap <silent> <leader>gr <Plug>(ale_find_references)
nmap <silent> <leader>gh <Plug>(ale_hover)

" Compilation Runner
nnoremap <leader>r :call CompileRun()<CR>

func! CompileRun()
    exec "w"
    if &filetype == 'c'
        set splitbelow
        term gcc % -o %:r.out && time ./%:r.out
    elseif &filetype == 'cpp'
        set splitbelow
        term g++ -std=c++11 % -Wall -o %< && time ./%<
    elseif &filetype == 'python'
        set splitbelow
        term python3 %
    elseif &filetype == 'go'
        set splitbelow
        term go run %
    elseif &filetype == 'rust'
        term cargo run
    endif
endfunc

" Auto-Trim Whitespace
augroup CHEN_SHI
    autocmd!
    autocmd BufWritePre * keeppatterns %s/\s\+$//e
augroup END

" TermDebug / Rust
if executable('rust-gdb')
    autocmd VimEnter *.rs let g:termdebugger="rust-gdb"
    autocmd VimEnter *.rs packadd termdebug
endif