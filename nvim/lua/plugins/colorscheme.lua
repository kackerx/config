return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = { style = "night" },
	},

	{
		"catppuccin/nvim",
		lazy = true,
	},
	{
		"loctvl842/monokai-pro.nvim",
		lazy = false,
		enabled = true,
		priority = 1000,
		keys = { { "<leader>C", "<cmd>MonokaiProSelect<cr>", desc = "Select Moonokai pro filter" } },
		opts = {
			transparent_background = false,
			devicons = true,
			filter = "ristretto", -- classic | octagon | pro | machine | ristretto | spectrum
			inc_search = "background", -- underline | background
			background_clear = {
				"nvim-tree",
				"neo-tree",
				"bufferline",
				"telescope",
				"float_win",
				"toggleterm",
			},
			plugins = {
				bufferline = {
					underline_selected = false,
					underline_visible = false,
					underline_fill = false,
					bold = true,
				},
				indent_blankline = {
					context_highlight = "pro", -- default | pro
					context_start_underline = true,
				},
			},
			override = function(c)
				return {
					ColorColumn = { bg = c.editor.background },
					-- Mine
					DashboardRecent = { fg = c.base.magenta },
					DashboardProject = { fg = c.base.blue },
					DashboardConfiguration = { fg = c.base.white },
					DashboardSession = { fg = c.base.green },
					DashboardLazy = { fg = c.base.cyan },
					DashboardServer = { fg = c.base.yellow },
					DashboardQuit = { fg = c.base.red },
					IndentBlanklineChar = { fg = c.base.dimmed4 },
					-- mini.hipatterns
					MiniHipatternsFixme = { fg = c.base.black, bg = c.base.red, bold = true }, -- FIXME
					MiniHipatternsTodo = { fg = c.base.black, bg = c.base.blue, bold = true }, -- TODO
					MiniHipatternsHack = { fg = c.base.black, bg = c.base.yellow, bold = true }, -- HACK
					MiniHipatternsNote = { fg = c.base.black, bg = c.base.green, bold = true }, -- NOTE
				}
			end,
			overridePalette = function(filter)
				-- if filter == "pro" then
				--   return {
				--     dark2 = "#101014",
				--     dark1 = "#16161E",
				--     background = "#1A1B26",
				--     text = "#C0CAF5",
				--     accent1 = "#f7768e",
				--     accent2 = "#7aa2f7",
				--     accent3 = "#e0af68",
				--     accent4 = "#9ece6a",
				--     accent5 = "#0DB9D7",
				--     accent6 = "#9d7cd8",
				--     dimmed1 = "#737aa2",
				--     dimmed2 = "#787c99",
				--     dimmed3 = "#363b54",
				--     dimmed4 = "#363b54",
				--     dimmed5 = "#16161e",
				--   }
				-- end
			end,
		},
		config = function(_, opts)
			local monokai = require("monokai-pro")
			monokai.setup(opts)
			monokai.load()
			vim.api.nvim_command("highlight k.keyword guifg=#ff8ebe guibg=None")
			vim.api.nvim_command("highlight k.parameter guifg=#fc9867 guibg=None")
			vim.api.nvim_command("highlight k.function.call guifg=#fc6a5d guibg=None")
			vim.api.nvim_command("highlight k.property guifg=#bddb9e guibg=None")
			-- vim.api.nvim_command("highlight k.string guifg=#f6d38e guibg=None")
			vim.api.nvim_command("highlight k.string guifg=#FCBD60 guibg=None")
			vim.api.nvim_command("highlight k.type.definition guifg=#ffe4b5 guibg=None")
			vim.api.nvim_command("highlight k.function.method guifg=#bddb9e guibg=None")
			vim.api.nvim_command("highlight k.function.method.call guifg=#ff6188 guibg=None")
			vim.api.nvim_command("highlight k.variable guifg=#fafff0 guibg=None")
			vim.api.nvim_command("highlight k.operator guifg=#ee9089 guibg=None")
			vim.api.nvim_command("highlight k.number guifg=#D29A62 guibg=None")
			-- vim.api.nvim_command("highlight k.number guifg=#50e3b5 guibg=None")
			vim.api.nvim_command("highlight k.constant guifg=#fcbd60 guibg=None")
			vim.api.nvim_command("highlight k.return guifg=#9ca6b0 guibg=None")
			vim.api.nvim_command("highlight k.bracket guifg=#939293 guibg=None")
			vim.api.nvim_command("highlight k.module guifg=#78dce8 guibg=None")
			vim.api.nvim_command("highlight k.CursorLine guifg=None guibg=#4e4e4e")
			vim.api.nvim_command("highlight k.debug guifg=None guibg=#4b1515")
			vim.api.nvim_command("highlight k.search guifg=#000000 guibg=#fc9867")
			vim.api.nvim_command("highlight k.Visual guifg=#ffffff guibg=#6c6a6d")
			vim.api.nvim_command("highlight k.tag guifg=#B3ADAE guibg=None")
			vim.api.nvim_command("highlight k.Folded guifg=None guibg=None")
			vim.api.nvim_command("highlight k.bufferline guifg=None guibg=None")
			vim.api.nvim_command("highlight k.border guifg=None guibg=None")
			vim.api.nvim_command("highlight k.none guifg=None guibg=None")
			vim.api.nvim_command("highlight k.blame guifg=#727072 guibg=None")
			vim.api.nvim_command("highlight k.bg ctermbg=None guibg=#2c2525")
			vim.api.nvim_command("highlight k.fg guifg=#B3ADAE guibg=#2c2525")
			vim.api.nvim_command("highlight k.interface guifg=#50e3b5 guibg=None")
			vim.api.nvim_command("highlight k.git guifg=#809e5a guibg=None")

			vim.api.nvim_set_hl(0, "@module.go", { link = "k.module" })
			vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "k.bracket" })
			vim.api.nvim_set_hl(0, "module", { link = "k.number" })
			----- flash
			vim.api.nvim_set_hl(0, "FlashLabel", { link = "k.module" }) ----

			----- common
			vim.api.nvim_set_hl(0, "VertSplit", { link = "k.Visual" })        ----
			vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { link = "k.git" }) ----
			vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { link = "k.git" }) ----
			vim.api.nvim_set_hl(0, "WinSeparator", { link = "k.git" })        ----

			vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "k.none" }) ----
			vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "k.none" }) ---
			vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "k.none" }) ---
			vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "k.none" })    ----
			vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { link = "k.none" }) ----
			vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "k.none" }) ----
			vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { link = "k.none" }) ----
			vim.api.nvim_set_hl(0, "TelescopePreviewDirectory", { link = "k.module" }) ----

			vim.api.nvim_set_hl(0, "TelescopeMatching", { link = "k.search" }) ----

			vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "k.blame" })
			-- vim.api.nvim_set_hl(0, "Normal", { link = "k.bg" })
			-- vim.api.nvim_set_hl(0, "LineNr", { link = "k.fg" })
			-- vim.api.nvim_set_hl(0, "StatusLine", { link = "k.fg" })
			-- vim.api.nvim_set_hl(0, "StatusLineNC", { link = "k.fg" })
			----- bufferline
			-- vim.api.nvim_set_hl(0, "BufferLineBackground", { link = "k.keyword" }) ----
			-- vim.api.nvim_set_hl(0, "BufferLineFill", { link = "k.keyword" }) ----
			-- vim.api.nvim_set_hl(0, "BufferLineDevIconDefault", { link = "k.debug" })
			-- vim.api.nvim_set_hl(0, "DevIconGo", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "BufferLineDevIconGoInactive", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "BufferLineDevIconGoSelected", { bg = "none" })

			----- noice
			vim.api.nvim_set_hl(0, "PmenuSbar", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "Pmenu", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "NoiceScrollbar", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "NoiceSplitBorder", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "NoiceSplit", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "NoicePopup", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "NoicePopupBorder", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "NoicePopupmenu", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "NoicePopupmenuBorder", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "NoiceCmdline", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { link = "k.keyword" })
			-- vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderCmdline", { link = "k.parameter" }) ----- 输入边框
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { link = "k.tag" })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSearch", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderFilter", { link = "k.keyword" })
			-- vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderCalculator", { link = "k.keyword" })

			----- cmp
			vim.api.nvim_set_hl(0, "FloatBorder", { link = "k.tag" }) -----
			-- gray
			vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
			-- vim.api.nvim_set_hl(0, 'CmpItemMenu', { bg = 'NONE', strikethrough = true, fg = '#ff8ebe' })
			-- blue
			vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#ff8ebe' })
			vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
			-- light blue
			vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
			vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
			vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
			-- pink
			vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
			vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
			-- front
			vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
			vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
			vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })

			vim.api.nvim_set_hl(0, "@interface", { link = "k.interface" })
			vim.api.nvim_set_hl(0, "@return", { link = "k.return" })
			vim.api.nvim_set_hl(0, "@error", { link = "k.return" })
			vim.api.nvim_set_hl(0, "@variable.parameter", { link = "k.parameter" })
			vim.api.nvim_set_hl(0, "@type.builtin", { link = "@field" })
			vim.api.nvim_set_hl(0, "@keyword", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "@property", { link = "k.property" })
			vim.api.nvim_set_hl(0, "@variable.member", { link = "k.property" })
			vim.api.nvim_set_hl(0, "@string", { link = "k.string" })
			vim.api.nvim_set_hl(0, "@type.definition", { link = "k.type.definition" })
			vim.api.nvim_set_hl(0, "@variable", { link = "k.variable" })
			vim.api.nvim_set_hl(0, "@type", { link = "k.type.definition" })
			vim.api.nvim_set_hl(0, "@function", { link = "k.property" })
			vim.api.nvim_set_hl(0, "@function.call", { link = "k.function.call" })
			vim.api.nvim_set_hl(0, "@function.method", { link = "k.function.method" })
			vim.api.nvim_set_hl(0, "@operator", { link = "k.operator" })
			vim.api.nvim_set_hl(0, "@function.method.call", { link = "k.function.method.call" })
			vim.api.nvim_set_hl(0, "@keyword.import", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "@number", { link = "k.number" })
			vim.api.nvim_set_hl(0, "@constant", { link = "k.constant" })
			vim.api.nvim_set_hl(0, "@keyword.conditional", { link = "k.keyword" })
			vim.api.nvim_set_hl(0, "CursorLine", { link = "k.CursorLine" })
			vim.api.nvim_set_hl(0, "Search", { link = "k.search" })
			vim.api.nvim_set_hl(0, "Visual", { link = "k.Visual" })
			vim.api.nvim_set_hl(0, "Folded", { link = "k.Folded" })
			vim.api.nvim_set_hl(0, "comment", { link = "k.return" })
			vim.api.nvim_set_hl(0, "@keyword.function.go", { bg = 'NONE', fg = '#ff8ebe' })
			vim.api.nvim_set_hl(0, "keyword.function", { bg = 'NONE', fg = '#ff8ebe' })
		end,
	},
}
