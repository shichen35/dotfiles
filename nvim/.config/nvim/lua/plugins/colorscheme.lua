local M = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    dependencies = {
      "folke/tokyonight.nvim",
    },
    config = function()
      -- load the colorscheme here
      vim.cmd.colorscheme "tokyonight"
    end,
  }
}
return M
