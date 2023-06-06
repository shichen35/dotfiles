local M = {
  "kyazdani42/nvim-tree.lua",
  event = "VimEnter",
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" }
  }
}

function M.config()
  local tree_cb = require("nvim-tree.config").nvim_tree_callback
  require("nvim-tree").setup {
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    actions = {
      change_dir = {
        enable = true,
        global = true,
        restrict_above_cwd = false,
      }
    },
    renderer = {
      icons = {
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            arrow_open = "",
            arrow_closed = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            untracked = "U",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = {
        hint = "󰌵",
        info = "",
        warning = "",
        error = "",
      },
    },
    -- view = {
    --   width = 30,
    --   side = "left",
    --   mappings = {
    --     list = {
    --       { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
    --       { key = "h",                  cb = tree_cb "close_node" },
    --       { key = "v",                  cb = tree_cb "vsplit" },
    --     },
    --   },
    -- },
  }
end

return M
