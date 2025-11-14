return {
	{
		"stevearc/conform.nvim",
		enabled = true,
		event = "BufWritePre",
		cmd = "ConformInfo",
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>ll",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		config = function(_, opts)
			-- require("conform").formatters.protofix = function(bufnr)
			-- 	return {
			-- 		command = require("conform.util").find_executable({
			-- 			"/opt/homebrew/bin/buf format -w",
			-- 		}, "protofix"),
			-- 	}
			-- end
			-- require("conform").formatters.protofix = {
			-- 	inherit = false,
			-- 	command = "buf",
			-- 	args = { "format", "$FILENAME", "-w" },
			-- }
			require("conform").setup({
				format = {
					timeout_ms = 3000,
					async = false, -- not recommended to change
					quiet = false, -- not recommended to change
					-- lsp_fallback = true, -- not recommended to change
				},
				formatters_by_ft = {
					indentationlua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { { "black", "isort" } },
					-- Use a sub-list to run only the first available formatter
					javascript = { { "prettierd", "prettier" } },
					json = { "fixjson" },
					sql = { "sqlfmt" },
					yaml = { "yq" },
					proto = { "protofix" }
				},
				-- format_on_save = {
				-- 	-- These options will be passed to conform.format()
				-- 	timeout_ms = 10000,
				-- 	lsp_fallback = true,
				-- },
				formatters = {
					protofix = {
						command = "buf",
						args = { "format", "$FILENAME" },
						exit_codes = { 0, 3 },
					},
				},
			})
		end,
	},
}
