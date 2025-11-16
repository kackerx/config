local Util = require("util")

return {
	{
		"nvim-telescope/telescope.nvim",
		-- tag = "0.1.6",
		enabled = true,
		cmd = "Telescope", -- 按命令时才加载插件, 非启动加载
		event = "BufReadPre",
		-- version = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "nvim-telescope/telescope-frecency.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"BurntSushi/ripgrep",
			"nvim-telescope/telescope-file-browser.nvim",
			"smartpde/telescope-recent-files",
			"gbrlsnchs/telescope-lsp-handlers.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			"savq/paq-nvim",
			-- "barrett-ruth/telescope-http.nvim",
			"tom-anders/telescope-vim-bookmarks.nvim",
			-- "nvim-telescope/telescope-project.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make"
				-- "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			"tsakirist/telescope-lazy.nvim",
		},
		keys = {
			-- short
			{ "<leader>,", Util.tele_builtin("buffers", { show_all_buffers = true }), desc = "Switch Buffer" },
			-- { "<leader>/", Util.tele_builtin("live_grep"),                            desc = "Find in Files (Grep)" },
			-- { "<leader>/", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", desc = "Command History" },
			{ "<leader>:", Util.tele_builtin("command_history"),                      desc = "Command History" },
			{ "<leader>f", Util.tele_builtin("find_files"),                           desc = "Find Files (root dir)" },
			-- { "<C-m>", Util.tele_builtin("oldfiles"), desc = "Find Files (root dir)" },
			-- { "<leader>fq", Util.tele_builtin("quickfix"),                             desc = "quickfix" },
			-- { "<leader>fj", Util.tele_builtin("jumplist"),                             desc = "jumplist" },
			-- git
			{ "fgc",       Util.tele_builtin("git_commits"),                          desc = "commits" },
			{ "fgs",       Util.tele_builtin("git_status"),                           desc = "status" },
			-- find
			{ "fb",        Util.tele_builtin("buffers"),                              desc = "Buffers" },
			-- { "<leader>fr",      Util.tele_extn("frecency"),                                desc = "Recent" },
			-- { "<leader>e", Util.tele_extn("file_browser", { path = "%:p:h" }), desc = "File Browser" },
			-- { "<leader>e", Util.tele_extn("file_browser"),                            desc = "File Browser" },
			-- { "<leader>k", Util.tele_extn("recent_files"), desc = "File Browser" },
			{ "fa",        Util.tele_builtin("autocommands"),                         desc = "Auto Commands" },
			{ "fc",        Util.tele_builtin("commands"),                             desc = "Commands" },
			{ "fd",        Util.tele_builtin("diagnostics"),                          desc = "Diagnostics" },
			{ "fh",        Util.tele_builtin("help_tags"),                            desc = "Help Pages" },
			{ "fH",        Util.tele_builtin("highlights"),                           desc = "Search Highlight Groups" },
			-- { "fk", Util.tele_builtin("keymaps"), desc = "Key Maps" },
			{ "fK",        Util.tele_builtin("search_history"),                       desc = "Key Maps" },
			{ "fm",        Util.tele_builtin("marks"),                                desc = "Jump to Mark" },
			{ "fo",        Util.tele_builtin("vim_options"),                          desc = "Options" },
			{ "fl",        Util.tele_extn("lazy"),                                    desc = "Lazy" },
			-- {
			-- 	"<leader>fe",
			-- 	Util.tele_builtin("colorscheme", { enable_preview = true }),
			-- 	desc = "Colorscheme with preview",
			-- },
			{
				"<leader>ggg",
				Util.telescope("lsp_document_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol",
			},
			{
				"<leader>S",
				Util.telescope("lsp_dynamic_workspace_symbols", {
					symbols = {
						"Class",
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol (Workspace)",
			},
		},
		config = function(_, _)
			-- local fb_actions = require("telescope._extensions.file_browser.actions")
			local actions = require("telescope.actions")
			--local trouble = require("trouble.providers.telescope")
			local lga_actions = require("telescope-live-grep-args.actions")
			local fb_actions = require "telescope._extensions.file_browser.actions"

			local opts = {
				defaults = {
					-- borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
					-- prompt_prefix = " ",
					prompt_prefix = "🔍 ",
					selection_caret = " ",
					file_ignore_patterns = {
						"%.jpeg$",
						"%.jpg$",
						"%.png$",
						".DS_Store",
						"%.aux",
						-- "%.pb.go$",
					},
					prompt_position = "top", -- no
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<C-m>"] = actions.select_default,
							-- ["<esc>"] = { actions.close, kind = "action", opts = { silent = true, nowait = true } }, -- error when trying to press escape
							["<C-c>"] = { "<esc>", type = "command" },
							-- ["<cr>"] = actions.select_tab_drop,
							-- i = {
							-- 	["<C-k>"] = actions.select_vertical,
							-- },
							-- n = {
							-- 	["<C-k>"] = actions.select_vertical,
							-- },
						}
					},
				},
				layout_config = {
					width = 0.75,
					height = 0.75,
					prompt_position = "top",
					horizontal = {
						preview_width = function(_, cols, _)
							if cols > 200 then
								return math.floor(cols * 0.4)
							else
								return math.floor(cols * 0.6)
							end
						end,
					},
					vertical = {
						preview_height = 0.5,
					},
				},
				pickers = {
					find_files = {
						theme = "dropdown",
						previewer = false,
						find_command = { "fd" },
						mappings = {
							i = {
								-- ["<CR>"] = require("telescope.actions").select_tab_drop
								["<C-m>"] = actions.select_default,
								["<C-f>"] = actions.select_default,
								["<C-]>"] = actions.select_default,
							}
						}
					},
				},
				extensions = {
					file_browser = {
						theme = "ivy",
						path = vim.loop.cwd(),
						-- path = '%:p:h',
						-- cwd = vim.loop.cwd(),
						cwd = vim.fn.expand('%:p:h'),
						cwd_to_path = false,
						grouped = false,
						files = true,
						add_dirs = true,
						depth = 1,
						auto_depth = false,
						select_buffer = false,
						hidden = { file_browser = false, folder_browser = false },
						respect_gitignore = vim.fn.executable "fd" == 1,
						no_ignore = false,
						follow_symlinks = false,
						browse_files = require("telescope._extensions.file_browser.finders").browse_files,
						browse_folders = require("telescope._extensions.file_browser.finders").browse_folders,
						hide_parent_dir = false,
						collapse_dirs = false,
						prompt_path = false,
						quiet = false,
						dir_icon = "",
						dir_icon_hl = "Default",
						display_stat = { date = true, size = true, mode = true },
						hijack_netrw = false,
						use_fd = true,
						git_status = true,
						mappings = {
							["i"] = {
								["<A-c>"] = fb_actions.create,
								["<S-CR>"] = fb_actions.create_from_prompt,
								["<A-r>"] = fb_actions.rename,
								["<A-m>"] = fb_actions.move,
								["<A-y>"] = fb_actions.copy,
								["<A-d>"] = fb_actions.remove,
								["<C-o>"] = fb_actions.open,
								["<C-g>"] = fb_actions.goto_parent_dir,
								["<C-e>"] = fb_actions.goto_home_dir,
								["<C-w>"] = fb_actions.goto_cwd,
								["<C-t>"] = fb_actions.change_cwd,
								["<C-f>"] = fb_actions.toggle_browser,
								["<C-h>"] = fb_actions.toggle_hidden,
								["<C-s>"] = fb_actions.toggle_all,
								["<bs>"] = fb_actions.backspace,
							},
							["n"] = {
								["c"] = fb_actions.create,
								["r"] = fb_actions.rename,
								["m"] = fb_actions.move,
								["y"] = fb_actions.copy,
								["d"] = fb_actions.remove,
								["o"] = fb_actions.open,
								["g"] = fb_actions.goto_parent_dir,
								["e"] = fb_actions.goto_home_dir,
								["w"] = fb_actions.goto_cwd,
								["t"] = fb_actions.change_cwd,
								["f"] = fb_actions.toggle_browser,
								["h"] = fb_actions.toggle_hidden,
								["s"] = fb_actions.toggle_all,
							},
						},
					},
					-- frecency = {
					-- 	show_scores = true,
					-- 	workspaces = {
					-- 		["conf"] = vim.fn.expand("~") .. "/.config",
					-- 		["doc"] = vim.fn.expand("~") .. "/Documents",
					-- 		["cor"] = vim.fn.expand("~") .. "/Documents/Courses",
					-- 	},
					-- },
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						-- define mappings, e.g.
						mappings = { -- extend mappings
							i = {
								["<C-h>"] = lga_actions.quote_prompt(),
								["<C-g>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
							},
						},
					},
					http = {
						-- How the mozilla url is opened. By default will be configured based on OS:
						open_url = "xdg-open %s", -- UNIX
						-- open_url = 'open %s' -- OSX
						-- open_url = 'start %s' -- Windows
					},
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
					recent_files = {
						-- This extension's options, see below.
						only_cwd = true,
					},
					aerial = {
						-- Display symbols as <root>.<parent>.<symbol>
						show_nesting = {
							["_"] = false, -- This key will be the default
							json = true, -- You can set the option for specific filetypes
							yaml = true,
						},
					},
					lsp_handlers = {
						code_action = {
							telescope = require("telescope.themes").get_ivy({}),
						},
					},
				},
			}

			local telescope = require("telescope")

			telescope.load_extension("fzf")
			telescope.load_extension("aerial")
			telescope.load_extension("recent_files")
			telescope.load_extension("ui-select")
			telescope.load_extension("live_grep_args")
			-- telescope.load_extension("http")
			telescope.load_extension("vim_bookmarks")
			telescope.load_extension("projects")
			telescope.load_extension("file_browser")
			telescope.load_extension("scope")

			-- vim.api.nvim_set_keymap({"n", "i"}, '<localleader>ca',
			-- 	':lua require("util.telescope-customcmd").showCommandBar()<CR>',
			-- 	{ noremap = true, silent = true })

			telescope.setup(opts)
			-- local extns = { "fzf", "lazy", "ui-select", "recent_files", "aerial", "lsp_handlers" }
			-- for _, extn in ipairs(extns) do
			-- 	telescope.load_extension(extn)
			-- end
		end,
	},
	{
		"edolphin-ydf/goimpl.nvim",
		enabled = true,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("telescope").load_extension("goimpl")
		end,
	},
}
