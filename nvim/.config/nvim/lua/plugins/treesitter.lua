return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
      },
    },
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "lua",
          "markdown",
          "markdown_inline",
          "vim",
          "vimdoc",
          -- 'bash',
          "html",
          "javascript",
          "typescript",
          "tsx",
          "javascript",
          "json",
          "yaml",
          "python",
          "rust",
          "c",
          "cpp",
          "hcl",
        }, -- put the language you want in this array
        -- ensure_installed = "all", -- one of "all" or a list of languages
        ignore_install = { "" }, -- List of parsers to ignore installing
        sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

        highlight = {
          enable = true, -- false will disable the whole extension
          disable = { "css", "help" }, -- list of language that will be disabled
        },
        autopairs = {
          enable = true,
        },
        indent = { enable = true, disable = { "python", "css" } },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    keys = {
      {
        "<leader>lc",
        ":TSContextToggle<CR>",
        desc = "Toggle TS Context",
        silent = true,
      },
      {
        "[c",
        function()
          -- Jump to previous change when in diffview.
          if vim.wo.diff then
            return "[c"
          else
            vim.schedule(function()
              require("treesitter-context").go_to_context()
            end)
            return "<Ignore>"
          end
        end,
        desc = "Jump to upper context",
        silent = true,
        expr = true,
      },
    },
    opts = {
      enable = false,
    },
  },
}
