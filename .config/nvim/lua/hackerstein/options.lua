-- Sets Neovide font
vim.opt.guifont = "CodeNewRoman Nerd Font:h10"

-- Sets Neovide transparency
vim.g.neovide_transparency = 0.95

-- Leader key
vim.g.mapleader = " "

-- Fancy line numbering
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Tab settings
vim.cmd[[filetype plugin indent off]]
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

-- Split settings
vim.opt.splitright = true
vim.opt.splitbelow = true

-- List chars
vim.opt.list = true
vim.opt.listchars = { tab = "--→", space = "·" }

-- Remove trailing whitespaces on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		local cursor_pos = vim.fn.getpos(".")
		vim.cmd[[%s/\s\+$//e]]
		vim.fn.setpos(".", cursor_pos)
	end
})

-- Autoread
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	pattern = { "*" },
	command = "if mode() != 'c' | checktime | endif"
})

-- Better clipboard
vim.cmd[[set clipboard+=unnamedplus]]

-- Mappings
-- vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "tex" }, command = "imap <silent> <C-b> \\textbf{}<Left>" })
-- vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "tex" }, command = "imap <silent> <C-i> \\textit{}<Left>" })
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "tex" }, command = "vmap <silent> <C-b> Si\\textbf{<CR>}<CR>" })
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "tex" }, command = "vmap <silent> <C-i> Si\\textit{<CR>}<CR>" })
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "python,rust" }, command = "setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab" })
vim.api.nvim_create_autocmd({ "FileType" }, { pattern = { "gitcommit" }, command = "setlocal tw=72" })
