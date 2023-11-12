" Store .netrwhist and .netrwbook in home directory.
let g:netrw_home=$HOME

" Suppress chatter during file transfers.
let g:netrw_silent=1

" Do not want hokey HTML WYSIWYG.
let html_no_rendering=1

" Auto-reload files that are externally but not internally changed.
" (This is the default for nvim but not vim.)
set autoread

" One-second timeout for key sequences, but 50 ms for escape codes.
" (This is the default for nvim but not vim.)
set timeoutlen=1000 ttimeoutlen=50

" Tab completes longest ambiguous substring; double-tab lists alternatives.
set wildmode=longest:list

" Ignore case if search string is all lowercase.
set ignorecase smartcase

" Right mouse button extends selection.
set mousemodel=extend

" System clipboard at the top of the register stack.
set clipboard=unnamed

" Mouse in terminal, all modes (including command line).
set mouse=a

" Turn on all filetype support.
" (This is the default for nvim but not vim.)
filetype plugin indent on

" Editing behavior
" (This is the default for nvim but not vim.)
set backspace=indent,eol,start autoindent display=lastline

" Always show some context lines when scrolling.
set scrolloff=3

" Start with one fold expanded.
set foldlevelstart=1

" Visually indicate continued lines.
set showbreak=+ 

" Less visual noise when tab completing.
set completeopt=

" Indent 4 columns and never insert tabs.
set shiftwidth=4
set tabstop=4
set expandtab

" Always show the ruler.
" (This is the default for nvim but not vim.)
set ruler

" Highlight match while searching (like Emacs i-search).
set showmatch

" Always try to set the window title.
" (I'm not quite sure why this is isn't the nvim default.)
set title
