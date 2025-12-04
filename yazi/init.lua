require("full-border"):setup()

if os.getenv("VSCODE") then
	require("toggle-pane"):entry("min-preview")
end

-- th.git.modified
-- th.git.added
-- th.git.untracked
-- th.git.ignored
-- th.git.deleted
-- th.git.updated
th.git = th.git or {}
th.git.modified = ui.Style():fg("blue")
th.git.deleted = ui.Style():fg("red"):bold()
require("git"):setup()

require("githead"):setup({
  order = {
    "__spacer__",
    "stashes",
    "__spacer__",
    "state",
    "__spacer__",
    "staged",
    "__spacer__",
    "unstaged",
    "__spacer__",
    "untracked",
    "__spacer__",
    "branch",
    "remote_branch",
    "__spacer__",
    "tag",
    "__spacer__",
    "commit",
    "__spacer__",
    "behind_ahead_remote",
    "__spacer__",
  },

  branch_borders = "{}",
  branch_prefix = "|",
  branch_color = "#7aa2f7",
  remote_branch_color = "#9ece6a",
  always_show_remote_branch = true,
  always_show_remote_repo = true,

  tag_symbol = "󰓼",
  always_show_tag = true,
  tag_color = "#bb9af7",

  commit_symbol = "",
  always_show_commit = true,
  commit_color = "#e0af68",

  staged_color = "#73daca",
  staged_symbol = "●",

  unstaged_color = "#e0af68",
  unstaged_symbol = "✗",

  untracked_color = "#f7768e",
  untracked_symbol = "?",

  state_color = "#f5c359",
  state_symbol = "󱐋",

  stashes_color = "#565f89",
  stashes_symbol = "⚑",
})

-- ~/.config/yazi/init.lua
function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d  %Y", time)
	end

	local size = self._file:size()
	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end

require("mactag"):setup {
	-- Keys used to add or remove tags
	keys = {
		r = "Red",
		o = "Orange",
		y = "Yellow",
		g = "Green",
		b = "Blue",
		p = "Purple",
	},
	-- Colors used to display tags
	colors = {
		Red    = "#ee7b70",
		Orange = "#f5bd5c",
		Yellow = "#fbe764",
		Green  = "#91fc87",
		Blue   = "#5fa3f8",
		Purple = "#cb88f8",
	},
}

-- ~/.config/yazi/init.lua
require("bookmarks"):setup({
	last_directory = { enable = false, persist = false, mode="dir" },
	persist = "all",
	desc_format = "full",
	file_pick_mode = "hover",
	custom_desc_input = false,
	show_keys = false,
	notify = {
		enable = true,
		timeout = 1,
		message = {
			new = "New bookmark '<key>' -> '<folder>'",
			delete = "Deleted bookmark in '<key>'",
			delete_all = "Deleted all bookmarks",
		},
	},
})
