local wezterm = require("wezterm")
local act = wezterm.action
local config = {
	font_size = 13,
	line_height = 1.1,
	-- font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Regular" }),
	font = wezterm.font("Maple Mono NF", { weight = "Regular" }),
	-- font = wezterm.font("Hack Nerd Font", { weight = "Regular" }),

	-- color_scheme = "Catppuccin Mocha",
	-- color_scheme = "Batman",
	color_scheme = "Dracula",
	-- color_scheme = "Gruvbox dark",
	colors = {
		background = "#2c2525",
	},
	-- term = "xterm-256color",
	animation_fps = 60,
	max_fps = 60,

	underline_thickness = 5,
	underline_position = -8,

	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = "RESIZE",
	show_new_tab_button_in_tab_bar = false,
	window_background_opacity = 1,
	text_background_opacity = 1,
	macos_window_background_blur = 90,
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
			key = "x",
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
			key = "g",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ key = "\\" }),
				act.SendKey({ key = "l" }),
				act.SendKey({ key = "z" }),
			}),
		},
		{
			key = "s",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ key = "\\" }),
				act.SendKey({ key = "l" }),
				act.SendKey({ key = "q" }),
			}),
		},
		{
			key = "Enter",
			mods = "CTRL",
			action = act.Multiple({
				act.SendKey({ key = "\\" }),
				act.SendKey({ key = "c" }),
				act.SendKey({ key = "a" }),
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
		---------- debug
		{
			key = "9",
			mods = "CTRL",
			action = act.Multiple({
				act.SendKey({ key = " " }),
				act.SendKey({ key = "d" }),
				act.SendKey({ key = "e" }),
			}),
		},
		{
			key = "1",
			mods = "CTRL",
			action = act.Multiple({
				act.SendKey({ key = " " }),
				act.SendKey({ key = "d" }),
				act.SendKey({ key = "O" }),
			}),
		},
		{
			key = "-",
			mods = "CTRL",
			action = act.Multiple({
				act.SendKey({ key = " " }),
				act.SendKey({ key = "d" }),
				act.SendKey({ key = "i" }),
			}),
		},
		{
			key = "=",
			mods = "CTRL",
			action = act.Multiple({
				act.SendKey({ key = " " }),
				act.SendKey({ key = "d" }),
				act.SendKey({ key = "o" }),
			}),
		},
		{
			key = "r",
			mods = "CTRL",
			action = act.Multiple({
				act.SendKey({ key = " " }),
				act.SendKey({ key = "d" }),
				act.SendKey({ key = "c" }),
			}),
		},
		{
			key = "0",
			mods = "CTRL",
			action = act.Multiple({
				act.SendKey({ key = " " }),
				act.SendKey({ key = "d" }),
				act.SendKey({ key = "b" }),
			}),
		},
	},
}

-- local colors = require('colors.custom')
-- config.background = {
-- 	-- This is the deepest/back-most layer. It will be rendered first
-- 	{
-- 		source = {
-- 			File = '/Users/apple/Downloads/bg.jpg',
-- 		},
-- 		{
-- 			source = { Color = colors.background },
-- 			height = '100%',
-- 			width = '100%',
-- 			opacity = 0.96,
-- 		},
-- 		-- hsb = dimmer,
-- 		-- When the viewport scrolls, move this layer 10% of the number of
-- 		-- pixels moved by the main viewport. This makes it appear to be
-- 		-- further behind the text.
-- 		attachment = { Parallax = 0.1 },
-- 	}
-- }

return config
