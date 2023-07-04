local M = {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
}

M.opts = {
  -- modes_denylist = { "v", "vs", "V", "Vs", "", "s" },
  filetypes_denylist = { "alpha" },
}

function M.config(_, opts)
  require("illuminate").configure(opts)
  -- vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
  -- vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
  -- vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
end

return M
