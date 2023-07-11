local M = {
  "goolord/alpha-nvim",
  event = "VimEnter",
  keys = {
    { "<leader>al", ":Alpha<CR>", silent = true, desc = "Alpha Dashboard" },
  },
}

function M.config()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'AlphaReady',
    desc = 'hide cursor for alpha',
    callback = function()
      -- local hl = vim.api.nvim_get_hl_by_name('Cursor', true)
      -- hl.blend = 100
      -- vim.api.nvim_set_hl(0, 'Cursor', hl)
      -- vim.opt.guicursor:append('a:Cursor/lCursor')
      vim.opt.cursorline = true
    end,
  })
  vim.api.nvim_create_autocmd('BufUnload', {
    buffer = 0,
    desc = 'show cursor after alpha',
    callback = function()
      -- local hl = vim.api.nvim_get_hl_by_name('Cursor', true)
      -- hl.blend = 0
      -- vim.api.nvim_set_hl(0, 'Cursor', hl)
      -- vim.opt.guicursor:remove('a:Cursor/lCursor')
      vim.opt.cursorline = false
    end,
  })

  local alpha = require "alpha"
  local dashboard = require "alpha.themes.dashboard"
  -- local alphaterm = require "alpha.term"

  dashboard.section.header.val = {
    "           ▄ ▄                   ",
    "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
    "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
    "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
    "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
    "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
    "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
    "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
    "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
    -- "",
    -- "",
  }
    -- dashboard.section.header.val = {
    --   "",
    --   "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
    --   "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
    --   "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
    --   "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
    --   "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
    --   "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
    --   "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
    --   " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
    --   " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
    --   "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
    --   "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
    --   "",
    -- }
  -- dashboard.section.header.val = {
  --   [[                               __                ]],
  --   [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
  --   [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
  --   [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
  --   [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
  --   [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
  -- }
  dashboard.section.buttons.val = {
    dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert<CR>"),
    dashboard.button("p", " " .. " Projects", ":lua require('telescope').extensions.projects.projects()<CR>"),
    dashboard.button("r", "󰄉 " .. " Recent files", ":Telescope oldfiles<CR>"),
    -- dashboard.button("f", " " .. " Find file", ":Telescope find_files<CR>"),
    -- dashboard.button("g", " " .. " Find text", ":Telescope live_grep<CR>"),
    dashboard.button("c", " " .. " Config", ":e $MYVIMRC<CR>"),
    -- dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
    dashboard.button("q", " " .. " Quit", ":qa<CR>"),
  }
  local function footer()
    return "Chen Shi"
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Type"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Keyword"

  dashboard.opts.opts.noautocmd = true

  -- local width = 46
  -- local height = 25 -- two pixels per vertical space
  -- dashboard.section.terminal.command = "cat | " .. os.getenv("HOME") .. "/.dotfiles/art/thisisfine.sh"
  -- dashboard.section.terminal.width = width
  -- dashboard.section.terminal.height = height
  -- dashboard.section.terminal.opts.redraw = true

  dashboard.config.layout = {
    -- { type = "padding", val = 1 },
    -- dashboard.section.terminal,
    { type = "padding", val = 1 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    -- { type = "padding", val = 1 },
    dashboard.section.footer,
  }

  alpha.setup(dashboard.opts)

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end

return M
