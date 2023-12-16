local dap = require 'dap'
local mason_registry = require 'mason-registry'
local codelldb_root = mason_registry.get_package('codelldb'):get_install_path()
  .. '/'
local codelldb_path = codelldb_root .. 'codelldb'

dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = codelldb_path,
    args = { '--port', '${port}' },
    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}

dap.adapters.c = dap.adapters.codelldb
dap.adapters.cpp = dap.adapters.codelldb
dap.adapters.cppdbg = dap.adapters.codelldb
dap.adapters.rust = dap.adapters.codelldb
