let s:little_font = &guifont
let s:little_lines = &lines

function! Littlize()
    exec "set lines=" . s:little_lines
    exec "set guifont=" . s:little_font
endfunction

function! Biggify()
    set lines=35
    set guifont=Lucida_Console:h11
endfunction

command! Little call Littlize()
command! Big call Biggify()
