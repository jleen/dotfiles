" Now it's a whole tree!
exec "set runtimepath=~/config/vimfiles," . &runtimepath . ",~/config/vimfiles/after"

" Make buffers behave
set autoread

" Make keystrokes behave
set timeoutlen=1000
set ttimeoutlen=50

" File format
set encoding=utf-8
set modelines=0

" GUI display options
if has("gui_running")
    set guioptions+=a  " autoselect: xterm-style clipboard cut
    set guioptions-=T  " no toolbar
    set guifont=Lucida_Console:h9:cANSI
    set lines=50
    hi normal guifg=gray90 guibg=black
    hi Hungarian guifg=gray70
endif

" Generic display options
set background=dark

" Wacky fun
syntax on
filetype plugin on
filetype indent on

" Editing behavior
set nocompatible
set backspace=2
set autoindent
set scrolloff=3

" Tabs
set shiftwidth=4
set tabstop=4
set expandtab

" Terminal display options
set ruler
set showmode
set showmatch

" Macros
map <esc>q gqap
cnoremap <tab> <C-L>

" Coding conventions
set cinoptions+=>s	" text inside braces is one sw in
set cinoptions+=es	" indent 1 sw if { is not first char in prev line
set cinoptions+=n0	" in 1 sw if no { after if
set cinoptions+=f0	" open brace of func in column 0
set cinoptions+={0	" open brace 1 sw in
set cinoptions+=:-s	" case labels out a shiftwidth
set cinoptions+=(0  " line up inside parens
