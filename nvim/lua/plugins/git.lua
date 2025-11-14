return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
					untracked = { text = "▎" },

					-- add = { text = "|" },
					-- change = { text = "|" },
					-- delete = { text = "" },
					-- topdelete = { text = "" },
					-- changedelete = { text = "|" },
					-- untracked = { text = "|" },
				},
				-- signs = {
				--     add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
				--     change       = {
				--         hl = 'GitSignsChange',
				--         text = '│',
				--         numhl = 'GitSignsChangeNr',
				--         linehl = 'GitSignsChangeLn'
				--     },
				--     delete       = {
				--         hl = 'GitSignsDelete',
				--         text = '_',
				--         numhl = 'GitSignsDeleteNr',
				--         linehl = 'GitSignsDeleteLn'
				--     },
				--     topdelete    = {
				--         hl = 'GitSignsDelete',
				--         text = '‾',
				--         numhl = 'GitSignsDeleteNr',
				--         linehl = 'GitSignsDeleteLn'
				--     },
				--     changedelete = {
				--         hl = 'GitSignsChange',
				--         text = '~',
				--         numhl = 'GitSignsChangeNr',
				--         linehl = 'GitSignsChangeLn'
				--     },
				-- },
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 100,
					ignore_whitespace = false,
				},
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000,
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				-- keymapping
				on_attach = function(bufnr)
					local function map(mode, lhs, rhs, opts)
						opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
						vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
					end

					-- Navigation
					map("n", "gj", ":Gitsigns next_hunk<CR>")
					map("n", "gk", ":Gitsigns prev_hunk<CR>")

					-- Actions
					map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>")
					map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
					map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
					map("n", "gt", ":Gitsigns reset_hunk<CR>")
					map("n", "gT", "<cmd>Gitsigns reset_buffer<CR>")
					map("n", "gu", "<cmd>Gitsigns preview_hunk<CR>")
					map("n", "<leader>hb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
					map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>")
					-- map("n", "gU", "<cmd>Gitsigns diffthis<CR>")
					map("n", "gD", '<cmd>lua require"gitsigns".diffthis("~")<CR>')
					map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>")
					map("n", "gc", "<cmd>Lazygit<CR>")
					--
					-- Text object
					map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
					map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")

					-- neogit
					map("n", "gm", "<cmd>Neogit merge<cr>")
					map("n", "ga", "<cmd>Neogit merge<cr>")
					map("n", "gn", "<cmd>Neogit commit<cr>")
					map("n", "gs", "<cmd>Neogit commit<cr>")
					map("n", "gl", "<cmd>Neogit log<cr>")
					map("n", "gd", "<cmd>Neogit diff<cr>")
					map("n", "gb", "<cmd>Neogit branch<cr>")
					map("n", "gp", "<cmd>Neogit pull<cr>")
					map("n", "gP", "<cmd>Neogit push<cr>")
				end,
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		enabled = true,
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua",      -- optional
		},
		config = true
	}
}
