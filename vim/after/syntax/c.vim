syntax keyword cTodo contained REVIEW FUTURE
syntax region cCppOutFalse start="^\s*\(%:\|#\)\s*if\s\+false\+\>" end=".\@=\|$" contains=cCppOut2
