" Microsoft-style TODOs.
syn keyword csTodo contained REVIEW FUTURE

" @ strings don't contain backslash escapes, but can contain line-breaks.
" Escaped quotes are VB-style.
syn region csAtString start=+@"+ skip=+""+ end=+"+
hi def link csAtString String

" async/await keywords from C# 5.0
syn keyword csModifier async
syn keyword csRepeat await

" Automatic variables.
syn keyword csType var
