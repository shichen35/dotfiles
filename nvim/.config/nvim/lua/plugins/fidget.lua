local M = {
    'j-hui/fidget.nvim',
    event = { "DiagnosticChanged", "LspAttach" },
}

function M.config()
    require('fidget').setup()
end

return M
