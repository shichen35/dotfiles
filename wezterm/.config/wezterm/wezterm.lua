-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 80
config.initial_rows = 25

-- or, changing the font size and color scheme.
config.font_size = 13
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
-- config.color_scheme = "PencilDark"
config.color_scheme = "Catppuccin Mocha"
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- config.window_decorations = "RESIZE"

-- Finally, return the configuration to wezterm:
return config
