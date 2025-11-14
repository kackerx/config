return {
	{
		'MattesGroeger/vim-bookmarks',
		enabled = true,
		event = "VeryLazy",
		keys = {
			{
				"<leader>ma",
				"<cmd>BookmarkToggle<cr>"
			},
			{
				"<leader>mi",
				"<cmd>BookmarkAnnotate<cr>"
			},
			{
				"<leader>md",
				"<cmd>BookmarkClearAll<cr>"
			},
		},
	}
}
