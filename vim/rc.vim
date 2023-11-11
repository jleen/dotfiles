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

" Mouse in terminal
set mouse=a

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
set completeopt=

" Tabs
set shiftwidth=4
set tabstop=4
set expandtab

" Terminal display options
set ruler
set showmode
set showmatch
set title

if has('nvim')
    lua require('neoscroll').setup({ mappings = {'<C-d>', '<C-u>' }})
endif
