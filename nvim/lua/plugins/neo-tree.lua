return {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = true,
	branch = "v3.x",
	cmd = "Neotree",
	requires = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		{
			's1n7ax/nvim-window-picker',
			version = '2.*',
			config = function()
				require 'window-picker'.setup({
					filter_rules = {
						include_current_win = false,
						autoselect_one = true,
						-- filter using buffer options
						bo = {
							-- if the file type is one of following, the window will be ignored
							filetype = { 'neo-tree', "neo-tree-popup", "notify" },
							-- if the buffer type is one of following, the window will be ignored
							buftype = { 'terminal', "quickfix" },
						},
					},
				})
			end,
		},
	},
	keys = {
		--{
		--  "<leader>e",
		--  function()
		--    require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").root() })
		--  end,
		--  desc = "Explorer NeoTree (root dir)",
		--},
		-- {
		-- 	"<leader>e",
		-- 	function()
		-- 		require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
		-- 	end,
		-- 	desc = "Explorer NeoTree (cwd)",
		-- },
		-- { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
		-- { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
		-- {
		-- 	"<leader>hc",
		-- 	function()
		-- 		require("neo-tree.command").execute({ source = "git_status", toggle = true })
		-- 	end,
		-- 	desc = "Git explorer",
		-- },
		-- {
		-- 	"<leader>be",
		-- 	function()
		-- 		require("neo-tree.command").execute({ source = "buffers", toggle = true })
		-- 	end,
		-- 	desc = "Buffer explorer",
		-- },
	},
	deactivate = function()
		vim.cmd([[Neotree close]])
	end,
	init = function()
		if vim.fn.argc(-1) == 1 then
			local stat = vim.loop.fs_stat(vim.fn.argv(0))
			if stat and stat.type == "directory" then
				require("neo-tree")
			end
		end
	end,
	opts = {
		sources = { "filesystem", "buffers", "git_status", "document_symbols" },
		open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,

			filtered_items = {
				visible = true,
				show_hidden_count = true,
				hide_dotfiles = false,
				hide_gitignored = true,
				hide_by_name = {
					-- '.git',
					-- '.DS_Store',
					-- 'thumbs.db',
				},
				never_show = {},
			},

		},
		window = {
			width = 45,
			mappings = {
				["<space>"] = "none",
				["o"] = "open_vsplit",
				["s"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
				["sc"] = { "order_by_created", nowait = false },
				["sd"] = { "order_by_diagnostics", nowait = false },
				["sg"] = { "order_by_git_status", nowait = false },
				["sm"] = { "order_by_modified", nowait = false },
				["sn"] = { "order_by_name", nowait = false },
				["ss"] = { "order_by_size", nowait = false },
				["st"] = { "order_by_type", nowait = false },
				["w"] = "open_with_window_picker",
				["/"] = "filter_on_submit",
				["f"] = "fuzzy_finder",
				["Y"] = {
					function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.fn.setreg("+", path, "c")
					end,
					desc = "copy path to clipboard",
				},
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
		},
	},
	config = function(_, opts)
		local function on_move(data)
			require("lazyvim.util").lsp.on_rename(data.source, data.destination)
		end

		local events = require("neo-tree.events")
		opts.event_handlers = opts.event_handlers or {}
		vim.list_extend(opts.event_handlers, {
			{ event = events.FILE_MOVED,   handler = on_move },
			{ event = events.FILE_RENAMED, handler = on_move },
		})
		require("neo-tree").setup(opts)
		vim.api.nvim_create_autocmd("TermClose", {
			pattern = "*lazygit",
			callback = function()
				if package.loaded["neo-tree.sources.git_status"] then
					require("neo-tree.sources.git_status").refresh()
				end
			end,
		})
	end,
}
