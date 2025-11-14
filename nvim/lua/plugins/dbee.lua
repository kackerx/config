return {
	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		event = "VeryLazy",
		enabled = false,
		build = function()
			-- Install tries to automatically detect the install method.
			-- if it fails, try calling it with one of these parameters:
			--    "curl", "wget", "bitsadmin", "go"
			require("dbee").install("go")
		end,
		config = function()
			require("dbee").setup {
				sources = {
					require("dbee.sources").MemorySource:new({
						{
							name = "db",
							type = "mysql",
							url = "mysql://root:123456@192.168.31.53:3306/learn_sql"
						}
					})
				}
			}
		end,
	},
	{
		'kristijanhusak/vim-dadbod-ui',
		enabled = false, 
		event = "VeryLazy", 
		dependencies = {
			{ 'tpope/vim-dadbod',                     lazy = true },
			{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
		},
		cmd = {
			'DBUI',
			'DBUIToggle',
			'DBUIAddConnection',
			'DBUIFindBuffer',
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	}
}
