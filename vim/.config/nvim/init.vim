set nocompatible
filetype off

call plug#begin()

"Navigation Plugins
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'

"UI Plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'altercation/vim-colors-solarized'

"Editor plugins
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-sleuth'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'rdnetto/ycm-generator', { 'branch': 'stable' }
Plug 'SirVer/ultisnips'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"Language specific
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
Plug 'lervag/vimtex', { 'for': 'tex' }

if !isdirectory("~/dev/mitscript-syntax")
  Plug '~/dev/mitscript-syntax'
endif

"Note taking
Plug 'vimwiki'
Plug 'lukaszkorecki/workflowish'

call plug#end()

syntax on
filetype plugin indent on

set backspace=indent,eol,start
set softtabstop=4
set shiftwidth=4
set tabstop=4
set noexpandtab
set number
set ruler
set showcmd
set errorformat^=%-GIn\ file\ included\ %.%#
set foldmethod=syntax
set conceallevel=2

set cindent cinoptions=N-s,g0

set splitright splitbelow

" Necessary for terminal buffers not to die
set hidden

set title

set nojoinspaces

set mouse=a

set autoread
autocmd BufEnter,FocusGained * checktime

cmap w!! w !sudo tee > /dev/null %

let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion = 1

let delimitMate_expand_cr = 1
autocmd FileType tex let b:delimitMate_autoclose = 0

command Bc bp|bd #
let g:bufferline_rotate=1

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

if $TERM =~ 'rxvt'
  set background=dark
  colorscheme solarized
endif

set spellfile=~/.vim/spell/en.utf-8.add

set laststatus=2

let g:airline_powerline_fonts = 1

let g:NERDAltDelims_c = 1

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
if has('nvim')
  let g:vimtex_latexmk_progname='nvr'
endif
let g:vimtex_quickfix_open_on_warning=0

set printoptions+=paper:letter

let hostfile= $HOME . '/vimrc-' . hostname()
if filereadable(hostfile)
  exe 'source ' . hostfile
endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTreeToggle | endif

if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
else
  if $TERM =~ '^xterm\|rxvt'
    " Insert mode
    let &t_SI = "\<Esc>[5 q"
    " Replace mode
    if has("patch-7.4-687")
      let &t_SR = "\<Esc>[3 q"
    endif
    " Normal mode
    let &t_EI = "\<Esc>[2 q"

    " 1 or 0 -> blinking block
    " 2 -> solid block
    " 3 -> blinking underscore
    " 4 -> solid underscore
    " Recent versions of xterm (282 or above) also support
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
  endif
endif

if has('nvim')
  tnoremap <Leader><Esc> <Esc>
  tnoremap <Esc> <C-\><C-n>
endif

let g:ycm_enable_diagnostic_signs=0
" Thanks to http://superuser.com/questions/558876/how-can-i-make-the-sign-column-show-up-all-the-time-even-if-no-signs-have-been-a
"autocmd BufEnter * sign define dummy
"autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
