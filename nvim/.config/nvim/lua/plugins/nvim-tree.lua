return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = 'NvimTree Explorer' },
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      sync_root_with_cwd = true,
      view = {
        width = 35,
        relativenumber = true,
      },
      filters = {
        custom = { '^.git$' },
      },
      git = { enable = true, ignore = true },
      update_focused_file = {
        enable = false,
        update_root = true,
        ignore_list = { 'help' },
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = '',
          info = '',
          warning = '',
          error = '',
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
        highlight_opened_files = 'name',
        icons = {
          git_placement = 'before',
          glyphs = {
--     ignored = "◌",
--   },
            git = {
              unstaged = '',
              staged = '',
              unmerged = '',
              renamed = '󰛿',
              untracked = '',
              deleted = '',
              ignored = '◌',
            },
          },
        },
      },
    }
  end,
}
