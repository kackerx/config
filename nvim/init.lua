vim.keymap.set({"n", "v"}, "K", "", {desc = "do"})

require("config.options")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("config.autocmds")

		require("config.keymaps")
	end,
})

vim.g.bookmark_no_default_key_mappings = 1

if vim.g.neovide then
	vim.o.guifont = "Maple Mono NF:h10"
	-- vim.o.guifont = "Fira Code:h11"
	-- set guifont=FiraCode\ Nerd\ Font:h19
	vim.opt.linespace = 2

	vim.g.neovide_window_blurred = true
	vim.g.neovide_floating_blur_amount_x = 1.0
	vim.g.neovide_floating_blur_amount_y = 1.0
	vim.g.neovide_transparency = 1
	vim.g.neovide_show_border = true
	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_z_height = 10
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5
	vim.g.neovide_frame = "transparent"
	vim.g.neovide_title_hidden = 1

	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_vfx_mode = "pixiedust"
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.9
	vim.g.neovide_cursor_vfx_particle_density = 11.0

	-------- keymap
	vim.keymap.set('v', '<D-c>', '"+y') -- Copy
	vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
	vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
	vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
	-- vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
	vim.keymap.set('i', '<D-v>', '<C-R>+') -- Paste insert mode

	vim.keymap.set('n', '<D-d>', '<C-i>', { desc = "close current buf" })
	vim.keymap.set('n', '<D-f>', '<C-o>', { desc = "close current buf" })
	vim.keymap.set({ "n", "t", "i" }, '<D-2>', '<cmd>Lspsaga term_toggle<cr>', { desc = "close current buf" })
	vim.keymap.set({ "n", "t", "i" }, '<D-3>', '<cmd>tabnext<cr>', { desc = "close current buf" })
	vim.keymap.set({ "n", "t", "i" }, '<C-y>', '<cmd>tabprevious<cr>', { desc = "close current buf" })
	vim.keymap.set({ "n", "t", "i" }, '<C-u>', '<cmd>tabnext<cr>', { desc = "close current buf" })
	-- vim.keymap.set('i', '<C-j>', '<C-n>', { desc = "close current buf" })
	-- vim.keymap.set('i', '<C-k>', '<C-p>', { desc = "close current buf" })
	-- vim.keymap.set('c', '<C-j>', '<C-n>', { desc = "close current buf" })
	-- vim.keymap.set('c', '<C-k>', '<C-p>', { desc = "close current buf" })

	---
	function toggle_neo_tree_focus()
		-- 获取当前窗口的缓冲区类型
		local buf_type = vim.bo.filetype

		-- 检查当前是否在 neo-tree 缓冲区
		if buf_type == "neo-tree" then
			-- 如果是，在 neo-tree 缓冲区内则关闭它
			vim.cmd("Neotree close")
		else
			-- 如果不是，打开并聚焦到 neo-tree
			vim.cmd("Neotree focus")
		end
	end

	vim.keymap.set({ "n", "i" }, '<D-b>',
		'<cmd>lua toggle_neo_tree_focus()<cr>')
	vim.keymap.set({ 'n', 'i' }, '<D-1>', '<esc><C-w>w', { desc = "window switch focus" })
	vim.keymap.set({ 'n', 'i', 'v', 'x' }, '<C-Enter>',
		'<CMD>lua require("util.telescope-customcmd").showCommandBar()<CR>',
		{ desc = "customcmd action" })
	vim.keymap.set({ 'n', 'i' }, '<D-w>', '<cmd>Bdelete<cr>', { desc = "close current buf" })
	-- vim.keymap.set({ 'n', 'i' }, '<D-s>', '<cmd>Lspsaga finder imp<cr>', { desc = "close current buf" })
	vim.keymap.set({ 'n', 'i' }, '<D-s>', '<cmd>Telescope lsp_implementations theme=ivy reuse_win=true<cr>',
		{ desc = "close current buf" })
	vim.keymap.set({ 'n', 'i' }, '<C-a>', '<cmd>BufferLineCyclePrev<cr>', { desc = "close current buf" })
	vim.keymap.set({ 'n', 'i' }, '<C-d>', '<cmd>BufferLineCycleNext<cr>', { desc = "close current buf" })
	vim.keymap.set({ "n", "i" }, "<D-g>", function()
		local ts_utils = require("nvim-treesitter.ts_utils")
		local ts_cursor = ts_utils.get_node_at_cursor(0)
		-- local result = vim.treesitter.get_node()
		-- print(ts_utils.get_node_at_cursor(0):parent():type())
		if
			(ts_utils.get_node_at_cursor(0):parent():type() == "function_declaration")
			or (ts_utils.get_node_at_cursor(0):parent():type() == "method_declaration")
			or (ts_utils.get_node_at_cursor(0):parent():type() == "field_declaration")
			or (ts_utils.get_node_at_cursor(0):parent():type() == "type_spec")
			or (ts_utils.get_node_at_cursor(0):parent():type() == "const_spec")
			or (
				ts_cursor:type() == "identifier" and (ts_cursor:parent():parent():type() == "short_var_declaration")
				or (ts_cursor:parent():parent():type() == "var_declaration")

			)
		then
			require("telescope.builtin").lsp_references(require("telescope.themes").get_ivy({ winblend = 11, show_line = false, include_current_line = false, reuse_win = true }))
		else
			require("telescope.builtin").lsp_definitions(require("telescope.themes").get_cursor({ winblend = 10, include_current_line = false, reuse_win = true }))
		end
	end, { desc = "" })

	--- dap
	vim.keymap.set('n', '<C-9>', '<cmd>lua require("dapui").eval()<cr>', { desc = "dapui eval" })
	vim.keymap.set('n', '<C-1>', '<cmd>lua require("dap").step_over()<cr>', { desc = "step_over" })
	vim.keymap.set('n', '<C-->', '<cmd>lua require("dap").step_into()<cr>', { desc = "step_into" })
	vim.keymap.set('n', '<C-=>', '<cmd>lua require("dap").step_out()<cr>', { desc = "step_out" })
	vim.keymap.set('n', '<C-r>', '<cmd>lua require("dap").continue()<cr>', { desc = "continue" })
	vim.keymap.set('n', '<C-0>', '<cmd>lua require("dap").toggle_breakpoint()<cr>', { desc = "toggle_breakpoint" })
end
