local M = {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
}

function M.config()
  require("dapui").setup({
    expand_lines = true,
    icons = { expanded = "", collapsed = "", circular = "" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.33 },
          { id = "breakpoints", size = 0.17 },
          { id = "stacks", size = 0.25 },
          { id = "watches", size = 0.25 },
        },
        size = 0.33,
        position = "right",
      },
      {
        elements = {
          { id = "repl", size = 0.45 },
          { id = "console", size = 0.55 },
        },
        size = 0.27,
        position = "bottom",
      },
    },
    floating = {
      max_height = 0.9,
      max_width = 0.5, -- Floats will be treated as percentage of your screen.
      border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
  })

  -- vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
  vim.api.nvim_set_hl(0, "Red", { fg = "#d95555" })
  vim.api.nvim_set_hl(0, "Yellow", { fg = "#efd472" })
  vim.api.nvim_set_hl(0, "Orange", { fg = "#fc6600" })
  vim.api.nvim_set_hl(0, "Green", { fg = "#98c379" })
  vim.api.nvim_set_hl(0, "Blue", { fg = "#61afef" })

  local signs = {
    { name = "DiagnosticSignError", text = "", hl = "Red" },
    { name = "DiagnosticSignWarn", text = "", hl = "Orange" },
    { name = "DiagnosticSignHint", text = "", hl = "Blue" },
    { name = "DiagnosticSignInfo", text = "", hl = "Yellow" },
    { name = "DapBreakpoint", text = "", hl = "Red" },
    { name = "DapBreakpointCondition", text = "", hl = "Red" },
    { name = "DapBreakpointRejected", text = "", hl = "Red" },
    { name = "DapLogPoint", text = "󰰍", hl = "Blue" },
    { name = "DapStopped", text = "", hl = "Green" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { text = sign.text, linehl = sign.hl, texthl = sign.hl, numhl = sign.hl })
  end
end

return M
