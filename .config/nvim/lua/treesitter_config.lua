require('nvim-treesitter.configs').setup {
	ensure_installed = {
		"c",
		"cpp",
		"css",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"php",
		"python",
		"rust",
		"toml",
		"typescript",
		"vim",
	},
	highlight = { enable = true },
}
