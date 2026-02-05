-- Desc:
-- TODO: Split friendly-snippets in seperate file?

vim.pack.add({
	"https://github.com/L3MON4D3/LuaSnip",           -- Snippet engine
	"https://github.com/rafamadriz/friendly-snippets" -- Actual snippets
})

-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

local luasnip = require("luasnip")

-- Expand LuaSnip snippets with <space>
vim.keymap.set('i', '<space>', function()
	if luasnip.expandable() == true then
		vim.schedule(function() luasnip.expand() end)
	else
		return '<space>'
	end
end, { expr = true, silent = true })
