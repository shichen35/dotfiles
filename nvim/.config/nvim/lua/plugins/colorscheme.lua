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
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  -- },
  -- {
  --   "RRethy/nvim-base16",
  --   lazy = false,
  -- },
}
return M
