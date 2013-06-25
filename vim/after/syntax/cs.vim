" @ strings don't contain backslash escapes, but can contain line-breaks.
" Escaped quotes are VB-style.
syn region csAtString start=+@"+ skip=+""+ end=+"+
hi def link csAtString String
syn keyword csTodo contained REVIEW FUTURE
syn keyword csModifier async
syn keyword csRepeat await
