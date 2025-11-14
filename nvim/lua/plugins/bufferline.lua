return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = 'nvim-tree/nvim-web-devicons',
		keys = {
			{ "<leader>bp",      "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
			{ "<leader>bP",      "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
			{ "<leader>bo",      "<Cmd>BufferLineCloseOthers<CR>",          desc = "Delete other buffers" },
			{ "<leader>br",      "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete buffers to the right" },
			{ "<leader>bl",      "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete buffers to the left" },
			{ "<S-h>",           "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
			{ "<S-l>",           "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
			{ "<localleader>bj", "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
			{ "<localleader>bk", "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
		},
		opts = {
			options = {
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				-- hover = {
				-- 	enabled = true,
				-- 	delay = 200,
				-- 	reveal = { 'close' }
				-- },
				indicator = {
					icon = '▎', -- this should be omitted if indicator style is not 'icon'
					-- icon = '-', -- this should be omitted if indicator style is not 'icon'
					style = 'icon',
				},
				--buffer_close_icon = '󰅖',
				buffer_close_icon = '',
				--modified_icon = '●',
				--close_icon = '',
				--left_trunc_marker = '',
				--right_trunc_marker = '',
				tab_size = 17,
				-- stylua: ignore
				--show_tab_indicators = true,
				close_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				-- stylua: ignore
				right_mouse_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				color_icons = false,
				-- separator_style = "slant",
				-- separator_style = {"▎", "▎"},
				--always_show_bufferline = false,

				-- TODO: bug
				-- diagnostics = "nvim_lsp",
				-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
				-- 	local s = " "
				-- 	for e, n in pairs(diagnostics_dict) do
				-- 		local sym = e == "error" and " "
				-- 			or (e == "warning" and " " or "")
				-- 		s = s .. n .. sym
				-- 	end
				-- 	return s
				-- end,

				--diagnostics_indicator = function(_, _, diag)
				--    local icons = require("lazyvim.config").icons.diagnostics
				--    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
				--            .. (diag.warning and icons.Warn .. diag.warning or "")
				--    return vim.trim(ret)
				--end,
				-- show_buffer_icons = false,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			-- Fix bufferline when restoring a session
			vim.opt.termguicolors = true
			vim.api.nvim_create_autocmd("BufAdd", {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
	},
	{
		'famiu/bufdelete.nvim',
		enabled = true,
		event = "VeryLazy",
	},
	{
		"tiagovla/scope.nvim",
		enabled = true,
		event = "VeryLazy",
		config = function()
			require("scope").setup({
				-- hooks = {
				-- 	pre_tab_enter = function()
				-- 		-- Your custom logic to run before entering a tab
				-- 	end,
				-- },
			})
		end
	}
}
