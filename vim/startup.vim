map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Now it's a whole tree!
let s:current_file=expand("<sfile>:h")
exec "set runtimepath=" . escape(s:current_file, ' ') . ","
                      \ . escape(&runtimepath, ' ') . ","
                      \ . escape(s:current_file, ' ') . "/after"
exec "set packpath=" . escape(s:current_file, ' ') . ","
                   \ . escape(&packpath, ' ') . ","
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
    if has("nvim")
        set viminfo+=n~/.nviminfo
    else
        set viminfo+=n~/.viminfo
    endif
endif

" Netrw hygiene.
let g:netrw_home=$HOME
let g:netrw_silent=1

let g:python_highlight_all=1

" HTML hygiene.
let html_no_rendering=1

" Make buffers behave
set autoread

" Make keystrokes behave
set timeoutlen=1000
set ttimeoutlen=50

" Make tab behave
set wildmode=longest:list

" Make search behave
set ignorecase
set smartcase

" Look harder
set tags=tags;

" Make mouse behave
behave xterm
set clipboard=unnamed
"TODO: 'autoselect' is incompatible with yankring. Why?
"set clipboard=unnamed,autoselect

" Mouse in terminal
set mouse=a

" File format
set encoding=utf-8
set modelines=5

" GUI display options
if has("gui_running")
    if !has ("gui_macvim")
        set lines=50
    endif
    set columns=80
    set cursorline
endif

if has("gui_running") || &t_Co >= 256
    set background=dark
    syntax enable
    colorscheme paisaje
    set laststatus=2
    let g:lightline = { 'colorscheme': 'landscape' }
endif

set guioptions+=a  " autoselect: xterm-style clipboard cut
set guioptions-=T  " no toolbar

hi normal guifg=gray90 guibg=black
hi Hungarian guifg=gray70
hi CursorLine guibg=gray20

" Cursor line travels with focus.
au WinEnter * set cursorline
au WinLeave * set nocursorline
au FocusGained * set cursorline
au FocusLost * set nocursorline

if has("gui_win32")
    set winaltkeys=no
    set guifont=Cascadia_Code_PL:h10:cANSI,Lucida_Console:h10:cANSI
    let g:Tex_UsePython=0
endif

if has ("gui_macvim")
    set transparency=0
    function! s:set_font()
        if len(getfontname('Monoid'))
            set guifont=Monoid:h14
            let g:big_font="Monoid:h18"
        else
            set guifont=Menlo_Regular:h13
        endif
    endfunction
    autocmd GUIEnter * call s:set_font()

    let g:Tex_ViewRule_pdf='open -a Preview'
    let g:Tex_CompileRule_pdf='latexmk -xelatex -interaction=nonstopmode $*'
    let g:Tex_UseMakefile=0
    let g:Tex_DefaultTargetFormat='pdf'
endif

if has("gui_gtk")
    function! s:set_font()
        if exists("g:sv_font") && len(g:sv_font)
            let &guifont=g:sv_font
        elseif len(getfontname('Monoid'))
            set guifont=Monoid\ 9
            let g:big_font="Monoid 14"
        else
            set guifont=Monospace\ 12
            let g:big_font="Monospace 16"
        endif
    endfunction
    autocmd GUIEnter * call s:set_font()
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
if has('nvim')
    lua require('neoscroll').setup({ mappings = {'<C-d>', '<C-u>' }})
endif

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
if filereadable(escape(s:current_file, ' ') . "/../local/vimrc")
  exec "source " . escape(s:current_file, ' ') . "/../local/vimrc"
endif

" Hack the WSL
let s:wslpath=matchlist(getcwd(), '\\\\wsl$\\\([a-zA-Z]*\)\\')
if len(s:wslpath) > 1
    let $HOME='\\wsl$\' . s:wslpath[1] . '\home\' . $USERNAME
endif

set title
