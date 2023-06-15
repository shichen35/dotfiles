vim.api.nvim_create_autocmd("TermOpen", {
  group = init_group,
  pattern = "*",
  callback = function(opts)
    vim.cmd [[set nobuflisted ]]
    vim.cmd [[setlocal scrolloff=0]]
    vim.cmd [[setlocal sidescrolloff=0]]
    vim.cmd [[setlocal nonumber]]
    vim.cmd [[setlocal norelativenumber]]
    vim.cmd [[setlocal signcolumn=auto]]
    if opts.file:match "dap%-terminal" then
      return
    end
    vim.cmd [[startinsert]]
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "enable cursorline and disable relative line number in insert mode",
  group = init_group,
  pattern = "*",
  -- command = "setlocal cul nornu",
  callback = function()
    if vim.bo.filetype:match "alpha" then
      return
    end
    vim.cmd [[setlocal cul nornu]]
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  desc = "disable cursorline and enable relative line number when leaving insert mode",
  group = init_group,
  pattern = "*",
  -- command = "setlocal nocul rnu",
  callback = function(opts)
    if vim.bo.filetype:match "alpha" then
      return
    end
    vim.cmd [[setlocal nocul rnu]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

vim.cmd [[
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
]]
