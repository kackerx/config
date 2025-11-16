return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			-- local keymaps = {
			-- 	-- TODO:
			-- 	mode = { "n", "v" },
			-- 	["<leader>u"] = { name = "+toggle" },
			-- 	["<leader>q"] = { name = "+quit/session" },
			-- 	["<leader>f"] = { name = "+find" },
			-- 	["<leader>g"] = { name = "+go to" },
			-- }
			-- wk.register(keymaps)
		end,
		opts = {
			-- key_labels = {
			-- 	["<leader>"] = "SPC",
			-- 	["<tab>"] = "TAB",
			-- },
		},
	},
}
