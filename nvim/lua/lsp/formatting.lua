-- Desc:

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- Auto-format upon save
		vim.api.nvim_create_autocmd('BufWritePre', {
			buffer = args.buf,
			callback = function()
				vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
			end
		})
		-- Formatting with a keybind
		if client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_user_command('Format', function()
				vim.lsp.buf.format()
			end, {})
		end
	end,
})
