local Util = require("utils")

local M = {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    { "ahmedkhalf/project.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
}

local actions = require("telescope.actions")

M.keys = {
  {
    "<leader>,",
    "<cmd>Telescope buffers show_all_buffers=true<cr>",
    desc = "Switch Buffer",
  },
  {
    "<leader>/",
    Util.telescope("live_grep"),
    desc = "Grep (root dir)",
  },
  {
    "<leader>:",
    "<cmd>Telescope command_history<cr>",
    desc = "Command History",
  },
  {
    "<leader><space>",
    Util.telescope("files"),
    desc = "Find Files (root dir)",
  },
  {
    "<leader>ff",
    Util.telescope("files", { cwd = false }),
    desc = "Find Files (cwd)",
  },
  {
    "<leader>fF",
    "<cmd>Telescope find_files search_dirs=%:p:h<cr>",
    desc = "Find Files (file dir)",
  },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
  {
    "<leader>fg",
    Util.telescope("live_grep", { cwd = false }),
    desc = "Grep (cwd)",
  },
  {
    "<leader>fG",
    "<cmd>Telescope live_grep search_dirs=%:p:h<cr>",
    desc = "Grep (file dir)",
  },
  -- git
  {
    "<leader>gc",
    "<cmd>Telescope git_commits<CR>",
    desc = "commits",
  },
  {
    "<leader>gs",
    "<cmd>Telescope git_status<CR>",
    desc = "status",
  },
  -- search
  {
    "<leader>sa",
    "<cmd>Telescope autocommands<cr>",
    desc = "Auto Commands",
  },
  {
    "<leader>sb",
    "<cmd>Telescope current_buffer_fuzzy_find<cr>",
    desc = "Buffer",
  },
  {
    "<leader>sc",
    "<cmd>Telescope command_history<cr>",
    desc = "Command History",
  },
  {
    "<leader>sC",
    "<cmd>Telescope commands<cr>",
    desc = "Commands",
  },
  {
    "<leader>sd",
    "<cmd>Telescope diagnostics bufnr=0<cr>",
    desc = "Document diagnostics",
  },
  {
    "<leader>sD",
    "<cmd>Telescope diagnostics<cr>",
    desc = "Workspace diagnostics",
  },
  {
    "<leader>sh",
    "<cmd>Telescope help_tags<cr>",
    desc = "Help Pages",
  },
  {
    "<leader>sH",
    "<cmd>Telescope highlights<cr>",
    desc = "Search Highlight Groups",
  },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
  { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
  { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
  { "<leader>sn", "<cmd>Telescope notify<cr>", desc = "Notifications" },
  { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
  { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
  {
    "<leader>sw",
    Util.telescope("grep_string", { cwd = false }),
    desc = "Word (cwd)",
  },
  {
    "<leader>sW",
    "<cmd>Telescope grep_string search_dirs=%:p:h<cr>",
    desc = "Word (file dir)",
  },
  {
    "<leader>cs",
    Util.telescope("colorscheme"),
    desc = "Colorscheme with preview",
  },
  {
    "<leader>ss",
    Util.telescope("lsp_document_symbols", {
      symbols = {
        "Class",
        "Function",
        "Method",
        "Constructor",
        "Interface",
        "Module",
        "Struct",
        "Trait",
        "Field",
        "Property",
      },
    }),
    desc = "Goto Symbol",
  },
  {
    "<leader>sS",
    Util.telescope("lsp_dynamic_workspace_symbols", {
      symbols = {
        "Class",
        "Function",
        "Method",
        "Constructor",
        "Interface",
        "Module",
        "Struct",
        "Trait",
        "Field",
        "Property",
      },
    }),
    desc = "Goto Symbol (Workspace)",
  },
}

M.opts = {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },
    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
      }),
    },
  },
}

function M.config(_, opts)
  require("telescope").setup(opts)
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("ui-select")
end

return M
