return {
	{ "MunifTanjim/nui.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{
		"lukas-reineke/indent-blankline.nvim", -- 缩进线
		enabled = false,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- char = "▏",
			char = "|",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},
	{
		"echasnovski/mini.indentscope",
		enabled = true,
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- symbol = "▏",
			-- symbol = "│",
			symbol = "|",
			options = { try_as_border = true },
			mappings = {
				-- Textobjects
				object_scope = "",
				object_scope_with_border = "ai",

				-- Motions (jump to respective border line; if not present - body line)
				goto_top = "[i",
				goto_bottom = "]i",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},
	{
		"rcarriga/nvim-notify",
		enabled = false,
		event = "VeryLazy",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		config = function(_, opts)
			require("notify").setup(opts)
			vim.notify = require("notify")
		end,
	},
	{
		"stevearc/dressing.nvim",
		enabled = true,
		event = "VeryLazy",
		opts = {
			input = { relative = "editor" },
			select = {
				backend = { "telescope", "fzf", "builtin" },
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		enabled = true,
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["vim.lsp.signature.enabled"] = false,
				},
				signature = {
					enabled = false,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
			},
		},
		keys = {
			-- {
			-- 	"<S-Enter>",
			-- 	function()
			-- 		require("noice").redirect(vim.fn.getcmdline())
			-- 	end,
			-- 	mode = "c",
			-- 	desc = "Redirect Cmdline",
			-- },
			{
				"<LocalLeader>fnl",
				function()
					require("noice").cmd("last")
				end,
				desc = "Noice Last Message",
			},
			{
				"<LocalLeader>fnh",
				function()
					require("noice").cmd("history")
				end,
				desc = "Noice History",
			},
			{
				"<LocalLeader>fna",
				function()
					require("noice").cmd("all")
				end,
				desc = "Noice All",
			},
			{
				"<LocalLeader>ff",
				function()
					if not require("noice.lsp").scroll(4) then
						return "<c-f>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll forward",
				mode = { "i", "n", "s" },
			},
			{
				"<LocalLeader>fb",
				function()
					if not require("noice.lsp").scroll(-4) then
						return "<c-b>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll backward",
				mode = { "i", "n", "s" },
			},
		},
	},
	{
		"xiyaowong/transparent.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			local ts = require("transparent")
			ts.clear_prefix("BufferLine")
			ts.clear_prefix("NeoTree")
			-- ts.clear_prefix("lualine")
			ts.setup({ -- Optional, you don't have to run setup.
				groups = { -- table: default groups
					"Normal",
					"NormalNC",
					"Comment",
					"Constant",
					"Special",
					"Identifier",
					"Statement",
					"PreProc",
					"Type",
					"Underlined",
					"Todo",
					"String",
					"Function",
					"Conditional",
					"Repeat",
					"Operator",
					"Structure",
					"LineNr",
					"NonText",
					"SignColumn",
					-- "CursorLine",
					"CursorLineNr",
					"StatusLine",
					"StatusLineNC",
					"EndOfBuffer",
				},
				extra_groups = { "" }, -- table: additional groups that should be cleared
				exclude_groups = {}, -- table: groups you don't want to clear
			})
		end,
	},
	{
		"mistricky/codesnap.nvim",
		build = "make",
		version = "^1",
		enabled = false,
		event = "VeryLazy"
	}
}
