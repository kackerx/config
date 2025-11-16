return {
	-- 🔥 Copilot
	{
		"zbirenbaum/copilot.lua",
		lazy = true,
		cmd = "Copilot",
		event = "InsertEnter",
		enabled = false,
		config = function()
			require("copilot").setup {
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<C-f>",
						accept_word = false,
						accept_line = false,
						next = "<C-;>",
						prev = "<C-h>",
						dismiss = "<C-/>",
					}
				}
			}
		end
	},
	{
		"zbirenbaum/copilot-cmp",
		enabled = false, 
		lazy = false,
		event = { "InsertEnter", "LspAttach" },
		fix_pairs = true,
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup {

			}
		end,
	},
}
