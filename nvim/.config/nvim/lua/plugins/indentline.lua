local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
}

M.opts = {
  char = "▏",
  show_trailing_blankline_indent = false,
  show_current_context = false,
  buftype_exclude = { "terminal", "nofile" },
  filetype_exclude = {
    "help",
    "alpha",
    "dashboard",
    "neo-tree",
  },
}

return M
