" Now it's a whole tree!
let s:current_file=expand("<sfile>:h")
exec "set runtimepath=" . escape(s:current_file, ' ') . ","
                      \ . escape(&runtimepath, ' ') . ","
                      \ . escape(s:current_file, ' ') . "/after"

" Swapfile hygiene.
if has("unix")
    let s:swapdir = "/var/tmp/jleen/vim"
    if exists ("*mkdir") && !isdirectory(s:swapdir)
        call mkdir("/var/tmp/jleen/vim", "p", 0700)
    endif
    if isdirectory(s:swapdir)
        let &directory = s:swapdir . "//"
    endif
endif

" Viminfo hygiene.
if has("win32") || has("win64")
    set viminfo+=n~/.viminfo
endif

" Netrw hygiene.
let g:netrw_home=$HOME

" HTML hygiene.
let html_no_rendering=1

" Make buffers behave
set autoread

" Make keystrokes behave
set timeoutlen=1000
set ttimeoutlen=50

" Make tab behave
set wildmode=longest:list

" Look harder
set tags=tags;

" Make mouse behave
behave xterm
set clipboard=unnamed
"TODO: 'autoselect' is incompatible with yankring. Why?
"set clipboard=unnamed,autoselect

" File format
set encoding=utf-8
set modelines=5

" GUI display options
if has("gui_running")
    set lines=50
    set columns=80
    set cursorline
    colorscheme solarized
endif

set guioptions+=a  " autoselect: xterm-style clipboard cut
set guioptions-=T  " no toolbar

hi normal guifg=gray90 guibg=black
hi Hungarian guifg=gray70
hi CursorLine guibg=gray20

" WTF?
"au WinEnter * set cursorline
"au WinLeave * set nocursorline
"au FocusGained * set cursorline
"au FocusLost * set nocursorline

if has("gui_win32")
    set winaltkeys=no
    set guifont=Lucida_Console:h9:cANSI
endif

if has ("gui_macvim")
    set transparency=0
    set guifont=Menlo_Regular:h13
endif

" Generic display options
set background=dark

" Wacky fun
syntax on
filetype plugin on
filetype indent on

" Editing behavior
set backspace=2
set autoindent
set scrolloff=3
set foldlevelstart=1
set showbreak=+ 
set display=lastline
if version >= 700
    set completeopt=
endif

" Tabs
set shiftwidth=4
set tabstop=4
set expandtab

" Terminal display options
set ruler
set showmode
set showmatch

" Emacs-style paragraph reflowing
map <esc>q gqap

" Coding conventions
set cinoptions+=>s	" text inside braces is one sw in
set cinoptions+=es	" indent 1 sw if { is not first char in prev line
set cinoptions+=n0	" in 1 sw if no { after if
set cinoptions+=f0	" open brace of func in column 0
set cinoptions+==0  " no indent underneath a case
set cinoptions+={0	" open brace 1 sw in
set cinoptions+=(0  " line up inside parens

" Error logs from msbuild.exe
let &errorformat = &errorformat . ',%DProject\\ "%f\\[A-Za-z]%#.csproj"\\ (default\\ targets):'

" C# errors
set errorformat +=%f(%l\\,%c):\ warning\ CS%n:%m
set errorformat +=%f(%l\\,%c):\ error\ CS%n:%m

" It's your turn!
if filereadable($HOME . "/.vimrc")
  source $HOME/.vimrc
endif
