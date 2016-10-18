" Emacs-style C indentation.

" Use with cinoptions+=(0 to get paren-aligned behavior *except*
" when the previous line ends with an open-paren.

function! GetEmacsCIndent()
    let prevline=getline(v:lnum - 1)
    if (prevline =~ "($")
        return &shiftwidth + indent(v:lnum - 1)
    else
        return cindent(v:lnum)
    endif
endfunction

