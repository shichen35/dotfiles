return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "NvimTree Explorer" },
    {
      "<leader>fe",
      function()
        require("nvim-tree.api").tree.find_file({
          update_root = true,
          open = true,
          focus = true,
        })
      end,
      desc = "Nvim Tree Find File",
    },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      -- temporary fix for the floating window: https://github.com/nvim-tree/nvim-tree.lua/issues/2749
      hijack_netrw = false,
      sync_root_with_cwd = true,
      view = {
        -- width = 35,
        -- relativenumber = true,
        -- side = "right",
        float = {
          enable = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 40,
            height = 22,
            row = 0,
            col = 0,
          },
        },
      },
      filters = {
        custom = { "^.git$" },
      },
      git = { enable = true, ignore = true },
      update_focused_file = {
        enable = false,
        update_root = true,
        ignore_list = { "help" },
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      modified = {
        enable = true,
      },
      actions = {
        change_dir = {
          global = true,
        },
        open_file = {
          resize_window = true,
          quit_on_open = true,
        },
        file_popup = {
          open_win_config = {
            border = vim.g.FloatBorders,
          },
        },
      },

      renderer = {
        highlight_opened_files = "name",
        icons = {
          git_placement = "before",
          glyphs = {
            --     ignored = "◌",
            --   },
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "󰛿",
              untracked = "",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
    })
  end,
}
