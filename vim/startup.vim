" Make buffers behave
set autoread
set hidden

" File format
set encoding=utf-8
set modelines=0

" GUI display options
set guioptions-=T
set guifont=Lucida_Console:h9:cANSI
set timeoutlen=50
set lines=50
hi normal guifg=gray90 guibg=black
hi Hungarian guifg=gray70
set background=dark
syntax on

" Editing behavior
set nocompatible
set backspace=2
set autoindent
set ignorecase

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

" Mail and news
au! BufNewFile,BufReadPost .followup
au  BufNewFile,BufReadPost .followup so ~/.vim/mail.vim
au! BufNewFile,BufReadPost .article
au  BufNewFile,BufReadPost .article so ~/.vim/mail.vim
au! BufNewFile,BufReadPost /tmp/mutt*
au  BufNewFile,BufReadPost /tmp/mutt* so ~/.vim/mail.vim
