local telescope = require 'telescope'
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local entry_display = require 'telescope.pickers.entry_display'
local themes = require 'telescope.themes'


local M = {}

local commands = {
	{
		name = 'GoImpl',
		category = "go",
		description = "实现接口",
		action = function()
			vim.cmd([[Telescope goimpl theme=ivy winblend=30]])
		end
	},
	{
		name = 'GoAddTag',
		description = "添加tag",
		category = "go",
		action = function()
			vim.cmd([[GoAddTag]])
		end
	},
	{
		name = 'GoRun',
		description = "运行",
		category = "go",
		action = function()
			vim.cmd([[GoRun -F %]])
		end
	},
	{
		name = 'GoTestFunc',
		category = "go",
		description = "测试当前函数",
		action = function()
			vim.cmd([[lua require('dap-go').debug_test()]])
		end
	},
	{
		name = 'GoCodeAction',
		category = "go",
		description = "代码操作",
		action = function()
			vim.cmd([[GoCodeAction]])
		end
	},
	{
		name = 'GoFillStruct',
		category = "go",
		description = "补全字段",
		action = function()
			vim.cmd([[GoFillStruct]])
		end
	},
	{
		name = 'GoImport',
		category = "go",
		description = "补全import",
		action = function()
			vim.cmd([[GoImports]])
		end
	},
	{
		name = 'GoCmt',
		category = "go",
		description = "添加注释",
		action = function()
			vim.cmd([[GoCmt]])
		end
	},
	{
		name = 'GoLint',
		category = "go",
		description = "代码规范检测",
		action = function()
			vim.cmd([[GoLint]])
		end
	},
	{
		name = 'Refactor',
		category = "k",
		description = "重构",
		action = function()
			vim.cmd([[lua require('refactoring').select_refactor()]])
		end
	},
	--------------------------------------------------------
	{
		name = 'OutGoing',
		category = "saga",
		description = "调用函数列表",
		action = function()
			vim.cmd([[Lspsaga outgoing_calls]])
		end
	},
	{
		name = 'InComing',
		category = "saga",
		description = "被调函数列表",
		action = function()
			vim.cmd([[Lspsaga incoming_calls]])
		end
	},
	{
		name = 'ReName',
		category = "saga",
		description = "重命名",
		action = function()
			vim.cmd([[Lspsaga rename]])
		end
	},
}

local longest_command_name = 0
for _, command in ipairs(commands) do
	if #command.name > longest_command_name then
		longest_command_name = #command.name
	end
end

local displayer = entry_display.create {
	separator = " ",
	items = {
		{ width = longest_command_name + 2 },
		-- The final column can be set to fill the remaining space
		{ width = 20 },
		{ remaining = true },
	},
}

local finder = finders.new_table {
	results = commands,
	entry_maker = function(entry)
		return {
			value = entry,
			display = function(ent)
				return displayer {
					ent.value.name,
					{ ent.value.category,    "TelescopeResultsComment" },
					{ ent.value.description, "TelescopeResultsComment" }
				}
			end,
			ordinal = entry.name,
		}
	end,
}

M.showCommandBar = function(opts)
	opts = opts or {}

	local conf = require 'telescope.config'.values
	local actions = require 'telescope.actions'
	local action_state = require 'telescope.actions.state'

	pickers.new(themes.get_cursor(opt), {
		prompt_title = 'Common commands',
		finder = finder,
		-- Use the default sorter
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			map('i', '<CR>', function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry(prompt_bufnr)
				selection.value.action()
			end)
			return true
		end,
	}):find()
end

return M
