local M = {
  "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
}

M.opts = {
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh",
    },
  },
  color_icons = true,
  default = true,
}

return M
