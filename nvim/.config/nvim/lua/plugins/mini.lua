-- active indent guide and indent text objects
return {
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "notify" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "echasnovski/mini.align",
    keys = {
      { "<leader>ga", desc = "Align with Preview", mode = { "x" } },
    },
    opts = {
      mappings = {
        start = "",
        start_with_preview = "<leader>ga",
      },
    },
    config = function(_, opts)
      require("mini.align").setup(opts)
    end,
  },
  {
    "echasnovski/mini.splitjoin",
    keys = {
      { "<leader>gs", desc = "Toggle split and join arguments" },
    },
    opts = {
      mappings = {
        toggle = "<leader>gs",
      },
    },
    config = function(_, opts)
      require("mini.splitjoin").setup(opts)
    end,
  },
}
