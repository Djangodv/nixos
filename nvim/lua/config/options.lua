-- Disable swapfiles
vim.opt.swapfile = false

-- Enable mouse
vim.opt.mouse = 'a'

-- Show linenumbers
vim.opt.number = true

-- Set colorscheme
vim.cmd.colorscheme("kanagawa-dragon")

-- Fix indentation (equal to LSP auto-format)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Preview search and replace in a split window
vim.opt.inccommand = 'split'

-- Always keep a minimal amount of lines above and below cursor
vim.opt.scrolloff = 10

-- Ignore capital letters when searching
vim.opt.ignorecase = true
-- Automatically switch to case-sensitive search when typing an upppercase letter
vim.opt.smartcase = true

-- Show cursorline
-- vim.opt.cursorline = true

-- Disable line wrappign
vim.opt.wrap = false
-- Avoid wrapping lines in the middle of a word
vim.opt.linebreak = true

-- Disable auto-inserting comments
vim.api.nvim_create_autocmd('BufEnter', {
	command = 'set fo-=o | set fo-=r'
})

-- Persistent undo (file at: $XDG_STATE_HOME/nvim/undo/)
vim.opt.undofile = true
