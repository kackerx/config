--- @since 25.5.31

local function get_git_toplevel()
	local command = "git rev-parse --show-toplevel 2>&1"
	local handle = io.popen(command)
	local result = handle:read("*a")
	local status_table = { handle:close() }
	local status_code = status_table[3]

	if status_code == 0 then
		local destination = result:gsub("[\n\r]", "") .. "/"
		return destination
	else
		return nil
	end
end

return {
	entry = function()
		local destination = get_git_toplevel()
		ya.dbg(destination)
		if destination then
			local target = Url(destination)
			ya.emit("cd", { target })
		else
			ya.notify({
				title = "Could not change directory!",
				content = "You are not in a git repository.",
				timeout = 3,
				level = "error",
			})
		end
	end,
}
