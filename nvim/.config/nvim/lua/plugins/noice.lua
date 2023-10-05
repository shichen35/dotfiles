-- local M = {
--   "j-hui/fidget.nvim",
--   event = { "DiagnosticChanged", "LspAttach" },
--   config = true,
-- }
--
-- return M

return {
  "folke/noice.nvim",
  lazy = false,
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    -- "rcarriga/nvim-notify",
  },
  opts = {
    -- add any options here
    messages = {
      enabled = true,              -- enables the Noice messages UI
      view = "notify",             -- default view for messages
      view_error = "notify",       -- view for errors
      view_warn = "notify",        -- view for warnings
      view_history = "messages",   -- view for :messages
      view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
    },
    routes = {
      {
        view = "notify",
        filter = { event = "msg_showmode" },
      },
      {
        view = "popup",
        filter = {
          any = {
            { event = "msg_show", min_height = 10 },
            { event = "msg_show", min_width = 200 },
          },
        },
      },
      -- {
      --   filter = {
      --     event = "msg_show",
      --     kind = "",
      --     find = "more line",
      --   },
      --   opts = { skip = true },
      -- },
    },
  },
}
