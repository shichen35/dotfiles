local M = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      -- load the colorscheme here
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "folke/tokyonight.nvim",
    keys = { "<leader>cs" },
  },
  {
    "RRethy/nvim-base16",
    keys = { "<leader>cs" },
  },
}
return M
