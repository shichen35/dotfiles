local M = {
  'RRethy/vim-illuminate',
  event = { 'BufReadPost', 'BufNewFile' },
  keys = {
    { ']]', desc = 'Next Reference' },
    { '[[', desc = 'Prev Reference' },
  },
}

M.opts = {
  -- modes_denylist = { "v", "vs", "V", "Vs", "", "s" },
  filetypes_denylist = { 'alpha' },
}

function M.config(_, opts)
  require('illuminate').configure(opts)
  -- vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
  -- vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
  -- vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
  local function map(key, dir, buffer)
    vim.keymap.set('n', key, function()
      require('illuminate')['goto_' .. dir .. '_reference'](false)
    end, {
      desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference',
      buffer = buffer,
    })
  end

  map(']]', 'next')
  map('[[', 'prev')
end

return M
