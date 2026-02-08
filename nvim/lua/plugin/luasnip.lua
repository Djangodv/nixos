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

-- Function used to undo a snippet
-- Source: https://github.com/L3MON4D3/LuaSnip/issues/797#issuecomment-1970013181
local untrigger = function()
	-- Get the snippet
	local snip = require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()].parent.snippet
	-- Get its trigger
	local trig = snip.trigger
	-- Replace that region with the trigger
	local node_from, node_to = snip.mark:pos_begin_end_raw()
	vim.api.nvim_buf_set_text(
		0,
		node_from[1],
		node_from[2],
		node_to[1],
		node_to[2],
		{ trig }
	)
	-- Reset the cursor-position to ahead the trigger
	vim.fn.setpos(".", { 0, node_from[1] + 1, node_from[2] + 1 + string.len(trig) })
	-- Add a space to the end
	vim.fn.feedkeys(' ', 'n')
end

-- TODO: Change to <c-space> instead of <c-x>?
vim.keymap.set({ "i", "s" }, "<c-x>", function()
	if require("luasnip").in_snippet() then
		untrigger()
		require("luasnip").unlink_current()
	end
end, {
	desc = "Undo a snippet",
})
