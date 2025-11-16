return {
	{
		"RRethy/vim-illuminate", -- cursor下的其他同单词高亮
		event = "VeryLazy",
		enabled = true,
		config = function(_, _)
			vim.g.Illuminate_ftblacklist = {
				"NvimTree",
				"vista_kind",
				"toggleterm"
			}
			-- 设置高亮组的名称
			local highlight_group = 'MyHighlightGroup'

			-- 创建高亮组并设置背景颜色，例如#ff0000
			vim.cmd('highlight ' .. highlight_group .. ' guibg=#ff0000')

			-- 设置vim-illuminate使用自定义的高亮组
			vim.g.Illuminate_highlightUnderCursor = 1
			vim.g.Illuminate_highlightPriority = 10
			vim.g.Illuminate_highlightGroup = highlight_group
			require('illuminate').configure({
				providers = {
					'lsp',
					'treesitter',
					'regex',
				},
				under_cursor = true,
				highlight_color = '#ff0000'
			})
		end,
	}
}
