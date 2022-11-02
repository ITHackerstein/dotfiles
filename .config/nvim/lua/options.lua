require('custom_functions')
vim.opt.guifont = "JetBrainsMonoNL Nerd Font Mono, Noto Color Emoji, Noto Emoji:h10"
vim.opt.encoding = 'utf-8'
vim.opt.updatetime = 100
vim.cmd[[set termguicolors]]

vim.g.gruvbox_italic = 1
vim.g.grubox_transparent_bg = 1

vim.g.tokyonight_style = 'night'
vim.g.tokyonight_style_comments = 1

vim.g.neovide_transparency = 0.95
vim.g.neovide_cursor_vfx_mode = "sonicboom"

vim.g.python3_host_prog = "/usr/bin/python"

vim.g.fzf_colors = {
	fg = { 'fg', 'Normal' },
	bg = { 'bg', 'Normal' },
	hl = {'fg', 'Comment'},
	["fg+"] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'},
	["bg+"] = {'bg', 'CursorLine', 'CursorColumn'},
	["hl+"] = {'fg', 'Statement'},
	info = {'fg', 'PreProc'},
	border = {'fg', 'Ignore'},
	prompt = {'fg', 'Conditional'},
	pointer = {'fg', 'Exception'},
	marker = {'fg', 'Keyword'},
	spinner = {'fg', 'Label'},
	header = {'fg', 'Comment'}
}

vim.g["clang_format#command"] = "clang-format"
vim.g["clang_format.detect_style_file"] = 1

vim.g.autoformat_autoindent = 0
vim.g.autoformat_retab = 0
vim.g.autoformat_remove_trailing_spaces = 0

vim.cmd[[colorscheme tokyonight]]

vim.opt.showtabline = 2

vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.backspace = '2'
vim.cmd[[filetype indent plugin off]]
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = false

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.fileformat = 'unix'

vim.opt.list = true
vim.opt.listchars = "tab:-→,space:·"

vim.opt.autoread = true

vim.cmd([[
augroup myAuto
	autocmd!
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c
	autocmd BufRead,BufNewFile *.hpp,*.cpp,*.cc set filetype=cpp
	autocmd BufRead,BufNewFile *.asm, set filetype=nasm
	autocmd Syntax * normal zR
	autocmd BufWritePre * :lua custom_functions.strip_trailing_whitespaces()
	autocmd FileType gitcommit,markdown setlocal formatoptions+=t
	autocmd FileType c,cpp ClangFormatAutoEnable
	autocmd BufWrite *.rs :Autoformat
augroup END
]])

vim.opt.mouse = ""

vim.opt.inccommand = "nosplit"

vim.opt.completeopt = "menu,menuone,noselect"
