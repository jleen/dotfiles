" Now it's a whole tree!
exec "set runtimepath=$CONFIGDIR/vim," . escape(&runtimepath, ' ') . ",$CONFIGDIR/vim/after"

" Make buffers behave
set autoread

" Make keystrokes behave
set timeoutlen=1000
set ttimeoutlen=50

" Make tab behave
set wildmode=longest:list

" Make mouse behave
behave xterm
set clipboard=unnamed,autoselect

" File format
set encoding=utf-8
set modelines=5

" GUI display options
if has("gui_running")
    set guioptions+=a  " autoselect: xterm-style clipboard cut
    set guioptions-=T  " no toolbar
    set guifont=Lucida_Console:h9:cANSI
    set lines=50
    hi normal guifg=gray90 guibg=black
    hi Hungarian guifg=gray70
    if has("gui_win32")
        set winaltkeys=no
    endif
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
set foldlevelstart=1
set showbreak=+
set display=lastline

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

" Coding conventions
set cinoptions+=>s	" text inside braces is one sw in
set cinoptions+=es	" indent 1 sw if { is not first char in prev line
set cinoptions+=n0	" in 1 sw if no { after if
set cinoptions+=f0	" open brace of func in column 0
set cinoptions+={0	" open brace 1 sw in
set cinoptions+=:0	" case labels flush with switch statement
set cinoptions+=(0  " line up inside parens

"Me
let trillianUserNames = '\(Sonbal Boantjies\|jleen\)'
