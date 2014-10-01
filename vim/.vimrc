set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle

execute vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdcommenter'
Plugin 'taglist.vim'
Plugin 'tomtom/tlib_vim'
Plugin 'tomtom/tskeleton_vim'
Plugin 'git://repo.or.cz/vcscommand'
Plugin 'xuhdev/SingleCompile'
Plugin 'vimwiki'
Plugin 'Rip-Rip/clang_complete'
Plugin 'altercation/vim-colors-solarized'
Plugin 'git://git.code.sf.net/p/vim-latex/vim-latex'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'lukaszkorecki/workflowish'

syntax on
filetype plugin indent on

set backspace=indent,eol,start
set softtabstop=4
set shiftwidth=4
set tabstop=4
set noexpandtab
set nu
set ruler
set errorformat^=%-GIn\ file\ included\ %.%#
set foldmethod=syntax

set mouse=a

cmap w!! w !sudo tee > /dev/null %

let g:SingleCompile_alwayscompile = 0
let g:SingleCompile_showquickfixiferror = 1
let delimitMate_expand_cr = 1

nmap \rc :SCCompile<cr>
nmap \rr :SCCompileRun<cr>

call SingleCompile#ChooseCompiler('tex', 'pdflatex')
call SingleCompile#ChooseCompiler('cpp', 'g++')

let g:clang_complete_loaded=1
let g:clang_user_options='-std=c++11'
let g:clang_auto_select=1
let g:clang_complete_auto=0

noremap <silent> <Leader>w :call ToggleWrap()<CR>
function WrapOn()
	setlocal wrap linebreak nolist
	set virtualedit=
	setlocal display+=lastline
	noremap  <buffer> <silent> <Up>   g<Up>
	noremap  <buffer> <silent> <Down> g<Down>
	noremap  <buffer> <silent> <Home> g<Home>
	noremap  <buffer> <silent> <End>  g<End>
	inoremap <buffer> <silent> <Up>   <C-o>gk
	inoremap <buffer> <silent> <Down> <C-o>gj
	inoremap <buffer> <silent> <Home> <C-o>g<Home>
	inoremap <buffer> <silent> <End>  <C-o>g<End>
endfunction
function WrapOff()
	setlocal nowrap
	set virtualedit=all
	silent! nunmap <buffer> <Up>
	silent! nunmap <buffer> <Down>
	silent! nunmap <buffer> <Home>
	silent! nunmap <buffer> <End>
	silent! iunmap <buffer> <Up>
	silent! iunmap <buffer> <Down>
	silent! iunmap <buffer> <Home>
	silent! iunmap <buffer> <End>
endfunction
function ToggleWrap()
	if &wrap
		echo "Wrap OFF"
		call WrapOff()
	else
		echo "Wrap ON"
		call WrapOn()
	endif
endfunction
call WrapOn()

set t_Co=16
colorscheme solarized

set spellfile=~/.vim/spell/en.utf-8.add

set laststatus=2

let g:airline_powerline_fonts = 1

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='latexmk -pdf -synctex=1'

let hostfile= $HOME . '/vimrc-' . hostname()
if filereadable(hostfile)
	exe 'source ' . hostfile
endif
