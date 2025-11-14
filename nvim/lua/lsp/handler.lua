return function()
	-- Global mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	-- vim.keymap.set("n", "gt", vim.diagnostic.open_float) -- 异常的诊断窗口
	-- vim.keymap.set("n", "gk", vim.diagnostic.goto_prev)
	-- vim.keymap.set({ "n" }, "gj", vim.diagnostic.goto_next)
	--vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

	---.uu
	---
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end
	--
	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		-- signs = {
		--     active = signs,
		-- },
		update_in_insert = true,
		underline = false,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	-- 	border = "rounded",
	-- })

	-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	--     border = "rounded",
	-- })

	-- Use LspAttach autocommand to only map the following keys
	-- after the language server attaches to the current buffer
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			-- Enable completion triggered by <c-x><c-o>
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = { buffer = ev.buf }
			-- vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
			-- vim.keymap.set("n", "gf", vim.lsp.buf.definition, opts)
			-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			-- vim.keymap.set("n", "gv", vim.lsp.buf.implementation, opts)
			-- vim.keymap.set("n", "<leader>rb", vim.lsp.buf.rename, opts)
			-- vim.keymap.set("n", "<leader>ll", function()
			-- 	vim.lsp.buf.format({ async = true, timeout_ms = 4000 })
			-- end, opts)

			vim.keymap.set("n", "<space>gf", vim.lsp.buf.hover, opts)
			-- vim.keymap.set("n", "gu", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set("n", "<space>wf", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			vim.keymap.set("n", "<space>d", vim.lsp.buf.type_definition, opts)
			-- vim.keymap.set({ "n", "v", "i" }, "<localleader>ca", vim.lsp.buf.code_action, opts)
		end,
	})
	-- vim.api.nvim_create_autocmd('LspTokenUpdate', {
	--     callback = function(args)
	--         print(1)
	--         local token = args.data.token
	--         print(1)
	--         if token.type == 'variable' and not token.modifiers.readonly then
	--             print(1)
	--             vim.lsp.semantic_tokens.highlight_token(
	--                 token, args.buf, args.data.client_id, 'MyMutableVariableHighlight'
	--             )
	--         end
	--     end,
	-- })
end
