return {
  "stevearc/oil.nvim",
  keys = {
    {
      "<leader>E",
      function()
        require("oil").toggle_float()
      end,
      mode = "n",
      desc = "Oil File Explorer",
    },
  },
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    require("oil").setup({})
  end,
}
