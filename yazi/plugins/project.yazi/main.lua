-- ~/.config/yazi/plugins/project.yazi/main.lua
-- 这是一个自定义插件，用于在当前 git 项目的根目录中，通过 fzf 查找文件或目录，然后跳转。

return {
  entry = function()
    -- 1. 使用 yazi 的 API 获取 git 根目录，如果失败则使用当前目录
    local root = ya.capture("git rev-parse --show-toplevel 2>/dev/null")
    root = root:gsub("[\n\r]$", "") -- 清理命令输出末尾的换行符
    if root == "" then
      root = ya.env.PWD
    end

    -- 2. 同样，用 yazi 的 API 获取 fd 和 fzf 的路径
    local fd = ya.capture("which fd"):gsub("[\n\r]$", "")
    local fzf = ya.capture("which fzf"):gsub("[\n\r]$", "")

    -- 如果找不到 fd 或 fzf，则发出通知并退出，避免卡死
    if fd == "" or fzf == "" then
      ya.notify_error("`fd` or `fzf` command not found")
      return
    end

    -- 3. 构造最终要执行的命令
    local cmd = string.format(
      -- 在 fd 命令中我们不再只搜索目录 (--type d)，而是搜索所有文件和目录
      '%s . %s --hidden --exclude .git | %s',
      fd,
      ya.shell_escape(root), -- 使用 yazi 的 API 来安全地转义路径
      fzf
    )

    -- 4. 调用 yazi 的核心同步 shell API
    --    这才是正确处理交互式命令的方法！
    local success, stdout = ya.sync_sh({
      cmd = cmd,
      block = true,       -- 阻塞 yazi 的 UI
      interactive = true, -- 明确告诉 yazi这是一个交互式命令
    })

    -- 5. 如果成功并且用户确实选择了，则跳转
    if success and stdout ~= "" then
      ya.manager_emit("cd", { url = stdout })
    end
  end,
}