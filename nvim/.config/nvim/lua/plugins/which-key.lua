local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)
    wk.register {
      mode = { 'n', 'v' },
      -- ["g"] = { name = "+goto" },
      -- ["gs"] = { name = "+surround" },
      -- ["]"] = { name = "+next" },
      -- ["["] = { name = "+prev" },
      ['<leader><tab>'] = { name = '+tabs' },
      ['<leader>d'] = { name = '+debug' },
      ['<leader>l'] = { name = '+lsp' },
      ['<leader>f'] = { name = '+file/find' },
      ['<leader>g'] = { name = '+git' },
      -- ["<leader>q"] = { name = "+quit/session" },
      ['<leader>s'] = { name = '+search' },
      ['<leader>t'] = { name = '+task' },
      -- ["<leader>u"] = { name = "+ui" },
      -- ["<leader>w"] = { name = "+windows" },
      ['<leader>x'] = { name = '+diagnostics/quickfix' },
    }
  end,
}

return M
