custom_functions = require('custom_functions')

function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<F3>", ":noh<CR>", { silent = true })
map("n", "<F4>", ":lua custom_functions.switch_header_source()<CR>", { silent = true })
map("n", "tn", ":tabn<CR>", { silent = true })
map("n", "tp", ":tabp<CR>", { silent = true })
map("n", "<C-p>", ":lua require('telescope.builtin').find_files()<CR>", { silent = true })
map("n", "<C-f><C-f>", ":lua require('telescope.builtin').live_grep()<CR>", { silent = true })
