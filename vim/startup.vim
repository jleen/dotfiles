set timeoutlen=50
set encoding=utf-8
set guioptions-=T
set guifont=Lucida_Console:h9:cANSI
set timeoutlen=50
set nocompatible
set backspace=2
set showmode
set autoindent
set ignorecase
set showmatch
set ruler
set shiftwidth=4
set tabstop=4
set expandtab
cnoremap <tab> <C-D><C-L>
"colors koehler
hi normal guifg=gray90 guibg=black
set background=dark
syntax on
hi Hungarian guifg=gray70
set lines=50
set hidden

" Macros
map <esc>q gqap

" Coding conventions
set shiftwidth=4	" > and < operators move 4 spaces
set tabstop=4		" tabs are 4 spaces
set cinoptions+=>s	" text inside braces is one sw in
set cinoptions+=es	" indent 1 sw if { is not first char in prev line
set cinoptions+=n0	" in 1 sw if no { after if
set cinoptions+=f0	" open brace of func in column 0
set cinoptions+={0	" open brace 1 sw in
set cinoptions+=:-s	" case labels out a shiftwidth
set expandtab		" use spaces rather than tabs

" Mail and news
au! BufNewFile,BufReadPost .followup
au  BufNewFile,BufReadPost .followup so ~/.vim/mail.vim
au! BufNewFile,BufReadPost .article
au  BufNewFile,BufReadPost .article so ~/.vim/mail.vim
au! BufNewFile,BufReadPost /tmp/mutt*
au  BufNewFile,BufReadPost /tmp/mutt* so ~/.vim/mail.vim
