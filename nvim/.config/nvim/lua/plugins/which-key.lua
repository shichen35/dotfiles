local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      mode = { "n", "v" },
      { "<leader><tab>", group = "tabs" },
      { "<leader>d", group = "debug" },
      { "<leader>f", group = "file/find" },
      { "<leader>g", group = "git" },
      { "<leader>l", group = "lsp" },
      { "<leader>s", group = "search" },
      { "<leader>t", group = "task" },
      { "<leader>x", group = "diagnostics/quickfix" },
    })
  end,
}

return M
