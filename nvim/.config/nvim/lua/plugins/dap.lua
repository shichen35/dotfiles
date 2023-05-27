local M = {
  {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
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

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
      command = "codelldb",
      args = { "--port", "${port}" },
      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }
  -- C, CPP, and Rust use codelldb.
  dap.adapters.c = dap.adapters.codelldb
  dap.adapters.cpp = dap.adapters.codelldb
  dap.adapters.rust = dap.adapters.codelldb

  dap.configurations.c = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to exe/dll: ", vim.fn.getcwd() .. "/target/debug/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
  -- CPP and Rust use C configurations.
  dap.configurations.cpp = dap.configurations.c
  dap.configurations.rust = dap.configurations.c
end
  },
{
  "ravenxrz/DAPInstall.nvim",
  lazy = true,
  config = function()
    require("dap_install").setup {}
    require("dap_install").config("python", {})
    require("dap_install").config("rust", {})
  end,
}
}
return M
