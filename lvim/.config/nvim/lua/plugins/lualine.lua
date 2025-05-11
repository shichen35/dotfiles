local spaces = function()
  return "spaces: " .. vim.api.nvim_get_option_value("shiftwidth", {})
end

return {
  "nvim-lualine/lualine.nvim",

  opts = function(_, opts)
    local icons = LazyVim.config.icons
    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    })

    opts.sections = vim.tbl_deep_extend("force", opts.sections or {}, {
      lualine_c = {
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { LazyVim.lualine.pretty_path() },
      },
      lualine_x = {
        -- stylua: ignore
        {
          function() return "  " .. require("dap").status() end,
          cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
          color = function() return { fg = Snacks.util.color("Debug") } end,
        },
        -- stylua: ignore
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = function()
            return { fg = Snacks.util.color("Special") }
          end,
        },
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
        { "encoding" },
        {
          "filetype",
          icons_enabled = true,
        },
      },
      lualine_y = {
        { "location", padding = 0 },
      },
      lualine_z = { "progress" },
    })
  end,
}
