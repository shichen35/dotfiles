return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  event = { "BufRead", "BufNewFile" },
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    attach_navic = false,
    -- configurations go here
    exclude_filetypes = {
      "neo-tree",
      "undotree",
      "toggleterm",
      "Trouble",
    },
  },
}
