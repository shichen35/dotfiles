vim.cmd([[
" set mouse=a
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
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set hls
set smartcase
set ignorecase
set wildmenu
" set wildmode=longest:full,full
" set wildmode=list:longest,full
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
" set omnifunc=ale#completion#OmniFunc

autocmd InsertEnter * set cul nornu
autocmd InsertLeave * set nocul rnu

set background=dark
colorscheme gruvbox
hi CursorLine term=bold cterm=bold ctermbg=233
"hi Search ctermfg=NONE ctermbg=237 cterm=bold


]])
