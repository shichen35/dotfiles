return {
  "stevearc/overseer.nvim",
  keys = {
    {
      "<leader>tt",
      ":OverseerToggle<cr>",
      desc = "Overseer List Toggle",
    },
    { "<leader>tr", ":OverseerRun<cr>", desc = "Overseer Run" },
    {
      "<leader>tR",
      ":OverseerRunCmd<cr>",
      desc = "Overseer Run Cmd",
    },
    { "<leader>ti", ":OverseerInfo<cr>", desc = "Overseer Info" },
    {
      "<leader>ta",
      "<cmd>OverseerTaskAction<cr>",
      desc = "Overseer Task Action",
    },
    { "<leader>tb", "<cmd>OverseerBuild<cr>", desc = "Overseer Build" },
    { "<leader>tc", "<cmd>OverseerClose<cr>", desc = "Overseer Close" },
    {
      "<leader>td",
      "<cmd>OverseerDeleteBundle<cr>",
      desc = "Overseer Delete Bundle",
    },
    {
      "<leader>tl",
      "<cmd>OverseerLoadBundle<cr>",
      desc = "Overseer Load Bundle",
    },
    { "<leader>to", "<cmd>OverseerOpen<cr>", desc = "Overseer Open" },
    {
      "<leader>tq",
      "<cmd>OverseerQuickAction<cr>",
      desc = "Overseer Quick Action",
    },
    {
      "<leader>ts",
      "<cmd>OverseerSaveBundle<cr>",
      desc = "Overseer Save Bundle",
    },
  },
  config = function()
    require("overseer").setup({
      templates = {
        "builtin",
        "user.cmake-build",
        "user.cmake-configure",
        "user.cmake-rm-build",
      },
    })
  end,
}
