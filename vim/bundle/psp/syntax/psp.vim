" Vim syntax file
" Language:	Active State's PerlScript (ASP)
" Maintainer:	Aaron Hope <edh@brioforge.com>
" URL:		http://nim.dhs.org/~edh/aspperl.vim
" Last Change:	2001 May 09

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'pyscript'
endif

if version < 600
  so <sfile>:p:h/html.vim
  syn include @Psp <sfile>:p:h/python.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
  syn include @Psp syntax/python.vim
endif

syn cluster htmlPreproc add=PspInsideHtmlTags

syn region  PspInsideHtmlTags keepend matchgroup=Delimiter start=+<%=\=+ skip=+".*%>.*"+ end=+%>+ contains=@Psp

let b:current_syntax = "psp"
