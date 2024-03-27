return {
  "mg979/vim-visual-multi",
  event = "VeryLazy",
  init = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",
      ["Find Subword Under"] = "<C-n>",
      ["Goto Next"] = "n",
      ["Goto Prev"] = "N",
      ["Skip Region"] = "q",
      ["Remove Region"] = "Q",
      ["Add Cursor Down"] = "<C-Down>",
      ["Add Cursor Up"] = "<C-Up>",
      ["Add Cursor At Pos"] = "<leader>mp",
      ["Select All"] = "<leader>ma",
      ["Visual All"] = "<leader>ma",
      -- ["Start Regex Search"] = "<C-/>",
      ["Exit"] = "<Esc>",
    }
  end,
}
