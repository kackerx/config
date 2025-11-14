return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	opts = function()
		local logo = [[
         ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
         ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
         ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
         ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
         ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
         ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
    ]]

		logo = string.rep("\n", 8) .. logo .. "\n\n"

		local opts = {
			theme = "hyper",
			hide = {
				-- this is taken care of by lualine
				-- enabling this messes up the actual laststatus setting after loading a file
				statusline = false,
			},
			config = {
				header = vim.split(logo, "\n"),
				week_header = {
					enable = true,
				},
				packages = { enabled = true },
				shortcut = {
					{
						action = "Telescope find_files",
						desc = " Find",
						icon = "",
						key = "f",
						group = "@debug",
					},
					{
						action = "ene | startinsert",
						desc = " New",
						icon = "",
						key = "n",
						group = "@float",
					},
					{
						action = "lua require('telescope').extensions.recent_files.pick(require('telescope.themes').get_ivy({ winblend = 10 }))",
						desc = " Recent",
						icon = "",
						key = "r",
						group = "@annotation",
					},
					{
						action = "Telescope live_grep",
						desc = " Grep",
						icon = "",
						key = "g",
						group = "@variable",
					},
					{
						action = 'lua require("persistence").load()',
						desc = "Session",
						icon = "",
						key = "s",
						group = "@define",
					},
					{
						action = [[lua require('telescope.builtin').find_files({cwd = "~/.config"})]],
						desc = " Config",
						icon = "",
						key = "c",
						group = "@function",
					},
					{
						action = "qa",
						desc = " Quit",
						icon = "",
						key = "q",
						group = "@tag.delimiter",
					},
				},
				center = {
					{
						action = "Telescope find_files",
						desc = " Find file",
						icon = " ",
						key = "f",
					},
					{
						action = "ene | startinsert",
						desc = " New file",
						icon = " ",
						key = "n",
					},
					{
						action = "<leader>k",
						desc = " Recent files",
						icon = " ",
						key = "k",
					},
					{
						action = "Telescope live_grep",
						desc = " Find text",
						icon = " ",
						key = "g",
					},
					{
						action = [[lua require("lazyvim.util").telescope.config_files()()]],
						desc = " Config",
						icon = " ",
						key = "c",
					},
					{
						action = 'lua require("persistence").load()',
						desc = " Restore Session",
						icon = " ",
						key = "s",
					},
					{
						action = "LazyExtras",
						desc = " Lazy Extras",
						icon = " ",
						key = "x",
					},
					{
						action = "Lazy",
						desc = " Lazy",
						icon = "󰒲 ",
						key = "l",
					},
					{
						action = "qa",
						desc = " Quit",
						icon = " ",
						key = "q",
					},
				},
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
				end,
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			button.key_format = "  %s"
		end

		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "DashboardLoaded",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		return opts
	end,
}
