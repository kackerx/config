-- This file is automatically loaded by init.lua

local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- 复制高亮
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank({ timeout = 300 })
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- go to last loc when opening a buffer
-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	group = augroup("last_loc"),
-- 	callback = function()
-- 		local mark = vim.api.nvim_buf_get_mark(0, '"')
-- 		local lcount = vim.api.nvim_buf_line_count(0)
-- 		if mark[1] > 0 and mark[1] <= lcount then
-- 			pcall(vim.api.nvim_win_set_cursor, 0, mark)
-- 		end
-- 	end,
-- })


-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query", -- :InspectTree
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"vim",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- wrap in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
	end,
})

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "",
	command = "set fo-=c fo-=r fo-=o",
})

-- Opens PDF files in sioyek instead of viewing the binary in Neovim
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*.pdf",
	callback = function()
		vim.fn.jobstart("sioyek '" .. vim.fn.expand("%") .. "'", { detach = true })
		vim.api.nvim_buf_delete(0, {})
	end,
	group = augroup("OpenPDF"),
	desc = "Opens PDF file in sioyek",
})

-- vim.cmd [[
--     augroup _load_break_points
--         autocmd!
--         autocmd FileType c,cpp,go,python,lua :lua require('dap.dap-util').load_breakpoints()
--     augroup end
-- ]]

vim.cmd [[
augroup ScrollbarInit
  autocmd!
  autocmd WinScrolled,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
augroup end
]]

-- local function fold_if_error_found()
-- 	vim.opt.foldmethod = "manual"
-- 	local current_line = vim.api.nvim_win_get_cursor(0)[1]
--
-- 	local search_end_line = current_line + 100
-- 	local total_lines = vim.api.nvim_buf_line_count(0)
--
-- 	if search_end_line > total_lines then
-- 		search_end_line = total_lines
-- 	end
-- 	local error_patterns = { "if err != nil ", "if err := ", "if err = " }
--
-- 	for line = current_line, search_end_line do
-- 		local line_text = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
-- 		for _, pattern in ipairs(error_patterns) do
-- 			if line_text:find(pattern) then
-- 				vim.api.nvim_exec(tostring(line) .. "foldclose", false)
-- 			end
-- 		end
-- 	end
--
-- 	-- 恢复为 Treesitter 折叠
-- 	vim.opt.foldmethod = "expr"
-- 	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- end
--
-- vim.api.nvim_create_autocmd({ "BufReadPost", "BufWinEnter" }, {
-- 	pattern = "*.go", -- 可根据需要调整文件类型
-- 	callback = fold_if_error_found,
-- })

-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "go" },
-- 	callback = function()
-- 		vim.api.nvim_win_set_option(0, "foldmethod", "manual")
-- 	end,
-- })
vim.api.nvim_create_autocmd('ModeChanged', {
	pattern = '*',
	callback = function()
		if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
			and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
			and not require('luasnip').session.jump_active
		then
			require('luasnip').unlink_current()
		end
	end
})
