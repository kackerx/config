-- This file is automatically loaded by init.lua

local util = require("util")

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP', { silent = true })

-- go to files
-- map("n", "<leader>go", "<cmd>e ~/.config/nvim/lua/config/options.lua<cr>", { desc = "Go to options config" })
-- map("n", "<leader>gk", "<cmd>e ~/.config/nvim/lua/config/keymaps.lua<cr>", { desc = "Go to keymaps config" })
-- -- require("luasnip.loaders").edit_snippet_files({})
-- map("n", "<leader>gs", function()
-- end, { desc = "Go to luasnip config" })
-- map("n", "<leader>gp", function()
-- 	require("neo-tree.command").execute({ toggle = true, dir = "~/.config/nvim/lua/plugins" })
-- end, { desc = "Go to plugins config" })
-- map(
-- 	"n",
-- 	"<leader>gl",
-- 	"<cmd>Telescope file_browser path=~/.config/nvim/lua/plugins<cr>",
-- 	{ desc = "Go to lazyvim config" }
-- )

-- better movement, 物理行代替多行的行
-- map("n", "n", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- map("n", "e", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- map({ "n", "v", "o" }, "&", "^", { desc = "Use 'H' as '^'" })

-- move Lines
-- map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
-- map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
-- map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
-- map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- window operate
--map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
--map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
--map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
--map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
-- map({ "n", "i" }, "<C-j>", "<C-w>w", { desc = "switch window" })
-- map({ "n", "i" }, "<LocalLeader>wv", "<C-w>v", { desc = "switch window" })
-- map({ "n", "i" }, "<LocalLeader>wx", "<C-w>q", { desc = "switch window" })
-- Delete window in `mini.bufremove`
-- map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })

-- windows resize and split
-- map("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- map("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- map("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- map("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
-- map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })

-- window
function toggle_window_size()
	-- 获取当前窗口的宽度和 Vim 的总宽度
	local cur_width = vim.api.nvim_win_get_width(0)
	local total_width = vim.api.nvim_get_option("columns")
	local threshold_width = math.floor(total_width * 0.8)

	-- 检查当前窗口是否已经是最大宽度
	if cur_width < threshold_width then
		-- 如果不是最大，则将窗口宽度设置为最大
		vim.api.nvim_win_set_width(0, total_width)
	else
		-- 如果已是最大宽度，将宽度设置为屏幕宽度的一半
		vim.api.nvim_win_set_width(0, math.floor(total_width / 2))
	end
end

map({ "n", "x", "v", "s", "i" }, "<localleader>wx", "<cmd>Bdelete<cr>", { desc = "close buf" })
map(
	{ "n", "x", "v", "s", "i" },
	"<localleader>wl",
	"<cmd>lua vim.api.nvim_command('buffer#')<cr>",
	{ desc = "重新打开最后buf" }
)
-- map({ "n", "x", "v", "s", "i" }, "<localleader>wb", "<cmd>Neotree toggle<cr>", { desc = "toggle 目录" })
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

