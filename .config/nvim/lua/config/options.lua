vim.cmd[[colorscheme gruvbox]]
vim.opt.signcolumn = "yes:2"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.winborder = "rounded"
vim.cmd[[set clipboard+=unnamedplus]]
vim.opt.undofile = true
vim.opt.swapfile = false
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN]  = "",
			[vim.diagnostic.severity.INFO]  = "",
			[vim.diagnostic.severity.HINT]  = "󰌵",
		}
	}
})

-- Automatically reload files
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    pattern = { "*" },
    command = "if mode() != 'c' | checktime | endif"
})

-- Automatically remove trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		local cursor_pos = vim.fn.getpos(".")
		vim.cmd[[%s/\s\+$//e]]
		vim.fn.setpos(".", cursor_pos)
	end
})
