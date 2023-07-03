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

-- local filetypeBlackList = { "alpha", "notify", "neo-tree", "neo-tree-popup" }

-- vim.api.nvim_create_autocmd('BufEnter', {
--   pattern = '*',
--   callback = function(args)
--     vim.print(vim.bo.filetype)
--   end,
-- })
-- vim.api.nvim_create_autocmd('BufLeave', {
--   pattern = '*',
--   callback = function(args) print(args) end,
-- })

vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "enable cursorline and disable relative line number in insert mode",
  group = init_group,
  pattern = "*",
  -- command = "setlocal cul nornu",
  callback = function()
    -- for _, str in ipairs(filetypeBlackList) do
    --   if vim.bo.filetype:match(str) then
    --     return
    --   end
    -- end
    if vim.wo.number and vim.wo.relativenumber then
      vim.cmd [[setlocal cul nornu]]
    end
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  desc = "disable cursorline and enable relative line number when leaving insert mode",
  group = init_group,
  pattern = "*",
  -- command = "setlocal nocul rnu",
  callback = function()
    -- for _, str in ipairs(filetypeBlackList) do
    --   if vim.bo.filetype:match(str) then
    --     return
    --   end
    -- end
    if vim.wo.number and not vim.wo.relativenumber then
      vim.cmd [[setlocal nocul rnu]]
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "notify" },
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
