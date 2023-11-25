local M = {
  "mfussenegger/nvim-dap",
  -- ft = {
  --   "c",
  --   "cpp",
  --   "rust",
  --   "go"
  -- },
  -- DAP
  keys = {
    { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint", silent = true },
    { "<F5>", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", silent = true },
    { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", silent = true },
    { "<F10>", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", silent = true },
    { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", silent = true },
    { "<F11>", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", silent = true },
    { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", silent = true },
    { "<s-F11>", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", silent = true },
    { "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", silent = true },
    { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl", silent = true },
    { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Run Last", silent = true },
    { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle UI", silent = true },
    { "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", desc = "Terminate", silent = true },
  },
  config = function()
    local dap = require "dap"

    local dap_ui_status_ok, dapui = pcall(require, "dapui")
    if not dap_ui_status_ok then
      return
    end

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    require "plugins.daps.adapters.lldb"
    require "plugins.daps.settings.c"
    require "plugins.daps.settings.cpp"
    require "plugins.daps.settings.rust"

    -- require("dap.ext.vscode").load_launchjs()
    require("dap.ext.vscode").load_launchjs(
      vim.fn.getcwd() .. "/.neovim" .. "/launch.json",
      { cppdbg = { "c", "cpp" } }
    )
  end,
}

return M
