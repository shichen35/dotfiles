local cache_dir = vim.env.HOME .. '/.cache/nvim/'

vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.magic = true
vim.opt.showcmd = true
vim.opt.showmode = false
-- vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.cmdheight = 1
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 4
vim.opt.laststatus = 3
vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4                             -- insert 2 spaces for a tab
vim.opt.listchars = "eol:$"
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time

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
set backspace=indent,eol,start " Make backspace work as you would expect.
set shiftround
set display+=lastline          " Show as much as possible of the last line.
set noerrorbells
set incsearch
set wildmenu
" set wildmode=longest:full,full
" set wildmode=list:longest,full
set path+=**
set ttyfast
set fileformats=unix,mac
set nrformats+=alpha           " Make CTRL-A and CTRL-X work for alphabet characters
set background=dark

autocmd InsertEnter * set cul nornu
autocmd InsertLeave * set nocul rnu

let g:colour_scheme_list = ['nord', 'gruvbox']

hi CursorLine cterm=bold ctermbg=233
"hi Search ctermfg=NONE ctermbg=237 cterm=bold
]])

