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

-- bookmarks
-- You can also configure bookmarks with key arrays
local bookmarks = {
  -- { tag = "Desktop", path = "~/Desktop", key = { "d", "D" } },
  -- { tag = "Documents", path = "~/Documents", key = { "d", "d" } },
  { tag = "Downloads", path = "~/Downloads", key = "o", "o" },
  { tag = "Config", path = "~/.config", key = "o", "d" },
}

-- Windows-specific bookmarks
if ya.target_family() == "windows" then
  local home_path = os.getenv("USERPROFILE")
  table.insert(bookmarks, {
    tag = "Scoop Local",
    path = os.getenv("SCOOP") or (home_path .. "\\scoop"),
    key = "p"
  })
  table.insert(bookmarks, {
    tag = "Scoop Global",
    path = os.getenv("SCOOP_GLOBAL") or "C:\\ProgramData\\scoop",
    key = "P"
  })
end

require("whoosh"):setup {
  -- Configuration bookmarks (cannot be deleted through plugin)
  bookmarks = bookmarks,

  -- Notification settings
  jump_notify = false,

  -- Key generation for auto-assigning bookmark keys
  keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

  -- Configure the built-in menu action hotkeys
  -- false - hide menu item
  special_keys = {
    create_temp = "<Enter>",         -- Create a temporary bookmark from the menu
    fuzzy_search = "<Space>",        -- Launch fuzzy search (fzf)
    history = "<Tab>",               -- Open directory history
    previous_dir = "<Backspace>",    -- Jump back to the previous directory
  },

  -- File path for storing user bookmarks
  bookmarks_path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\plugins\\whoosh.yazi\\bookmarks") or
         (os.getenv("HOME") .. "/.config/yazi/plugins/whoosh.yazi/bookmarks"),

  -- Replace home directory with "~"
  home_alias_enabled = true,                            -- Toggle home aliasing in displays

  -- Path truncation in navigation menu
  path_truncate_enabled = false,                        -- Enable/disable path truncation
  path_max_depth = 3,                                   -- Maximum path depth before truncation

  -- Path truncation in fuzzy search (fzf)
  fzf_path_truncate_enabled = false,                    -- Enable/disable path truncation in fzf
  fzf_path_max_depth = 5,                               -- Maximum path depth before truncation in fzf

  -- Long folder name truncation
  path_truncate_long_names_enabled = false,             -- Enable in navigation menu
  fzf_path_truncate_long_names_enabled = false,         -- Enable in fzf
  path_max_folder_name_length = 20,                     -- Max length in navigation menu
  fzf_path_max_folder_name_length = 20,                 -- Max length in fzf

  -- History directory settings
  history_size = 10,                                    -- Number of directories in history (default 10)
  history_fzf_path_truncate_enabled = false,            -- Enable/disable path truncation by depth for history
  history_fzf_path_max_depth = 5,                       -- Maximum path depth before truncation for history (default 5)
  history_fzf_path_truncate_long_names_enabled = false, -- Enable/disable long folder name truncation for history
  history_fzf_path_max_folder_name_length = 30,         -- Maximum length for folder names in history (default 30)
}

