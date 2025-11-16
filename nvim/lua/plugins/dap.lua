return {
	{
		"mfussenegger/nvim-dap",
		enabled = true,
		event = "VeryLazy",
		dependencies = {

			-- fancy UI for the debugger
			{
				"rcarriga/nvim-dap-ui",
				{
					"stevearc/conform.nvim",
					opts = {},
				},
				keys = {
					{
						"<leader>du",
						function()
							require("dapui").toggle({})
						end,
						desc = "Dap UI",
					},
					{
						"<leader>de",
						function()
							require("dapui").eval()
						end,
						desc = "Eval",
						mode = { "n", "v" },
					},
				},
				opts = {},
				config = function(_, opts)
					-- setup dap config by VsCode launch.json file
					-- require("dap.ext.vscode").load_launchjs()
					local dap = require("dap")
					local dapui = require("dapui")
					dapui.setup(opts)
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open({})
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close({})
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close({})
					end
				end,
			},

			-- virtual text for the debugger
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},

			-- which key integration
			{
				"folke/which-key.nvim",
				optional = true,
				opts = {
					defaults = {
						["<leader>d"] = { name = "+debug" },
					},
				},
			},

			-- mason.nvim integration
			{
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = "mason.nvim",
				cmd = { "DapInstall", "DapUninstall" },
				opts = {
					-- Makes a best effort to setup the various debuggers with
					-- reasonable debug configurations
					automatic_installation = true,

					-- You can provide additional configuration to the handlers,
					-- see mason-nvim-dap README for more information
					handlers = {},

					-- You'll need to check that you have the required things installed
					-- online, please don't ask me how to install them :)
					ensure_installed = {
						-- Update this to ensure that you have the debuggers for the langs you want
					},
				},
			},
		},


		-- stylua: ignore
		keys = {
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
			{ "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
			{ "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
			{ "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
			-- { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
			{
				"<leader>dg",
				function()
					require('dap-go').debug_test()
				end,
				desc = "debug go test"
			},
			{ "<leader>di", function() require("dap").step_into() end,        desc = "Step Into" },
			{ "<leader>dj", function() require("dap").down() end,             desc = "Down" },
			{ "<leader>dk", function() require("dap").up() end,               desc = "Up" },
			{ "<leader>dl", function() require("dap").run_last() end,         desc = "Run Last" },
			{ "<leader>do", function() require("dap").step_out() end,         desc = "Step Out" },
			{ "<leader>dO", function() require("dap").step_over() end,        desc = "Step Over" },
			{ "<leader>dp", function() require("dap").pause() end,            desc = "Pause" },
			{ "<leader>dr", function() require("dap").repl.toggle() end,      desc = "Toggle REPL" },
			{ "<leader>ds", function() require("dap").session() end,          desc = "Session" },
			{ "<leader>dt", function() require("dap").terminate() end,        desc = "Terminate" },
			{ "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
			{ "<leader>de", function() require("dapui").eval() end,           desc = "Widgets" },
		},

		config = function()
			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
			local dap_breakpoint = {
				error = {
					text = "🔴",
					texthl = "LspDiagnosticsSignError",
					linehl = "",
					numhl = "",
				},
				rejected = {
					text = "",
					texthl = "LspDiagnosticsSignHint",
					linehl = "",
					numhl = "",
				},
				stopped = {
					text = "🟢",
					texthl = "LspDiagnosticsSignInformation",
					linehl = "k.debug",
					numhl = "LspDiagnosticsSignInformation",
				},
			}

			vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
			vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
			vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle({})
				end,
				desc = "Dap UI",
			},
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				desc = "Eval",
				mode = { "n", "v" },
			},
		},
		config = function()
			require("dapui").setup({
				controls = {
					element = "repl",
					enabled = true,
					icons = {
						disconnect = "",
						pause = "",
						play = "",
						run_last = "",
						step_back = "",
						step_into = "",
						step_out = "",
						step_over = "",
						terminate = "",
					},
				},
				element_mappings = {},
				expand_lines = true,
				floating = {
					border = "single",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				force_buffers = true,
				icons = {
					collapsed = "",
					current_frame = "",
					expanded = "",
				},
				layouts = {
					{
						elements = {
							{
								id = "scopes",
								size = 0.7,
							},
							-- {
							-- 	id = "stacks",
							-- 	size = 0.2,
							-- },
							{
								id = "watches",
								size = 0.3
							},
							-- {
							-- 	id = "breakpoints",
							-- 	size = 0.1,
							-- },
						},
						position = "left",
						size = 40,
					},
					{
						elements = {
							{
								id = "repl",
								size = 0.8,
							},
							{
								id = "console",
								size = 0.2,
							},
						},
						position = "bottom",
						size = 16,
					},
				},
				mappings = {
					edit = "e",
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					repl = "r",
					toggle = "t",
				},
				render = {
					indent = 1,
					max_value_lines = 100,
				},
			})
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
	{
		'leoluz/nvim-dap-go',
		enabled = true,
		event = "VeryLazy",
		config = function()
			require('dap-go').setup {
				-- Additional dap configurations can be added.
				-- dap_configurations accepts a list of tables where each entry
				-- represents a dap configuration. For more details do:
				-- :help dap-configuration
				dap_configurations = {
					{
						-- Must be "go" or it will be ignored by the plugin
						type = "go",
						name = "Attach remote",
						mode = "remote",
						request = "attach",
					},
					{
						type = "go",
						name = "Debug Main Serve",
						request = "launch",
						cwd = '${workspaceFolder}',
						program = "${workspaceFolder}/main.go",
						args = {"serve"}, 
					}
				},
				-- delve configurations
				delve = {
					-- the path to the executable dlv which will be used for debugging.
					-- by default, this is the "dlv" executable on your PATH.
					path = "dlv",
					-- time to wait for delve to initialize the debug session.
					-- default to 20 seconds
					initialize_timeout_sec = 20,
					-- a string that defines the port to start delve debugger.
					-- default to string "${port}" which instructs nvim-dap
					-- to start the process in a random available port
					port = "${port}",
					-- additional args to pass to dlv
					args = {},
					-- the build flags that are passed to delve.
					-- defaults to empty string, but can be used to provide flags
					-- such as "-tags=unit" to make sure the test suite is
					-- compiled during debugging, for example.
					-- passing build flags using args is ineffective, as those are
					-- ignored by delve in dap mode.
					build_flags = "",
				},
			}
		end
	}
}
