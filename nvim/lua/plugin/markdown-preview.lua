-- Desc:

-- Run ':call mkdp#util#install()' after installation to complete setup
vim.pack.add({ "https://github.com/iamcco/markdown-preview.nvim" })

-- Reuse previously opened preview window
vim.g.mkdp_auto_close = 0
vim.g.mkdp_combine_preview = 1
