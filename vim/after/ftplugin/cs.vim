" Properly recognize XML comments
set comments-=://
set comments+=:///,://

" Line length for comments
setlocal textwidth=75

map [[ ?^\( \{0,8}{\\|\%1l\)<CR>
map ]] /^\( \{0,8}{\\|.*\%$\)<CR>
map [] ?^\( \{0,8}}\\|\%1l\)<CR>
map ][ ?^\( \{0,8}}\\|.*\%$\)<CR>

"TODO: gd
