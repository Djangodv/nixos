-- Desc:

local function define_run_keybind(filetype, command)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetype,
		callback = function()
			vim.api.nvim_create_user_command('Run', function()
				if Term_buf == nil then
					createTerm()
					vim.api.nvim_chan_send(Term_chan, command .. '\n')
				elseif vim.api.nvim_buf_is_valid(Term_buf) == false then
					createTerm()
					vim.api.nvim_chan_send(Term_chan, command .. '\n')
				else
					if vim.api.nvim_win_is_valid(Term_win) then
						vim.api.nvim_chan_send(Term_chan, command .. '\n')
					else
						openTerm()
						vim.api.nvim_chan_send(Term_chan, command .. '\n')
						--Term_chan = vim.api.nvim_get_option_value('channel', { buf = Term_buf })
					end
				end
			end, {})
		end,
	})
end

define_run_keybind('lua', 'echo "Hello World!"')
