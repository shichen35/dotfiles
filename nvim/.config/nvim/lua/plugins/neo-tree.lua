return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>NeoTreeFocusToggle<CR>", desc = "Toggle NeoTree Explorer" },
  },
  event = "VimEnter",
  opts = {
    close_if_last_window = true,              -- Close Neo-tree if it is the last window left in the tab
    filesystem = {
      follow_current_file = true,             -- This will find and focus the file in the active buffer every
      -- time the current file is changed while the tree is open.
      group_empty_dirs = true,                -- when true, empty folders will be grouped together
      hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree
    },
  },
}
