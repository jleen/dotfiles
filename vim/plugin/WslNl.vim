function! WslNewline()
    if expand('%:p') =~ '\\wsl$\'
        set fileformat=unix
    endif
endfunction

autocmd BufNewFile * call WslNewline()
