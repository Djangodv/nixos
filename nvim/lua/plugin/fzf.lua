-- Desc:

vim.pack.add({ "https://github.com/junegunn/fzf.vim" })

-- vim.g.fzf_action = {
--     ["ctrl-t"] = "tab split",
--     ["ctrl-x"] = "split",
--     ["ctrl-v"] = "vsplit",
-- }

vim.g.fzf_layout = {
	["window"] = { ["width"] = 1, ["height"] = 0.6 }
}

-- Change default statusline colors when opening fzf
local function fzf_statusline()
	vim.opt_local.statusline = "%#fzf1# > %#fzf2#fz%#fzf3#f"
end

-- Create an autocommand to use above function
vim.api.nvim_create_autocmd("User", {
	pattern = "FzfStatusLine",
	callback = fzf_statusline,
})

-- Make preview window hidden by default
vim.g.fzf_vim = {
	preview_window = { 'hidden,right,50%', 'ctrl-/' }
}

-- Needed to overwrite <esc> :Term specific keybind
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'fzf',
	callback = function()
		vim.keymap.set('t', '<esc>', '<c-c>', { buffer = true })
		vim.keymap.set('t', '<c-j>', '<down>', { buffer = true })
	end
})
