" @ strings can't contain escapes.
syn region csAtString start=+@"+ end=+"+
hi def link csAtString String
