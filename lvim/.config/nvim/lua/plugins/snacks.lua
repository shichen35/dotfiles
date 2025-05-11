vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
-- stylua: ignore
-- local local_header = [[
--  ██████   █████                   █████   █████  ███                 
-- ░░██████ ░░███                   ░░███   ░░███  ░░░                  
--  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████  
--  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███ 
--  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███ 
--  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███ 
--  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████
-- ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ 
-- ]]

-- stylua: ignore
-- local local_header = [[
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
-- ]]

-- stylua: ignore
local local_header = [[

           ▄ ▄                   
       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     
       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     
    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     
  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  
  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄
▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █
█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █
    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    
]]

return {
  "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        --         header = [[
        --                                __
        --   ___     ___    ___   __  __ /\_\    ___ ___
        --  / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\
        -- /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \
        -- \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
        --  \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/
        --  ]],

        header = { local_header, align = "center", hl = "special" },
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          -- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          -- { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          -- { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          -- { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header", padding = 1 },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
