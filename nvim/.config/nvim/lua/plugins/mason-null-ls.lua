return {
  "jayp0521/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "jose-elias-alvarez/null-ls.nvim",
  },
  config = function()
    require("mason-null-ls").setup {
      ensure_installed = {
        "stylua",
        "cmakelang",
        "eslint_d",
        "black",
        "isort",
        "ruff",
        "flake8",
        "clang-format",
        "google-java-format",
        "prettier",
        "fixjson",
        "shfmt",
        "shellcheck",
        "beautysh",
      },
      automatic_installation = false,
      handlers = {},
    }
  end,
}
