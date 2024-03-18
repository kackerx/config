local wezterm = require("wezterm")
local act = wezterm.action

local config = {
	font_size = 15,
	-- font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Regular" }),
	font = wezterm.font("Maple Mono SC NF", { weight = "Regular" }),
	-- font = wezterm.font("Hack Nerd Font", { weight = "Regular" }),
	-- color_scheme = "Catppuccin Mocha",
	color_scheme = "Dracula",

	underline_thickness = 2,
	underline_position = -4,

	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = "RESIZE",
	show_new_tab_button_in_tab_bar = false,
	window_background_opacity = 0.8,
	text_background_opacity = 0.8,
	macos_window_background_blur = 70,
	adjust_window_size_when_changing_font_size = false,

	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 5,
	},

	keys = {
		-- { key = "1", mods = "CMD", action = 'SendString("<C-w>h")' },
		{
			key = "1",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ key = "w", mods = "CTRL" }),
				act.SendKey({ key = "w" }),
			}),
		},
		{
			key = "w",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ key = "\\" }),
				act.SendKey({ key = "w" }),
				act.SendKey({ key = "x" }),
			}),
		},
		{
			key = "2",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ key = "y", mods = "CTRL" }),
			}),
		},
		{
			key = "t",
			mods = "CMD|SHIFT",
			action = act.Multiple({
				act.SendKey({ key = "\\" }),
				act.SendKey({ key = "w" }),
				act.SendKey({ key = "l" }),
			}),
		},
		{
			key = "d",
			mods = "CTRL",
			action = act.Multiple({
				act.SendKey({ key = "\\" }),
				act.SendKey({ key = "b" }),
				act.SendKey({ key = "k" }),
			}),
		},
		{
			key = "d",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ key = "i", mods = "CTRL" }),
			}),
		},
		{
			key = "u",
			mods = "CMD|SHIFT",
			action = act.Multiple({
				act.SendKey({ key = "\\" }),
				act.SendKey({ key = "l" }),
				act.SendKey({ key = "l" }),
			}),
		},
		{
			key = "f",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ key = "o", mods = "CTRL" }),
			}),
		},
		{
			key = "o",
			mods = "CTRL",
			action = act.Multiple({
				act.SendKey({ key = "\\" }),
				act.SendKey({ key = "b" }),
				act.SendKey({ key = "j" }),
			}),
		},
		{
			key = "a",
			mods = "CTRL",
			action = act.Multiple({
				act.SendKey({ key = "\\" }),
				act.SendKey({ key = "b" }),
				act.SendKey({ key = "j" }),
			}),
		},
		{
			key = "b",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ key = "\\" }),
				act.SendKey({ key = "w" }),
				act.SendKey({ key = "b" }),
			}),
		},
		{
			key = "j",
			mods = "CTRL",
			action = act.Multiple({
				act.SendKey({ key = "n", mods = "CTRL" }),
			}),
		},
		{
			key = "k",
			mods = "CTRL",
			action = act.Multiple({
				act.SendKey({ key = "p", mods = "CTRL" }),
			}),
		},
	},
}

return config
