local cache_dir = vim.env.HOME .. '/.cache/nvim/'

vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.magic = true
vim.opt.showcmd = true
vim.opt.showmode = false
vim.opt.cmdheight = 1
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 4
vim.opt.laststatus = 3

-- Use space as <leader>
vim.g.mapleader = ' '

if vim.fn.has("persistent_undo") then
   local undodir = cache_dir .. '/undodir'
    -- create the undo directory
    -- if the location does not exist.
    if vim.fn.isdirectory(undodir) == 0 then
        vim.fn.mkdir(undodir,"p")
    end
    vim.opt.undodir = undodir
    vim.opt.undofile = true
end

-- Set updatetime for CursorHold
-- 300ms of no cursor movement to trigger CursorHold
vim.api.nvim_set_option('updatetime', 300)

vim.cmd([[
set mouse=
"set mouse=a
set backspace=indent,eol,start " Make backspace work as you would expect.
set shiftwidth=4
set shiftround
set tabstop=4 softtabstop=4
set expandtab
set autoindent
set display+=lastline          " Show as much as possible of the last line.
set splitright                 " Vertical windows should be split to right
set splitbelow                 " Horizontal windows should split to bottom
set noerrorbells
set nowrap
set noswapfile
set nobackup
set nowritebackup
set incsearch
set hls
set smartcase
set ignorecase
set wildmenu
" set wildmode=longest:full,full
" set wildmode=list:longest,full
set path+=**
set nu rnu
set ttyfast
set encoding=utf-8
set fileformats=unix,mac
set nrformats+=alpha           " Make CTRL-A and CTRL-X work for alphabet characters
set background=dark

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

autocmd InsertEnter * set cul nornu
autocmd InsertLeave * set nocul rnu

"colorscheme gruvbox
colorscheme nord
let g:colour_scheme_list = ['nord', 'gruvbox']

hi CursorLine cterm=bold ctermbg=233
"hi Search ctermfg=NONE ctermbg=237 cterm=bold
]])

