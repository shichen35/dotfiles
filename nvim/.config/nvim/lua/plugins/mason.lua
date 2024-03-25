local M = {
  'williamboman/mason.nvim',
  build = ':MasonUpdate',
  cmd = { 'Mason', 'MasonInstall' },
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
}

local settings = {
  ui = {
    border = 'none',
    icons = {
      package_installed = '◍',
      package_pending = '◍',
      package_uninstalled = '◍',
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

function M.config()
  require('mason').setup(settings)
  require('mason-lspconfig').setup()
end

return M
