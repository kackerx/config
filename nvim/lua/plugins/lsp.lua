return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		enabled = true,
		config = function()
			require("mason").setup {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					},
					border = "rounded",
				},
				-- ensure_installed = {
				--     "gopls",
				--     "lua_ls"
				-- },
			}
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		enabled = true,
		event = "VeryLazy",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"bufls"
				}
			})
			require("mason-lspconfig").setup_handlers {
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name)
					-- default handler (optional)
					local lsp = require("lspconfig")
					local capabilities = require("cmp_nvim_lsp").default_capabilities()

					lsp[server_name].setup {
						capabilities = capabilities,
					}
				end,
				-- Next, you can provide a dedicated handler for specific servers.
				-- For example, a handler override for the `rust_analyzer`:
				-- ["rust_analyzer"] = function ()
				--     require("rust-tools").setup {}
				-- end

				-- ["bufls"] = function()
				-- 	require('lspconfig').bufls.setup {
				-- 		autostart = true,
				-- 		capabilities = require('cmp_nvim_lsp').default_capabilities(),
				-- 		cmd = { "pls" },
				-- 		filetypes = { "proto", "go" },
				-- 		root_dir = require('lspconfig/util').root_pattern('.git', '.buf.work.yaml', 'buf.yaml'),
				-- 		-- root_dir = "~/k/fbi/api/fbi/",
				-- 		settings = {},
				-- 	}
				-- end,
				["gopls"] = function()
					require("lspconfig").gopls.setup {
						autostart = true,
						--on_attach = require("lsp_signature").on_attach(),
						-- on_attach = function(client, bufnr)
						-- 自动调整package的导入顺序
						-- client.resolved_capabilities.document_formatting = true
						-- end,
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
						cmd = { "gopls" },
						filetypes = { "go", "gomod", "gowork", "gotmpl" },
						root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
						settings = {
							gopls = {
								completeUnimported = true,
								usePlaceholders = true,
								analyses = {
									unusedparams = true,
								},
								-- hints = {
								-- 	assignVariableTypes = true,
								-- 	compositeLiteralFields = true,
								-- 	compositeLiteralTypes = true,
								-- 	constantValues = true,
								-- 	functionTypeParameters = true,
								-- 	parameterNames = true,
								-- 	rangeVariableTypes = true,
								-- },

							}
						},
					}
				end,
			}
		end,
	},
	{
		'neovim/nvim-lspconfig',
		enabled = true,
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		event = "BufReadPre",
		config = function()
			require('lsp/handler')()
		end,
	},

	{
		'nvimdev/lspsaga.nvim',
		event = 'LspAttach',
		enabled = true,
		ft = { 'c', 'python', 'lua', 'rust', 'go' },
		config = function()
			require('lspsaga').setup({
				diagnostic = {
					diagnostic_only_current = true
				},
				symbol_in_winbar = {
					enable = true
				},
				implement = {
					enable = true,
					sign = true,
					virtual_text = "aa",
					priority = 100
				},
				callhierarchy = {
					keys = {
						edit = "<cr>",
					}
				},
				hover = {
					max_width = 0.4,
					max_height = 0.9
				},
				lightbulb = {
					enable = false,
					sign = false,
				},
				-- ui = {
				-- 	enable = false,
				-- 	sign = false,
				-- 	debounce = 0,
				-- 	sign_priority = 0,
				-- 	code_action = ''
				-- },
				finder = {
					keys = {
						toggle_or_open = '<cr>'
					}
				},
				outline = {
					keys = {
						toggle_or_jump = "<cr>"
					},
					close_after_jump = true,
					win_width = 35,
					left_width = 0.3,
					max_height = 0.7,
					layout = "float"
				}
			})
		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter', -- optional
			'nvim-tree/nvim-web-devicons' -- optional
		}
	},
	{
		"ray-x/lsp_signature.nvim",
		enabled = true,
		event = "BufReadPre",
		config = function()
			require "lsp_signature".setup({
				debug = false,                                  -- set to true to enable debug logging
				log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
				-- default is  ~/.cache/nvim/lsp_signature.log
				verbose = false,                                -- show debug line number

				bind = true,                                    -- This is mandatory, otherwise border config won't get registered.
				-- If you want to hook lspsaga or other signature handler, pls set to false
				doc_lines = 10,                                 -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
				-- set to 0 if you DO NOT want any API comments be shown
				-- This setting only take effect in insert mode, it does not affect signature help in normal
				-- mode, 10 by default

				floating_window = false,   -- show hint in a floating window, set to false for virtual text only mode

				floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
				-- will set to true when fully tested, set to false will use whichever side has more space
				-- this setting will be helpful if you do not want the PUM and floating win overlap

				floating_window_off_x = 0, -- adjust float windows x position.
				floating_window_off_y = 0, -- adjust float windows y position.


				fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
				hint_enable = true, -- virtual hint enable
				-- hint_prefix = "🐼 ", -- Panda for parameter
				hint_prefix = "π ", -- Panda for parameter
				hint_scheme = "String",
				hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
				max_height = 9, -- max height of signature floating_window, if content is more than max_height, you can scroll down
				-- to view the hiding contents
				max_width = 77, -- max_width of signature floating_window, line will be wrapped if exceed max_width
				handler_opts = {
					border = "rounded" -- double, rounded, single, shadow, none
				},

				always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

				auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
				extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
				zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

				padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

				transparency = nil, -- disabled by default, allow floating win transparent value 1~100
				shadow_blend = 36, -- if you using shadow as border use this set the opacity
				shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
				timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
				toggle_key = '<M-x>' -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
			})
		end
	},
	{
		"ray-x/go.nvim",
		enabled = true,
		event = "VeryLazy",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},

		config = function()
			require("go").setup {
				diagnostic = { -- set diagnostic to false to disable vim.diagnostic setup
					hdlr = false, -- hook lsp diag handler and send diag to quickfix
					underline = false,
					-- virtual text setup
					virtual_text = false,
					signs = true,
					update_in_insert = false,
				},
				-- lsp_inlay_hints = {
				-- 	enable = true,
				-- }
				floaterm = { -- position
					posititon = 'bottom', -- one of {`top`, `bottom`, `left`, `right`, `center`, `auto`}
					width = 0.98, -- width of float window if not auto
					height = 0.35, -- height of float window if not auto
					title_colors = 'nord', -- default to nord, one of {'nord', 'tokyo', 'dracula', 'rainbow', 'solarized ', 'monokai'}
					-- can also set to a list of colors to define colors to choose from
					-- e.g {'#D8DEE9', '#5E81AC', '#88C0D0', '#EBCB8B', '#A3BE8C', '#B48EAD'}
				},
				comment_placeholder = '',
				lsp_inlay_hints = {
					enable = true,
					-- hint style, set to 'eol' for end-of-line hints, 'inlay' for inline hints
					-- inlay only avalible for 0.10.x

					style = 'eol',

					-- Note: following setup only works for style = 'eol', you do not need to set it for 'inlay'
					-- Only show inlay hints for the current line
					only_current_line = true,

					-- Event which triggers a refersh of the inlay hints.
					-- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
					-- not that this may cause higher CPU usage.
					-- This option is only respected when only_current_line and
					-- autoSetHints both are true.
					-- only_current_line_autocmd = "CursorHold",
					-- whether to show variable name before type hints with the inlay hints or not
					-- default: false
					show_variable_name = true,
					-- prefix for parameter hints
					parameter_hints_prefix = "󰊕 ",
					show_parameter_hints = true,
					-- prefix for all the other hints (type, chaining)
					other_hints_prefix = "=> ",
					-- whether to align to the lenght of the longest line in the file
					max_len_align = false,
					-- padding from the left if max_len_align is true
					max_len_align_padding = 1,
					-- whether to align to the extreme right or not
					right_align = false,
					-- padding from the right if right_align is true
					right_align_padding = 6,
					-- The color of the hints
					highlight = "Comment",
				},
			}
		end,
		event = { "CmdlineEnter" },
		ft = { "go", 'gomod' },
		build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries

	}
}
