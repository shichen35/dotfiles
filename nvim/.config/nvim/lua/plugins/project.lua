local M = {
  "ahmedkhalf/project.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  -- event = "VeryLazy",
  event = "Bufenter",
  cmd = { "Telescope" },
  keys = {
    { "<leader>pr", "<cmd>ProjectRoot<cr>", desc = "Change to Project Root" },
    { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "List projects" },
  },
}

function M.config()
  local project = require "project_nvim"
  project.setup {
    manual_mode = true,
    detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
    -- detection_methods = { "pattern" },

    -- patterns used to detect root dir, when **"pattern"** is in detection_methods
    patterns = { ".git", "Makefile", "CMakeLists.txt", "package.json" },

    silent_chdir = false,
  }

  local telescope = require "telescope"
  telescope.load_extension "projects"
end

return M
