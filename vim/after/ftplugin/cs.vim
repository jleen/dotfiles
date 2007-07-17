" Properly recognize XML comments
set comments-=://
set comments+=:///,://

" Line length for comments
if &textwidth == 0
    setlocal textwidth=75
endif

map [[ ?^\( \{0,8}{\\|\%1l\)<CR>
map ]] /^\( \{0,8}{\\|.*\%$\)<CR>
map [] ?^\( \{0,8}}\\|\%1l\)<CR>
map ][ ?^\( \{0,8}}\\|.*\%$\)<CR>

"TODO: gd
