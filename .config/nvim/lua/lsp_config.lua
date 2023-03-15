local lsp = require("lsp-zero")

lsp.preset({
	name = "recommended",
	set_lsp_keymaps = true,
	manage_nvim_cmp = true,
	suggest_lsp_servers = false,
})

lsp.setup()

vim.diagnostic.config({ virtual_text = true })
