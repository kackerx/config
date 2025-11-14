return {
	"folke/flash.nvim",
	event = "VeryLazy",
	enabled = true,
	---@type Flash.Config
	opts = {
		search = {
			-- search/jump in all windows
			multi_window = true,
			-- search direction
			-- forward = true,
			-- when `false`, find only matches in the given direction
			-- wrap = true,
			---@type Flash.Pattern.Mode
			-- Each mode will take ignorecase and smartcase into account.
			-- * exact: exact match
			-- * search: regular search
			-- * fuzzy: fuzzy search
			-- * fun(str): custom function that returns a pattern
			--   For example, to only match at the beginning of a word:
			--   mode = function(str)
			--     return "\\<" .. str
			--   end,
			mode = "exact",
			-- behave like `incsearch`
			incremental = false,
			-- Excluded filetypes and custom window filters
			---@type (string|fun(win:window))[]
			exclude = {
				"notify",
				"cmp_menu",
				"noice",
				"flash_prompt",
				function(win)
					-- exclude non-focusable windows
					return not vim.api.nvim_win_get_config(win).focusable
				end,
			},
		},
		modes = {
			-- options used when flash is activated through
			-- a regular search with `/` or `?`
			search = {
				-- when `true`, flash will be activated during regular search by default.
				-- You can always toggle when searching with `require("flash").toggle()`
				enabled = false,
				highlight = { backdrop = false },
				jump = { history = true, register = true, nohlsearch = true },
				search = {
					-- `forward` will be automatically set to the search direction
					-- `mode` is always set to `search`
					-- `incremental` is set to `true` when `incsearch` is enabled
				},
			},
		},
	},
	-- stylua: ignore
	keys = {
		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
		{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		-- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
		-- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		-- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
	},
}
