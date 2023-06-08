return {
  "jayp0521/mason-null-ls.nvim",
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
        "clang-format",
        "prettier",
        "fixjson",
        "shfmt",
        "shellcheck",
        "beautysh",
      },
    }
  end,
}