map({ "n", "x", "v", "s", "i" }, "<localleader>wb", "<cmd>lua toggle_neo_tree_focus()<cr>", { desc = "toggle 目录" })
map({ "n" }, "<leader>ww", "<C-w>q", { desc = "close window" })
map("n", "<leader>wl", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>w=", "<C-W>s", { desc = "Split window down" })
map("n", "<leader>wj", "<C-W>s", { desc = "Split window down" })
map("n", "<leader>ws", "<C-W>x", { desc = "Swap window" })
map("n", "<leader>wz", "<cmd>lua toggle_window_size()<CR>", { desc = "Split window down" })
-- map("n", "<leader>wx", "<cmd>lua resize_window_half()<CR>", { desc = "Split window down" })


-- colemak and custom
map({ "n", "v" }, "H", "5h", { desc = "down" })
map({ "n", "v" }, "J", "5j", { desc = "down" })
map({ "n", "v" }, "L", "5l", { desc = "down" })
map({ "n", "v" }, "K", "5k", { desc = "down" })

map("n", "m", "~", { desc = "down" })

map("c", "<Up>", "<C-p>", { desc = "down" })
map("c", "<Down>", "<C-n>", { desc = "down" })

map("n", "Q", "<cmd>q<cr>", { desc = "down" })
map("n", "<leader>a", "<cmd>w<cr>", { desc = "down" })
map("n", "&", "^", { desc = "回到行首" })

map("n", "u", "u", { desc = "down" })
map("n", "U", "<C-r>", { desc = "down" })
-- map("n", "u", "u", { desc = "down" })
-- map("n", "tt", "zc", { desc = "down" })
-- map("n", "<leader>tc", "zm", { desc = "down" })
-- map("n", "to", "zo", { desc = "down" })
-- map("n", "<leader>to", "zr", { desc = "down" })

-- map("n", "cw", "ciw", { desc = "down" })
-- map("n", "dw", "diw", { desc = "down" })
map("n", "c(", "ci(", { desc = "down" })
map("n", "c[", "ci[", { desc = "down" })
map("n", "d(", "di(", { desc = "down" })
map("n", "d[", "di[", { desc = "down" })
map("n", "c'", "ci'", { desc = "down" })
map("n", 'c"', 'ci"', { desc = "down" })
map("n", "c{", "ci{", { desc = "down" })
map("n", "d{", "di{", { desc = "down" })
map("c", "<Tab>", "<Tab><S-Tab>", { desc = "down" })
map("n", "<C-z>", "<C-a>", { desc = "down" })

map({ "i", "c", "n" }, "<C-j>", "<C-n>", { desc = "down" })
map({ "i", "c", "n" }, "<C-k>", "<C-p>", { desc = "down" })

-- map("n", "<C-9>", "<C-x>", { desc = "incr" })
-- map("n", "<C-0>", "<C-a>", { desc = "incr" })
-- vim.keymap.set("n", "<C-->", "<C-x>", { desc = "Decrement number" })
vim.keymap.set("n", "<C-b>", "<C-a>", { desc = "Increment number" })

-- bookmark


-- Buffers
-- map({ "n", "i" }, "<C-a>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
-- map("n", "<leader>k", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
-- map({ "n", "i" }, "<C-s>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
-- map("n", "<leader>j", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
-- map("n", "<LocalLeader>bw", "<cmd>bdelete<cr>", { desc = "Next buffer" })

-- search
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
--map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
--map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
--map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
--map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
--map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
--map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- add undo break-points
-- map("i", ",", ",<c-g>u")
-- map("i", ".", ".<c-g>u")
-- map("i", ";", ";<c-g>u")
map("v", "Y", '"+y', { desc = "Save file" })

-- better indenting
-- map("v", "<", "<gv")
-- map("v", ">", ">gv")
-- map("n", "<", "v<g")
-- map("n", ">", "v>g")

-------------------------------------------------- toggle options
-- ===
-- map("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
-- ===
-- map("n", "<leader>us", function()
-- 	util.toggle("spell")
-- end, { desc = "Toggle Spelling" })
-- map("n", "<leader>uw", function()
-- 	util.toggle("wrap")
-- end, { desc = "Toggle Word Wrap" })
-- map("n", "<leader>ud", util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
-- map("n", "<leader>uc", function()
-- 	util.toggle("conceallevel", false, { 0, conceallevel })
-- end, { desc = "Toggle Conceal" })
------------------------------------------------ Telescope
-- map({ "n" }, "fu", "<cmd>Telescope aerial<CR>", { desc = "open or close file explore" })
map({ "n" }, "fi", "<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<cr>", {})
map({ "n" }, "<leader>/", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", {})
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
map("n", "<leader>nc", live_grep_args_shortcuts.grep_word_under_cursor)
map("v", "<leader>nv", live_grep_args_shortcuts.grep_visual_selection)
map({ "n" }, "<leader>mm", "<cmd>lua require('telescope').extensions.vim_bookmarks.all()<cr>", {})
map({ "n" }, "<leader>nn", "<cmd>Telescope current_buffer_fuzzy_find winblend=30<cr>", {})
map({ "n" }, "<leader>e", "<cmd>Telescope file_browser theme=ivy winblend=30<cr>", {})
map({ "n" }, "fp", "<cmd>lua require'telescope'.extensions.projects.projects{}<cr>", {})
map(
	{ "n" },
	"<leader>s",
	"<cmd>lua require('telescope').extensions.aerial.aerial(require('telescope.themes').get_ivy({ winblend = 10, include_current_line = true }))<cr>",
	{ desc = "open or close file explore" }
)
map(
	{ "n" },
	"<leader>k",
	"<cmd>lua require('telescope').extensions.recent_files.pick(require('telescope.themes').get_ivy({ winblend = 20 }))<CR>",
	{ desc = "open or close file explore" }
)
map(
	{ "n" },
	"fl",
	"<cmd>lua require('telescope.builtin').lsp_implementations(require('telescope.themes').get_ivy({ winblend = 5 }))<CR>",
	{ desc = "open or close file explore" }
)
map(
	{ "n", "i" },
	"<localleader>ca",
	'<cmd>lua require("util.telescope-customcmd").showCommandBar()<CR>',
	{ desc = "open or close file explore" }
)

map(
	{ "n" },
	"<leader>y",
	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_ivy({winblend = 30, height = 7, cwd = vim.fn.expand('%:p:h')}))<CR>",
	{ desc = "open or close file explore" }
)
-- map("n", "<leader>fi", "<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>", { desc = "impl go interface" })

------------------------------------------------ LSP
vim.keymap.set("n", "<leader>wbb", function()
	local ts_utils = require("nvim-treesitter.ts_utils")
	print(ts_utils.get_node_at_cursor(0):parent():type())
end)

vim.keymap.set({ "n", "i" }, "<localleader>lz", function()
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
		require("telescope.builtin").lsp_references(require("telescope.themes").get_ivy({ winblend = 10 }))
	else
		require("telescope.builtin").lsp_definitions(require("telescope.themes").get_cursor({ winblend = 10 }))
	end
end, { desc = "" })
-- require("telescope.builtin").lsp_implementations(require("telescope.themes").get_cursor({ winblend = 10 }))({})

------------ session manager
-- map({ "n", "i" }, '<LocalLeader>ws', "<cmd>SessionManager load_session<cr>", {})

------------ toggleTerm
-- map({ "n", "i" }, '<C-y>', "<cmd>ToggleTerm<cr>", {})

------------ debug
-- map({ "n", "i" }, '<LocalLeader>db',
-- 	"<cmd>lua require'dap'.toggle_breakpoint(); require'dap.dap-util'.store_breakpoints(true)<cr>", {})
-- map({ "n", "i" }, '<LocalLeader>dp', "<cmd>lua require'dap'.continue()<cr>", {})
-- map({ "n", "i" }, '<LocalLeader>dq', "<cmd>lua require'dap'.step_over()<cr>", {})
-- map({ "n", "i" }, '<LocalLeader>dw', "<cmd>lua require'dap'.step_into()<cr>", {})
-- map({ "n", "i" }, '<LocalLeader>df', "<cmd>lua require'dap'.step_out()<cr>", {})
-- map({ "n", "i" }, '<LocalLeader>dt', "<cmd>lua require'dap'.terminate()<cr>", {})
-- map({ "n", "i" }, '<LocalLeader>dr', "lua require'dap.dap-util'.reload_continue()<CR>", {})
-- map({ "n", "i" }, '<LocalLeader>dl', "<cmd>lua require'dap'.run_last()<cr>", {})
-- map({ "n", "i" }, '<LocalLeader>de', "<cmd>lua require'dapui'.eval()<cr>", {})
-- map({ "n", "i" }, '<LocalLeader>du', "<cmd>lua require'dapui'.toggle()<cr>", {})
vim.keymap.set("n", "cw", "c<cmd>lua require('spider').motion('e')<CR>")
vim.keymap.set("n", "dw", "d<cmd>lua require('spider').motion('e')<CR>")


map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })

------------ lsp_signature
map({ "n", "i" }, "<LocalLeader>os", function()
	require("lsp_signature").toggle_float_win()
end, { silent = true, noremap = true, desc = "toggle signature" })


------------ lsp_saga
map({ "n", "i" }, "<LocalLeader>ll", "<cmd>Lspsaga finder imp<cr>", {})
map({ "n" }, "fg", "<cmd>Lspsaga hover_doc<cr>", {})
map({ "n" }, "fu", "<cmd>Lspsaga outline<cr>", {})
map({ "n" }, "fj", "<cmd>Lspsaga diagnostic_jump_next<cr>", {})
map({ "n" }, "fk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {})
map({ "n" }, "fc", "<cmd>Lspsaga code_action<cr>", {})

------------ Refactor
vim.keymap.set("x", "<leader>rr", function() require('refactoring').refactor('Extract Function') end)
vim.keymap.set("x", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end)
-- Extract function supports only visual mode
vim.keymap.set("x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end)
-- Extract variable supports only visual mode
vim.keymap.set("n", "<leader>rI", function() require('refactoring').refactor('Inline Function') end)
-- Inline func supports only normal
vim.keymap.set({ "n", "x" }, "<leader>ri", function() require('refactoring').refactor('Inline Variable') end)
-- Inline var supports both normal and visual mode

vim.keymap.set("n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end)
vim.keymap.set("n", "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end)


------------ other
map("n", "<leader>qw", "<cmd>TodoTrouble<cr>", { desc = "down" })

-- Lua function to search with selection in Telescope
local function search_with_selection()
	-- Exit visual mode temporarily
	vim.cmd('normal! `<v`>y')

	-- Get the content from the unnamed register
	local selection = vim.fn.getreg('0')

	-- Load Telescope and pass the selection as the default text
	-- require('telescope.builtin').current_buffer_fuzzy_find({ default_text = selection })
	require('telescope.builtin').current_buffer_fuzzy_find({ default_text = selection })
end

-- Set up a visual mode keymap
vim.api.nvim_set_keymap('v', '<leader>/', '<cmd>lua search_with_selection()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>pl", [[<cmd>lua require("persistence").load()<cr>]], {})

-- test
local function fold_if_error_found()
	-- vim.opt.foldmethod = "manual"
	local current_line = vim.api.nvim_win_get_cursor(0)[1]

	local search_end_line = current_line + 100
	local total_lines = vim.api.nvim_buf_line_count(0)

	if search_end_line > total_lines then
		search_end_line = total_lines
	end
	local error_patterns = { "if err != nil ", "if err := ", "if err = " }

	for line = current_line, search_end_line do
		local line_text = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
		for _, pattern in ipairs(error_patterns) do
			if line_text:find(pattern) then
				vim.api.nvim_exec(tostring(line) .. "foldclose", false)
			end
		end
	end

	-- 恢复为 Treesitter 折叠
	-- vim.opt.foldmethod = "expr"
	-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
end

-- 定义一个自动命令组，以便于后续清理
vim.keymap.set("n", "<leader>le", fold_if_error_found, { desc = "Locate 'if err != nil' and fold" })
