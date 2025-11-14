return {
	{ "nacro90/numb.nvim",    event = "BufReadPre", config = true, enabled = true },
	{ "nvim-lua/plenary.nvim" },
	{ "kkharji/sqlite.lua" },
	{
		"folke/persistence.nvim",
		enabled = true,
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
		-- stylua: ignorest
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qS",
				function()
					require("persistence").select()
				end,
				desc = "select Session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't Save Current Session",
			},
		},
	},
	-- { "tpope/vim-repeat", event = "VeryLazy" },
	{
		"numToStr/Comment.nvim",
		enabled = true,
		event = "VeryLazy",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		enabled = true,
		event = "VeryLazy",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"phaazon/hop.nvim",
		enabled = false,
		cmd = "HopWord",
		config = function(_, _)
			require("hop").setup()
		end,
		keys = {
			{ "s", "<cmd>HopWord<cr>", desc = { "hop" } },
		},
	},
	{
		"Xuyuanp/scrollbar.nvim",
		enabled = false,
		event = "VeryLazy",
	},
	-- {
	-- 	'keaising/im-select.nvim',
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require('im_select').setup {
	--
	-- 			-- IM will be set to `default_im_select` in `normal` mode
	-- 			-- For Windows/WSL, default: "1033", aka: English US Keyboard
	-- 			-- For macOS, default: "com.apple.keylayout.ABC", aka: US
	-- 			-- For Linux, default: "keyboard-us"
	-- 			-- You can use `im-select` or `fcitx5-remote -n` to get the IM's name you preferred
	-- 			default_im_select       = "com.apple.keylayout.Colemak",
	--
	-- 			-- Can be binary's name or binary's full path,
	-- 			-- e.g. 'im-select' or '/usr/local/bin/im-select'
	-- 			-- For Windows/WSL, default: "im-select.exe"
	-- 			-- For macOS, default: "im-select"
	-- 			-- For Linux, default: "fcitx5-remote"
	-- 			default_command         = 'im-select',
	--
	-- 			-- Restore the default input method state when the following events are triggered
	-- 			set_default_events      = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
	--
	-- 			-- Restore the previous used input method state when the following events are triggered
	-- 			-- if you don't want to restore previous used im in Insert mode,
	-- 			-- e.g. deprecated `disable_auto_restore = 1`, just let it empty `set_previous_events = {}`
	-- 			set_previous_events     = { "InsertEnter" },
	--
	-- 			-- Show notification about how to install executable binary when binary is missing
	-- 			keep_quiet_on_no_binary = false
	-- 		}
	-- 	end
	-- },
	-- {
	-- 	"keaising/im-select.nvim",
	-- 	enabled = true,
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("im_select").setup({})
	-- 	end,
	-- },
	{
		"michaelb/sniprun", -- 片段代码运行
		enabled = false,
		build = "sh install.sh",
		-- cmd = 'SnipRun',          -- 当执行SnipRun命令时懒加载
		ft = { "python", "lua", "go" }, -- 当文件类型是python或lua时懒加载
		config = function()
			require("sniprun").setup({
				selected_interpreters = {}, --# use those instead of the default for the current filetype
				repl_enable = {}, --# enable REPL-like behavior for the given interpreters
				repl_disable = {}, --# disable REPL-like behavior for the given interpreters

				interpreter_options = {
					--# intepreter-specific options, see docs / :SnipInfo <name>
					GFM_original = {
						use_on_filetypes = { "markdown.pandoc" }, --# the 'use_on_filetypes' configuration key is
						--# available for every interpreter
					},
				},

				--# you can combo different display modes as desired
				display = {
					"Classic", --# display results in the command-line  area
					"VirtualTextOk", --# display ok results as virtual text (multiline is shortened)

					-- "VirtualTextErr",          --# display error results as virtual text
					-- "TempFloatingWindow",      --# display results in a floating window
					-- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText__
					"Terminal", --# display results in a vertical split
					-- "TerminalWithCode",        --# display results and code history in a vertical split
					-- "NvimNotify",              --# display with the nvim-notify plugin
					-- "Api"                      --# return output to a programming interface
				},

				display_options = {
					terminal_width = 45, --# change the terminal display option width
					notification_timeout = 5, --# timeout for nvim_notify output
				},

				--# You can use the same keys to customize whether a sniprun producing
				--# no output should display nothing or '(no output)'
				show_no_output = {
					"Classic",
					"TempFloatingWindow", --# implies LongTempFloatingWindow, which has no effect on its own
				},

				--# customize highlight groups (setting this overrides colorscheme)
				snipruncolors = {
					SniprunVirtualTextOk = { bg = "#66eeff", fg = "#000000", ctermbg = "Cyan", cterfg = "Black" },
					SniprunFloatingWinOk = { fg = "#66eeff", ctermfg = "Cyan" },
					SniprunVirtualTextErr = { bg = "#881515", fg = "#000000", ctermbg = "DarkRed", cterfg = "Black" },
					SniprunFloatingWinErr = { fg = "#881515", ctermfg = "DarkRed" },
				},

				--# miscellaneous compatibility/adjustement settings
				inline_messages = 0, --# inline_message (0/1) is a one-line way to display messages
				--# to workaround sniprun not being able to display anything

				borders = "single", --# display borders around floating windows
				--# possible values are 'none', 'single', 'double', or 'shadow'
				live_mode_toggle = "off", --# live mode toggle, see Usage - Running for more info
			})
		end,
	},
	{
		"Pocco81/auto-save.nvim",
		enabled = true,
		event = "VeryLazy",
		config = function()
			require("auto-save").setup {
				enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
				execution_message = {
					message = function() -- message to print on save
						-- return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
						return ""
					end,
					dim = 0.18, -- dim the color of `message`
					cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
				},
				trigger_events = { "InsertLeave" },
				debounce_delay = 3333,
			}
		end
	},
	{
		"someone-stole-my-name/yaml-companion.nvim",
		enabled = false,
		event = "VeryLazy",
		requires = {
			{ "neovim/nvim-lspconfig" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("telescope").load_extension("yaml_schema")
		end,
	},
	{
		"echasnovski/mini.nvim",
		enabled = true,
		event = "VeryLazy",
		config = function()
			require('mini.surround').setup {
				mappings = {
					add = 'gsa', -- Add surrounding in Normal and Visual modes
					delete = 'gsd', -- Delete surrounding
					find = 'gsf', -- Find surrounding (to the right)
					find_left = 'gsF', -- Find surrounding (to the left)
					highlight = 'gsh', -- Highlight surrounding
					replace = 'gsr', -- Replace surrounding
					update_n_lines = 'gsn', -- Update `n_lines`
					-- suffix_last = 'l', -- Suffix to search with "prev" method
					-- suffix_next = 'n', -- Suffix to search with "next" method
				},
			}
		end
	},
	{
		"folke/todo-comments.nvim",
		enabled = true,
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			highlight = {
				multiline = true,    -- enable multine todo comments
				multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
				multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
				before = "",         -- "fg" or "bg" or empty
				keyword = "wide_fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
				after = "fg",        -- "fg" or "bg" or empty
				pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
				comments_only = true, -- uses treesitter to match keywords in comments only
				max_line_len = 400,  -- ignore lines longer than this
				exclude = {},        -- list of file types to exclude highlighting
			},
		},
	},
	{
		's1n7ax/nvim-window-picker',
		name = 'window-picker',
		event = 'VeryLazy',
		version = '2.*',
		config = function()
			require 'window-picker'.setup()
		end,
	}
}
