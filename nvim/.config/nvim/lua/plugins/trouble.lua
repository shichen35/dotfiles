-- better diagnostics list and others
return {
  {
    "folke/trouble.nvim",
    branch = "dev",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            pcall(vim.cmd, "cprev")
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            pcall(vim.cmd, "cnext")
          end
        end,
        desc = "Next trouble/quickfix item",
      },
      {
        "gR",
        "<cmd>TroubleToggle lsp_references<cr>",
        desc = "References List (Trouble)",
      },
    },
  },
  { "kevinhwang91/nvim-bqf", ft = "qf" },
}
