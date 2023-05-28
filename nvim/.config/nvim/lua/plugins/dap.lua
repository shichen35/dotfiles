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

  require("plugins.daps.adapters.lldb")
  require("plugins.daps.settings.c")
  require("plugins.daps.settings.cpp")
  require("plugins.daps.settings.rust")
end
},
{
  "ravenxrz/DAPInstall.nvim",
  lazy = true,
  config = function()
      require("dap_install").setup {}
      require("dap_install").config("rust", {})
  end
}
}
return M
