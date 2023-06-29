local dap = require "dap"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = (vim.fn.executable "lldb-vscode") and "lldb-vscode" or "codelldb",
    args = { "--port", "${port}" },
    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}

dap.adapters.c = dap.adapters.codelldb
dap.adapters.cpp = dap.adapters.codelldb
dap.adapters.cppdbg = dap.adapters.codelldb
dap.adapters.rust = dap.adapters.codelldb
