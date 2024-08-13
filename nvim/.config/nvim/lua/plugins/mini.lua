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
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "NvimTree",
          "undotree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          -- vim.opt_local.cul = true
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
  },
  {
    "echasnovski/mini.bufremove",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  { "echasnovski/mini.icons", version = false },
}
