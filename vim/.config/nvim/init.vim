set nocompatible
filetype off

let g:mapleader="\<Space>"
let g:maplocalleader="\<Space>"

call plug#begin()

"Navigation Plugins
Plug 'dbakker/vim-projectroot'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'
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
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --go-completer --rust-completer' }
Plug 'rdnetto/ycm-generator', { 'branch': 'stable' }
"Plug 'SirVer/ultisnips'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'

"Language specific
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'mxw/vim-jsx'
Plug 'tikhomirov/vim-glsl'
Plug 'vhdirk/vim-cmake'
Plug 'ds26gte/scmindent'

if isdirectory("~/dev/mitscript-syntax")
  Plug '~/dev/mitscript-syntax'
endif

"Note taking
Plug 'vimwiki/vimwiki'
Plug 'lukaszkorecki/workflowish'

call plug#end()

set rtp^=/usr/share/vim/vimfiles

syntax on
filetype plugin indent on

set backspace=indent,eol,start
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set number
set ruler
set showcmd
set errorformat^=%-GIn\ file\ included\ %.%#
set foldmethod=syntax
set conceallevel=2
set list lcs=tab:»\ ,trail:␣,extends:▶,precedes:◀

set undofile

set cindent cinoptions=N-s,g0

set splitright splitbelow

set ignorecase smartcase
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>

" Map <CR> to :nohl, except in quickfix windows
nnoremap <silent> <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ":nohl\<CR>"

" Necessary for terminal buffers not to die
"set hidden
autocmd TermOpen * set bufhidden=hide

set title

set nojoinspaces

set mouse=a

set autoread
autocmd BufEnter,FocusGained * checktime

" Update gutters 200 ms
set updatetime=200

cmap w!! w !sudo tee > /dev/null %

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

let g:ycm_global_ycm_extra_conf = '~/.config/nvim/ycm_global_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion = 1

let delimitMate_expand_cr = 1
autocmd FileType tex let b:delimitMate_autoclose = 0

command Bc bp|bd #
let g:bufferline_rotate=1
let g:bufferline_echo = 0

noremap <silent> <Leader>w :call ToggleWrap()<CR>
function WrapOn()
  setlocal wrap linebreak
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

if $TERM =~ 'rxvt' || $TERM =~'termite'
  let g:solarized_visibility='low'
  set background=dark
  colorscheme solarized
endif

set spellfile=~/.vim/spell/en.utf-8.add

set laststatus=2

let g:airline_powerline_fonts = 1

let g:NERDAltDelims_c = 1

let g:tex_flavor='latex'
if has('nvim')
  let g:vimtex_compiler_progname='nvr'
endif
if has('nvim') && !has('nvim-0.2')
  let g:vimtex_quickfix_latexlog = {'fix_paths':0}
endif
if executable('zathura')
  let g:vimtex_view_method='zathura'
endif
let g:vimtex_quickfix_open_on_warning=0

" lisp/scheme
autocmd filetype lisp,scheme setlocal equalprg=$HOME/.config/nvim/plugged/scmindent/scmindent.rkt

set printoptions+=paper:letter

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#wordcount#filetypes = ['help', 'markdown', 'rst', 'org', 'text', 'asciidoc', 'tex', 'mail']
let g:airline#extensions#wordcount#filetypes += ['pandoc']
let g:pandoc#formatting#mode = 'h'
let g:pandoc#formatting#textwidth = 80

let hostfile= $HOME . '/vimrc-' . hostname()
if filereadable(hostfile)
  exe 'source ' . hostfile
endif

autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTreeToggle | endif

if has('nvim')
  " For neovim 0.1.7
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
  " For neovim 0.2
  "set guicursor=blah
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
  tnoremap <S-Esc> <Esc>
  tnoremap <Esc> <C-\><C-n>
  autocmd TermOpen * startinsert
  au FileType fzf tnoremap <buffer> <Esc> <Esc>
endif
" Project root
let g:rootmarkers = ['.projectroot','Makefile','.git','.hg','.svn','.bzr','_darcs','build.xml']

" FZF configs
let g:fzf_command_prefix = 'Fzf'
let g:fzf_buffers_jump = 1
command! FzfProjectFiles execute 'FzfFiles' projectroot#guess()
nnoremap <silent> <Leader><Space> :FzfProjectFiles<CR>
nnoremap <silent> <Leader>a :FzfBuffers<CR>
nnoremap <silent> <Leader>A :FzfWindows<CR>

nnoremap <silent> <Leader>yy :YcmCompleter GoTo<CR>
nnoremap <Leader>y<Space> :YcmCompleter<Space>

let g:gutentags_project_root_finder = 'projectroot#guess'
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0
let g:gutentags_modules = ['ctags', 'cscope']
let g:gutentags_cache_dir = $HOME . '/.cache/gutentags'
let g:gutentags_ctags_tagfile = '.vimtags'
set tags=./.vimtags;,.vimtags,./tags;,tags

let g:cmake_export_compile_commands = 1

set cscopetag

let g:ycm_enable_diagnostic_signs=0
" Thanks to http://superuser.com/questions/558876/how-can-i-make-the-sign-column-show-up-all-the-time-even-if-no-signs-have-been-a
"autocmd BufEnter * sign define dummy
"autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

com -range=% -nargs=1 P exe "<line1>,<line2>!".<q-args> | y | sil u | echom @"
com -range=% Hash <line1>,<line2>P cpp -P -fpreprocessed | tr -d '[:space:]' | md5sum
