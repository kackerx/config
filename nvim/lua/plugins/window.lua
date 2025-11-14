return {
	{
		"dseum/window.nvim",
		config = function()
			local window = require("window")
			window.setup()
			vim.keymap.set("n", "<Leader>qj", function()
				window.close_buf()
			end)
			vim.keymap.set("n", "<C-w>o", function()
				window.split_win({
					default_buffer = false,
				})
			end)
			vim.keymap.set("n", "<C-w>p", function()
				window.split_win({
					orientation = "v",
					default_buffer = false,
				})
			end)
		end
	}
}
