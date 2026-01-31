-- Desc: 

vim.pack.add({"https://github.com/rebelot/kanagawa.nvim"})

require("kanagawa").setup({
    colors = {
        palette = {
            oldWhite = "#c5c9c5", -- your new color here
	    dragonBlack4 = "#181818",
        },
    },
})
