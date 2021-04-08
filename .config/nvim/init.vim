" setting the encoding
set encoding=utf-8

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim',{'as': 'dracula'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'kaicataldo/material.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'rhysd/vim-clang-format'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'pangloss/vim-javascript'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'cespare/vim-toml'
Plug 'ciaranm/detectindent'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword' " Word autocomplete
Plug 'ncm2/ncm2-path' " Path autocomplete
Plug 'ncm2/ncm2-jedi' " Python autocomplete
Plug 'ncm2/ncm2-pyclang' " C/C++ autocomplete
call plug#end()

" update time
set updatetime=100

set termguicolors

syntax on
colorscheme gruvbox

" tabs
set showtabline=2

" airline stuff
set noshowmode
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1

" set python
let g:python3_host_prog='/home/davide/.pyenv/versions/nvim-env/bin/python'

" tab settings
set noexpandtab
set tabstop=2
set shiftwidth=2
set backspace=2
filetype indent plugin off
set nosmartindent
set noautoindent

" no backup files i hate them
set nobackup
set noswapfile
set noundofile

" line numbers
set relativenumber
set number
set cursorline

" split screen options
set splitright
set splitbelow

" mappings
map <F3> :noh<CR>
map tn :tabn<CR>
map tp :tabp<CR>
map <C-p> :FZF<CR>

" lines wrapping
set wrap
set nolinebreak
set textwidth=0

" line ending
set fileformat=unix

" remove trailing whitespaces
function! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun

" Templates

"" HTML skeleton
function! LoadHTMLSkeleton()
	if filereadable("html.skel")
		r html.skel
	else
		r ~/.vim/templates/html.skel
	endif
endfun

"" C Makefile template
function! LoadCMakefileSkeleton()
	r ~/.vim/templates/c-makefile.skel
endfun

command! LoadHTMLSkeleton call LoadHTMLSkeleton()
command! LoadCMakefileSkeleton call LoadCMakefileSkeleton()

" vim layouts
function! SaveCurrentLayout()
	mksession! vim_layout.vim
endfun

function! LoadLayout()
	if filereadable("vim_layout.vim")
		source vim_layout.vim
	endif
endfun

command! SaveCurrentLayout call SaveCurrentLayout()
command! LoadLayout call LoadLayout()

if argc() < 1
	call LoadLayout()
endif

" some keybindings to switch between source and header files easily

function! SwitchHeaderSource()
	let file_name = expand("%:r:r")
	let file_ext = expand("%:e")

	if file_ext ==# "hpp" || file_ext ==# "h"
		if filereadable(file_name . ".cpp")
			execute "edit" file_name . ".cpp"
		elseif filereadable(file_name . ".c")
			execute "edit" file_name . ".c"
		endif
	elseif file_ext ==# "cpp" || file_ext ==# "c"
		if filereadable(file_name . ".hpp")
			execute "edit" file_name . ".hpp"
		elseif filereadable(file_name . ".h")
			execute "edit" file_name . ".h"
		endif
	endif

	echo
endfun

command! SwitchHeaderSource call SwitchHeaderSource()
map <F4> :SwitchHeaderSource<CR>

" clang-format
let g:clang_format#detect_style_file = 1

" NCM2
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <c-c> <ESC>

let g:ncm2_jedi#python_version=3
let g:ncm2_pyclang#library_path="/usr/lib/llvm-10/lib/libclang.so.1"
let g:ncm2_pyclang#database_path=[ "compile_commands.json", "build/compile_commands.json", "Build/compile_commands.json" ]

" remove bell sound
set noeb vb t_vb=

" line ending
set ff=unix

" autocmds
augroup myAuto
	autocmd!
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c
	autocmd BufRead,BufNewFile *.hpp,*.cpp,*.cc set filetype=cpp
	autocmd BufRead,BufNewFile *.asm, set filetype=nasm
	autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

	" NCM2 autocomplete
	autocmd BufEnter * call ncm2#enable_for_buffer()
	autocmd FileType c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>
augroup END


" set cursor shapes
set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" disables mouse
set mouse=

" shows output of command incrementally
set inccommand=nosplit
