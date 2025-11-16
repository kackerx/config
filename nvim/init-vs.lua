-- 设置 leader 键（默认为 \）
vim.g.mapleader = " "

vim.api.nvim_set_hl(0, 'Search', {
  fg = 'black',     -- 前景色（文字颜色）
  bg = 'yellow',    -- 背景色
  bold = true,      -- 加粗（可选）
  underline = true, -- 下划线（可选）
})

require("config.options")
require("config.lazy-vs")

-- 定义操作（如 `cia` 和 `caa`）
vim.keymap.set("n", "cia", "c<Plug>(textobj-parameter-i)", { desc = "Inner parameter" })
vim.keymap.set("n", "caa", "c<Plug>(textobj-parameter-a)", { desc = "Around parameter" })
vim.keymap.set("n", "dia", "d<Plug>(textobj-parameter-i)", { desc = "Inner parameter" })
vim.keymap.set("n", "daa", "d<Plug>(textobj-parameter-a)", { desc = "Around parameter" })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
vim.keymap.set("n", "cf", "ct", { desc = "Around parameter" })
vim.keymap.set("n", "ct", "cf", { desc = "Around parameter" })

vim.keymap.set({ "n", "v" }, 'H', '5h', { desc = "down" })
vim.keymap.set({ "n", "v" }, 'J', '5j', { desc = "down" })
vim.keymap.set({ "n", "v" }, 'K', '5k', { desc = "down" })
vim.keymap.set({ "n", "v" }, 'L', '5l', { desc = "down" })

vim.keymap.set("n", 'U', '<C-r>', { desc = "down" })
vim.keymap.set("n", 'm', '~', { desc = "down" })
vim.keymap.set("n", 'c(', 'ci(', { desc = "down" })
vim.keymap.set("n", 'd(', 'di(', { desc = "down" })
vim.keymap.set("n", 'c{', 'ci{', { desc = "down" })
vim.keymap.set("n", 'd{', 'di{', { desc = "down" })
vim.keymap.set("n", 'd"', 'di"', { desc = "down" })
vim.keymap.set("n", 'c"', 'ci"', { desc = "down" })
vim.keymap.set("n", "d'", "di'", { desc = "down" })
vim.keymap.set("n", "c'", "ci'", { desc = "down" })


vim.keymap.set({'n'}, 'yz', function() vim.fn.VSCodeNotify('yazi-vscode.toggle') end,
 { silent = true })
vim.keymap.set({'n', 'v'}, 'gn', function() vim.fn.VSCodeNotify('git-worktree-manager.addWorktree') end,
 { silent = true })
vim.keymap.set({'n', 'v'}, 'gw', function() vim.fn.VSCodeNotify('git-worktree-manager.openWorkspaceWorktree') end,
 { silent = true })
vim.keymap.set({'n', 'v'}, '<leader>/', function() vim.fn.VSCodeNotify('find-it-faster.findWithinFiles') end,
 { silent = true })
vim.keymap.set('n', '<leader>\\', function() vim.fn.VSCodeNotify('workbench.action.findInFiles') end, { silent = true })
vim.keymap.set('n', 'fp', function() vim.fn.VSCodeNotify('projectManager.listProjectsNewWindow') end, { silent = true })
-- vim.keymap.set('n', '<leader>qq', function() vim.fn.VSCodeNotify('rest-client.request') end, { silent = true })
vim.keymap.set('n', '<leader>q', function() vim.fn.VSCodeNotify('rest-client.history') end, { silent = true })
vim.keymap.set('n', '<leader>r', function() vim.fn.VSCodeNotify('rest-client.rerun-last-request') end, { silent = true })
vim.keymap.set('n', 'gc', function() vim.fn.VSCodeNotify('workbench.debug.panel.action.clearReplAction') end, { silent = true })
vim.keymap.set('n', 'ff', function() vim.fn.VSCodeNotify('editor.toggleFold') end, { silent = true })
vim.keymap.set('n', 'ga', function() vim.fn.VSCodeNotify('workbench.view.scm') end, { silent = true })

vim.keymap.set('n', 'fm', function() vim.fn.VSCodeNotify('editor.action.rename') end, { silent = true })
vim.keymap.set('n', '<leader>k', function() vim.fn.VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed') end,
	{ silent = true })
vim.keymap.set({'n', 'v'}, '<leader>s', function() vim.fn.VSCodeNotify('workbench.action.gotoSymbol') end, { silent = true })
vim.keymap.set({'n', 'v'}, '<leader>S', function() vim.fn.VSCodeNotify('workbench.action.showAllSymbols') end, { silent = true })
vim.keymap.set('n', '<leader>l', function() 
	vim.fn.VSCodeNotify('editor.action.formatDocument') 
	vim.fn.VSCodeNotify('editor.action.organizeImports') 
end, { silent = true })
vim.keymap.set('n', '\\', function() vim.fn.VSCodeNotify('workbench.action.showCommands') end, { silent = true })

