-- Desc:

vim.api.nvim_create_autocmd({'BufEnter'}, {
	callback = function ()
		if vim.bo.buftype == 'terminal' then
			vim.cmd('startinsert')
		end
	end
})

vim.keymap.set('t', '<esc>', '<c-\\><c-n>')

current_buf = nil
current_win = nil
vim.api.nvim_create_user_command('Term', function()
	if current_buf == nil then
		vim.cmd('below split term://bash')
		-- TODO: Resize window slightly
		current_buf = vim.api.nvim_get_current_buf()
		current_win = vim.api.nvim_get_current_win()
		vim.api.nvim_set_option_value('buflisted', false, { buf = current_buf })
	else
		if vim.api.nvim_win_is_valid(current_win) then
			vim.api.nvim_win_hide(current_win)
		else
			vim.api.nvim_open_win(current_buf, true, { split = 'below', win = 0, })
			current_win = vim.api.nvim_get_current_win()
		end
	end
end, {})

vim.keymap.set({'t', 'n'}, '<c-j>', '<cmd>:Term<cr>')
