return {
  'Exafunction/codeium.vim',
  enabled = function()
    return not string.match(vim.env.HOME, 'termux')
  end,
  init = function()
    vim.g.codeium_disable_bindings = 1
  end,
  event = { 'InsertEnter' },
  cmd = { 'Codeium' },
  keys = {
    {
      '<M-\\>',
      function()
        return vim.fn['codeium#Accept']()
      end,
      expr = true,
      mode = 'i',
    },
    {
      '<M-k>',
      function()
        return vim.fn['codeium#CycleCompletions'](1)
      end,
      expr = true,
      mode = 'i',
    },
    {
      '<M-j>',
      function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end,
      expr = true,
      mode = 'i',
    },
    {
      '<M-x>',
      function()
        return vim.fn['codeium#Clear']()
      end,
      expr = true,
      mode = 'i',
    },
  },
}
