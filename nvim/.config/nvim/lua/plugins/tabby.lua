return {
  "nanozuki/tabby.nvim",
  event = "VeryLazy",
  config = function()
    require("tabby.tabline").use_preset "tab_only"
  end,
}
