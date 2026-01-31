-- Desc: configuration for the Mason plugin (manages LSPs)

vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim" -- Bridge Mason and lspconfig
})

-- Required setup
require("mason").setup()

-- Pre-install set of LSPs
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"clangd",
		"marksman",
		-- "pyright"
	}
})
