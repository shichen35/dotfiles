-- local M = {
--   {
--     'catppuccin/nvim',
--     name = 'catppuccin',
--     lazy = false,
--     priority = 1000,
--     dependencies = {
--       'folke/tokyonight.nvim',
--       {
--         'sainnhe/gruvbox-material',
--         init = function()
--           vim.g.gruvbox_material_better_performance = 1
--           vim.g.gruvbox_material_foreground = 'mix'
--           vim.g.gruvbox_material_background = 'hard'
--         end,
--       },
--     },
--     config = function()
--       -- load the colorscheme here
--       vim.cmd.colorscheme 'gruvbox-material'
--     end,
--   },
-- }
-- return M

return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  dependencies = {
    {
      "catppuccin/nvim",
      name = "catppuccin",
    },
    "folke/tokyonight.nvim",
  },
  init = function()
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_foreground = "mix"
    vim.g.gruvbox_material_background = "hard"
  end,
  config = function()
    -- load the colorscheme here
    vim.cmd.colorscheme("catppuccin-macchiato")
    -- vim.cmd.colorscheme("catppuccin-mocha")
    -- vim.cmd.colorscheme("gruvbox")
  end,
}
