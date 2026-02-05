-- Desc:

vim.lsp.enable({ 'clangd', 'pyright', 'lua_ls' })

-- Set max. items for completion menu
vim.opt.pumheight = 8

-- Autocomplete works best with completeopt=noselect.
vim.cmd [[set completeopt+=menuone,noselect,popup]] -- Don't pre-select menu items, use popup to display extra information and use the menu also when there is only one match

-- Autocommand needed for autocompletion to work
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, args.buf, {
				autotrigger = true,
				-- Add nerdfont glyphs and display detailed information in completion menu
				convert = function(item)
					local kind_icons = { '󰉿', '󰊕', '󰊕', '󰒓', '󰜢', '󰆦', '󰖷', '󱡠', '󱡠', '󱡠', '󰅩', '󰪚',
						'󰦨', '󰦨', '󰦨', '󰻾', '󰏿', '󱄽', '󰏘', '󰈔', '󰬲', '󰉋', '󱐋', '󰪚', '󰬛' }
					return { abbr = kind_icons[item.kind] .. "  " .. item.label }
				end
			})
		end
	end
})

-- Trigger autocompletion on every keypress. May be slow!
vim.api.nvim_create_autocmd("InsertCharPre", {
	callback = function()
		if not vim.api.nvim_get_current_line():sub(1, vim.api.nvim_win_get_cursor(0)[2]):match("^%s*$") then
			vim.lsp.completion.get()
		end
	end,
})

-- Use <cr> to confirm a completion
vim.keymap.set({ 'i' }, '<cr>', function()
	if vim.fn.pumvisible() == 1 then
		return '<c-y>'
	else
		return '<cr>'
	end
end, { desc = '...', expr = true })

vim.keymap.set({ 'i', 's' }, '<s-tab>', '<c-p>')

local luasnip = require('luasnip')

-- Jump snippets with <tab>
-- Select mode 's' is a mode used often by snippet plugins, including vim.snippet
vim.keymap.set({ 'i', 's' }, '<tab>', function()
	if vim.fn.pumvisible() == 1 then
		-- Can't find the right function for selecting next completion, but <c-n> can still be remapped in normal mode
		return '<c-n>'
	elseif vim.snippet.active({ direction = 1 }) then
		return '<cmd>lua vim.snippet.jump(1)<cr>'
		-- Alternatively use or luasnip.in_snippet()
	elseif luasnip.jumpable(1) then
		vim.schedule(function() luasnip.jump(1) end)
	else
		return '<tab>'
	end
end, { expr = true, silent = true })
