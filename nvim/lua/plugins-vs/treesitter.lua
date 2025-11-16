return {
	{
		"kana/vim-textobj-user",
		enabled = true,
		event = "VeryLazy",
	},
	{ "sgur/vim-textobj-parameter", 
		enabled = true, 
		event = "VeryLazy",
		dependencies = {
			"kana/vim-textobj-user",
		},
	}
}

