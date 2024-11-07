return {
  "github/copilot.vim",
  event = "VeryLazy",
  config = function()
    vim.cmd([[
      imap <silent><script><expr> <Right> copilot#Accept("\<CR>")
      let g:copilot_no_tab_map = v:true
    ]])
  end
}
