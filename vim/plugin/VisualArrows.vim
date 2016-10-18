function! VisualArrowsOn()
    nnoremap <buffer> j gj
    nnoremap <buffer> k gk
    nnoremap <buffer> <down> gj
    nnoremap <buffer> <up> gk
    inoremap <buffer> <down> <C-o>gj
    inoremap <buffer> <up> <C-o>gk
endfunction

function! VisualArrowsOff()
    nunmap <buffer> j
    nunmap <buffer> k
    nunmap <buffer> <down>
    nunmap <buffer> <up>
    iunmap <buffer> <down>
    iunmap <buffer> <up>
endfunction
