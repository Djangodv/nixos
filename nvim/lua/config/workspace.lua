-- Desc:
-- TODO: Split into multiple files?
-- FIX: Pattern not found

-- Auto change directory
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
	callback = function()
		local cwd = vim.fn.expand("%:p:h")
		local git_result = vim.system({ 'git', 'rev-parse', '--show-toplevel' }, { text = true, cwd = cwd }):wait()
		local git_root = git_result.stdout:gsub("\n", "")

		if git_root ~= '' and git_root ~= cwd then
			vim.cmd('silent! lcd' .. git_root)
		else
			vim.cmd('silent! lcd' .. cwd)
		end
	end
})

-- Auto-save
vim.api.nvim_create_autocmd({ 'FocusLost', 'BufLeave', 'CursorHold' }, {
	callback = function(args)
		local buffer_name = vim.api.nvim_buf_get_name(args.buf)
		local buffer_ro = vim.api.nvim_get_option_value("readonly", { buf = args.buf })
		local buffer_ft = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
		local buffer_type = vim.api.nvim_get_option_value("buftype", { buf = args.bug })
		-- Check if the buffer has a name (is not empty)
		if buffer_name ~= '' and buffer_ro ~= true and buffer_ft ~= 'fzf' and buffer_type ~= 'terminal' then
			vim.cmd("w") -- Save the buffer
		end
	end
})

-- Auto pop-up autocompletion for commands and searches
vim.api.nvim_create_autocmd("CmdlineChanged", {
	pattern = { ':', '/', '?' },
	callback = function()
		-- print(vim.inspect(vim.fn.getcmdline()))
		vim.fn.wildtrigger()
	end,
})

-- Set wildmode and wildoptions (needed for commandline completion)
vim.opt.wildmode = { "noselect", "full" }
vim.opt.wildoptions = { "fuzzy" }

-- Prevent <left> and <right> from cycling through wildmenu items
vim.keymap.set('c', '<left>', function()
	if vim.fn.wildmenumode() == 1 then
		return '<c-y><left>'
	else
		return '<left>'
	end
end, { expr = true })

vim.keymap.set('c', '<right>', function()
	if vim.fn.wildmenumode() == 1 then
		return '<c-y><right>'
	else
		return '<right>'
	end
end, { expr = true })