vim.keymap.set('n', 'gl', function() vim.fn.VSCodeNotify('lazygit-vscode.toggle') end,
	{ silent = true, remap = false })
vim.keymap.set('n', 'gh', function() vim.fn.VSCodeNotify('gitlens.createPullRequestOnRemote') end,
	{ silent = true, remap = false })
vim.keymap.set('n', 'gt', function() vim.fn.VSCodeNotify('git.revertSelectedRanges') end,
	{ silent = true, remap = false })
vim.keymap.set('n', 'gu', function() vim.fn.VSCodeNotify('git.openChange') end,
	{ silent = true, remap = false })
vim.keymap.set('n', 'gj', function() vim.fn.VSCodeNotify('workbench.action.editor.nextChange') end,
	{ silent = true, remap = false })
vim.keymap.set('n', 'gk', function() vim.fn.VSCodeNotify('workbench.action.editor.previousChange') end,
	{ silent = true, remap = false })
vim.keymap.set('n', 'gb', function() vim.fn.VSCodeNotify('git.checkout') end, { silent = true, remap = false })
vim.keymap.set('n', 'gu', function() vim.fn.VSCodeNotify('editor.action.dirtydiff.next') end, { silent = true, remap = false })
vim.keymap.set('n', 'gU', function() vim.fn.VSCodeNotify('git.openChange') end, { silent = true, remap = false })
vim.keymap.set('n', 'gD', function() vim.fn.VSCodeNotify('gitlens.diffWithRevisionFrom') end, { silent = true, remap = false })

vim.keymap.set('n', 'fj', function() vim.fn.VSCodeNotify('editor.action.marker.next') end,
	{ silent = true, remap = false })

vim.keymap.set('n', 'fk', function() vim.fn.VSCodeNotify('editor.action.marker.prev') end,
	{ silent = true, remap = false })
vim.keymap.set('n', 'fg', function() vim.fn.VSCodeNotify('editor.action.showDefinitionPreviewHover') end,
	{ silent = true, remap = false })

vim.keymap.set('n', '<leader>y', function() vim.fn.VSCodeNotify('breadcrumbs.focusAndSelect') end,
	{ silent = true, remap = false })

vim.keymap.set('n', '<leader>wl', function() vim.fn.VSCodeNotify('workbench.action.moveEditorToRightGroup') end,
	{ silent = true, remap = false })
vim.keymap.set('n', '<leader>wh', function() vim.fn.VSCodeNotify('workbench.action.moveEditorToLeftGroup') end,
	{ silent = true, remap = false })
vim.keymap.set('n', '<leader>wL', function() vim.fn.VSCodeNotify('workbench.action.splitEditorRight') end,
	{ silent = true, remap = false })
vim.keymap.set('n', '<leader>wH', function() vim.fn.VSCodeNotify('workbench.action.splitEditorLeft') end,
	{ silent = true, remap = false })
vim.keymap.set('n', '<leader>wj', function() vim.fn.VSCodeNotify('workbench.action.splitEditorDown') end,
	{ silent = true, remap = false })
vim.keymap.set('n', '<leader>wk', function() vim.fn.VSCodeNotify('workbench.action.splitEditorUp') end,
	{ silent = true, remap = false })
vim.keymap.set('n', '<leader>wq', function() vim.fn.VSCodeNotify('workbench.action.pinEditor') end,
	{ silent = true, remap = false })
vim.keymap.set('n', '<leader>wQ', function() vim.fn.VSCodeNotify('workbench.action.unpinEditor') end,
	{ silent = true, remap = false })
vim.keymap.set('n', '<leader>wz', function() vim.fn.VSCodeNotify('workbench.action.toggleMaximizeEditorGroup') end,
	{ silent = true, remap = false })
vim.keymap.set('n', '<leader>wa', function() vim.fn.VSCodeNotify('workbench.action.closeWindow') end,
	{ silent = true, remap = false })
vim.keymap.set('n', '<leader>ww', function() vim.fn.VSCodeNotify('workbench.action.closeEditorsInGroup') end,
	{ silent = true, remap = false })

vim.keymap.set('n', '<leader>f', function() vim.fn.VSCodeNotify('workbench.action.quickOpen') end,
	{ silent = true, remap = false })

vim.keymap.set('v', 'Y', '"+y', { noremap = true, silent = true })

vim.opt.formatoptions:remove('o')

-- bookmark
vim.keymap.set('n', '<leader>na', function() vim.fn.VSCodeNotify('vsc-labeled-bookmarks.toggleLabeledBookmark') end, { silent = true })
vim.keymap.set('n', '<leader>m', function() vim.fn.VSCodeNotify('vsc-labeled-bookmarks.navigateToBookmarkOfAnyGroup') end, { silent = true })
vim.keymap.set('n', '<leader>nd', function() vim.fn.VSCodeNotify('vsc-labeled-bookmarks.deleteBookmark') end, { silent = true })

vim.keymap.set("n", "cw", "ce", { desc = "down" })
vim.keymap.set("n", "dw", "de", { desc = "down" })
