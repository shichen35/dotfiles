return {
  'mbbill/undotree',
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" }
  },
  config = function()
    local cache_dir = vim.env.HOME .. '/.cache/nvim/'
    if vim.fn.has("persistent_undo") then
      local undodir = cache_dir .. '/undodir'
      -- create the undo directory
      -- if the location does not exist.
      if vim.fn.isdirectory(undodir) == 0 then
        vim.fn.mkdir(undodir, "p")
      end
      vim.opt.undodir = undodir
      vim.opt.undofile = true
    end
  end
}

