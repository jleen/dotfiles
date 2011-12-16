let s:little_font = &guifont
let s:little_lines = &lines

if !exists('big_font')
    let big_font = "Lucida_Console:h11"
endif

if !exists('big_lines')
    let big_lines = 35
endif

function! Littlize()
    let &lines = s:little_lines
    let &guifont = s:little_font
endfunction

function! Biggify()
    let &lines = g:big_lines
    let &guifont = g:big_font
endfunction

command! Little call Littlize()
command! Big call Biggify()
