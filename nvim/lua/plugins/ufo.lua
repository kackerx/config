return {
	-- {
	-- 	dependencies = { "kevinhwang91/promise-async" },
	-- 	event = "VimEnter"
	-- },
	{
		"kevinhwang91/nvim-ufo",
		event = "BufReadPost",
		enabled = false,
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			vim.o.foldcolumn = "0" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = false
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			vim.opt.foldmethod = "manual"

			local handler = function(virtText, lnum, endLnum, width, truncate)
				local line = vim.fn.getline(lnum)
				if line:find("if%s+err%s*!= nil") then
					local prevLine = vim.api.nvim_buf_get_lines(0, lnum - 2, lnum - 1, false)[1]
					local indent = string.match(prevLine, "^%s*") or "" -- 获取上一行的缩进
					local startLine = lnum
					local endLine = endLnum
					local lines = vim.api.nvim_buf_get_lines(0, startLine, endLine - 1, false)
					for i, l in ipairs(lines) do
						lines[i] = l:gsub("^%s*", ""):gsub("return", "..") -- 去掉开头的空格
					end
					local newText = indent .. table.concat(lines, "; ")
					virtText = { { newText, "k.bracket" } }
					return virtText
				end
				if line:find(".*err%s*[:=]+.*%)") then
					-- 获取起始行到结束行之间的所有行
					print(111)
					local lines = vim.api.nvim_buf_get_lines(0, lnum + 1, endLnum, false)
					-- 遍历获取的行，并对其进行处理
					for i, l in ipairs(lines) do
						-- if l:find("return") then
						-- 	lines[i] = l:gsub("^%s*", ""):gsub("return", "..") -- 替换 return 为 ..
						-- else
						lines[i] = l:gsub("^%s*", "") -- 去掉开头的空格
						-- end
					end
					-- 将处理后的所有行用分号连接起来
					local newText = table.concat(lines, "; "):gsub([[; }]], " ")

					local suffix = " ? " .. newText
					local sufWidth = vim.fn.strdisplaywidth(suffix)
					local targetWidth = width - sufWidth
					local curWidth = 0
					local newVirtText = {}

					-- 将原有的 virtText 处理并添加到 newVirtText
					for _, chunk in ipairs(virtText) do
						local chunkText = chunk[1]
						local chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if targetWidth > curWidth + chunkWidth then
							table.insert(newVirtText, chunk)
						end
						curWidth = curWidth + chunkWidth
					end

					-- 在末尾添加处理后的新文本
					table.insert(newVirtText, { suffix, "k.bracket" })
					return newVirtText
				end
				if line:find("if%s+[^;]+;[^;]+!= nil") then
					local startLine = lnum
					local endLine = endLnum
					local lines = vim.api.nvim_buf_get_lines(0, startLine, endLine - 1, false)
					for i, l in ipairs(lines) do
						lines[i] = l:gsub("^%s*", "")
					end
					local content = table.concat(lines, "; ")

					local newVirtText = {}
					-- local suffix = ('  %d '):format(endLnum - lnum)
					local suffix = " ? " .. content
					local sufWidth = vim.fn.strdisplaywidth(suffix)
					local targetWidth = width - sufWidth
					local curWidth = 0
					local errCount = 0
					for _, chunk in ipairs(virtText) do
						local chunkText = chunk[1]
						local chunkWidth = vim.fn.strdisplaywidth(chunkText)

						if targetWidth > curWidth + chunkWidth then
							if chunkText == "err" then
								errCount = errCount + 1
								if errCount ~= 2 then
									table.insert(newVirtText, { chunkText, chunk[2] })
								end
							end

							if
								chunkText ~= ";"
								and chunkText ~= "err"
								and chunkText ~= "!="
								and chunkText ~= "nil"
								and chunkText ~= "{"
								and chunkText ~= "if"
								and chunkText ~= " "
							then
								if chunkText == ":=" or chunkText == "=" then
									chunkText = " " .. chunkText .. " "
									table.insert(newVirtText, { chunkText, chunk[2] })
								elseif chunkText == "," then
									chunkText = "," .. " "
									table.insert(newVirtText, { chunkText, chunk[2] })
								else
									table.insert(newVirtText, { chunkText, chunk[2] })
								end
							end
						end
						curWidth = curWidth + vim.fn.strdisplaywidth(chunkText)
					end
					table.insert(newVirtText, { suffix, "k.bracket" })
					return newVirtText
				end

				local newVirtText = {}
				local suffix = ("...%d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + vim.fn.strdisplaywidth(chunkText)
				end
				table.insert(newVirtText, { suffix, "k.bracket" })

				return newVirtText
			end
			local function get_error_handling_folds(bufnr)
				local error_folds = {}
				local line_count = vim.api.nvim_buf_line_count(bufnr)
				local is_in_error_block = false
				local error_block_start = 0

				for i = 0, line_count - 1 do
					local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1]
					-- 检查是否是错误处理开始的行，即包含 'err =' 或 'err :='
					-- if not is_in_error_block and line:match(".+,%s+err%s*[:=]+%s+.+%([^%)]*%)") then
					if not is_in_error_block and line:match(".*err%s*[:=]+.*%)") then
						is_in_error_block = true
						error_block_start = i
						-- 检查是否是错误处理块的结束行，即包含 '}'
					elseif is_in_error_block and line:match("%s*}") then
						is_in_error_block = false
						table.insert(error_folds, { startLine = error_block_start, endLine = i })
					end
				end

				-- 如果文件结束时仍然处于错误处理块中，将其添加到结果中
				if is_in_error_block then
					table.insert(error_folds, { startLine = error_block_start, endLine = line_count - 1 })
				end

				return error_folds
			end
			local ftMap = {
				go = function(bufnr)
					local err_folds = get_error_handling_folds(bufnr)
					local lsp_folds = require("ufo").getFolds(bufnr, "treesitter")
					for _, fold in ipairs(err_folds) do
						table.insert(lsp_folds, fold)
					end
					-- print(vim.inspect(lsp_folds))
					return lsp_folds
				end,
			}

			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return ftMap[filetype] or { "treesitter", "indent" }
				end,
				fold_virt_text_handler = handler,
				open_fold_hl_timeout = 150,
				close_fold_kinds_ft = { "imports", "comment" },
				preview = {
					win_config = {
						border = { "", "─", "", "", "", "─", "", "" },
						winhighlight = "Normal:Folded",
						winblend = 0,
					},
					mappings = {
						scrollU = "<C-u>",
						scrollD = "<C-d>",
						jumpTop = "[",
						jumpBot = "]",
					},
				},
			})
		end,
	},
	{
		"luukvbaal/statuscol.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				relculright = true,
				segments = {
					{ text = { builtin.foldfunc },      click = "v:lua.ScFa" },
					{ text = { "%s" },                  click = "v:lua.ScSa" },
					{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				},
			})
		end,
	},
}
