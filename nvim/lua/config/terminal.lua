-- Desc:

-- Make sure terminal starts in insert mode
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
	callback = function()
		if vim.bo.buftype == 'terminal' then
			vim.cmd('startinsert')
		end
	end
})

-- Exit insert mode inside terminal with <esc>
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')

Term_buf = nil
Term_win = nil
-- Needed for the :Run command in 'config.coderunner'
Term_chan = nil

function createTerm()
	vim.cmd('below split term://bash')
	-- TODO: Resize window slightly
	Term_buf = vim.api.nvim_get_current_buf()
	Term_win = vim.api.nvim_get_current_win()
	Term_chan = vim.api.nvim_get_option_value('channel', { buf = Term_buf })
	vim.api.nvim_set_option_value('buflisted', false, { buf = Term_buf })
end

function openTerm()
	vim.api.nvim_open_win(Term_buf, true, { split = 'below', win = 0, })
	Term_win = vim.api.nvim_get_current_win()
end

vim.api.nvim_create_user_command('Term', function()
	-- Checks whether terminal exists, or is valid else hide or open terminal
	if Term_buf == nil then
		createTerm()
	elseif vim.api.nvim_buf_is_valid(Term_buf) == false then
		-- Alternatively use nvim_buf_is_loaded() above
		createTerm()
	else
		if vim.api.nvim_win_is_valid(Term_win) then
			vim.api.nvim_win_hide(Term_win)
		else
			openTerm()
		end
	end
end, {})

-- TODO: Move to config.keybindings
vim.keymap.set({ 't', 'n' }, '<c-j>', '<cmd>:Term<cr>')
