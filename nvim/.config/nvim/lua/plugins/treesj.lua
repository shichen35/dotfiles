return {
  "Wansmer/treesj",
  keys = {
    { "<space>j", nil, desc = "Toggle Split/join" },
    { "<space>J", nil, desc = "Toggle Split/join with recursive" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup({
      ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
      use_default_keymaps = false,
      ---@type boolean Node with syntax error will not be formatted
      check_syntax_error = true,
      ---If line after join will be longer than max value,
      ---@type number If line after join will be longer than max value, node will not be formatted
      max_join_length = 120,
      ---Cursor behavior:
      ---hold - cursor follows the node/place on which it was called
      ---start - cursor jumps to the first symbol of the node being formatted
      ---end - cursor jumps to the last symbol of the node being formatted
      ---@type 'hold'|'start'|'end'
      cursor_behavior = "hold",
      ---@type boolean Notify about possible problems or not
      notify = true,
      ---@type boolean Use `dot` for repeat action
      dot_repeat = true,
      ---@type nil|function Callback for treesj error handler. func (err_text, level, ...other_text)
      on_error = nil,
      ---@type table Presets for languages
      -- langs = {}, -- See the default presets in lua/treesj/langs
    })
    -- For use default preset and it work with dot
    vim.keymap.set("n", "<leader>j", require("treesj").toggle)
    -- For extending default preset with `recursive = true`, but this doesn't work with dot
    vim.keymap.set("n", "<leader>J", function()
      require("treesj").toggle({ split = { recursive = true } })
    end)
  end,
}
