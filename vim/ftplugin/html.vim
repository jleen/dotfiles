function! s:IsInTag()
    let syntype=synIDattr(synID(line("."), col(".") - 1, 1), "name")
    return (syntype == "htmlTag") ||
         \ (syntype == "htmlTagName") ||
         \ (syntype == "htmlArg") ||
         \ (syntype == "htmlString")
endfunction

function! s:ThisChar()
    if col(".") == 1
        return 0
    else
        return strpart(getline("."), col(".") - 2, 1)
    endif
endfunction

function! s:IsAtWordStart()
    if col(".") == 1
        return 1
    else
        let char=strpart(getline("."), col(".") - 2, 1)
        return (char == " ") ||
             \ (char == "	") ||
             \ (char == "-") ||
             \ (char == ";")
    endif
endfunction

function! s:PrettyQuote(leftquote, rightquote, straightquote)
    if s:ThisChar() == ">"
        return a:leftquote
    elseif s:IsInTag()
        return a:straightquote
    elseif s:IsAtWordStart()
        return a:leftquote
    else
        return a:rightquote
    endif
endfunction

function! s:ResumeInsert()
    if col("$") - 1 == col(".")
        startinsert!
    else
        normal! l
        startinsert
    endif
endfunction

function! s:LookingAt(what)
    if strlen(a:what) > col(".") - 1
        return 0
    else
        return strpart(getline("."), (col(".") - 1) - strlen(a:what),
                    \ strlen(a:what)) == a:what
    endif
endfunction

function! s:InstantAbbrev(key, replacement)
    if s:LookingAt(strpart(a:key, 0, strlen(a:key) - 1))
        return substitute(strpart(a:key, 0, strlen(a:key) - 1),
                    \ ".", "\<BS>", "g") . a:replacement
    else
        return strpart(a:key, 0, 1)
    endif
endfunction

"inoremap <buffer> ' <C-R>=<SID>PrettyQuote("&lsquo;", "&rsquo;", "'")<CR>
"inoremap <buffer> " <C-R>=<SID>PrettyQuote("&ldquo;", "&rdquo;", '"')<CR>
"inoremap <buffer> . <C-R>=<SID>InstantAbbrev("...", "&hellip;")<CR>
"inoremap <buffer> - <C-R>=<SID>InstantAbbrev("--", "&mdash;")<CR>

nnoremap <buffer> <C-Q> ?^\(<p>\\|\\\)<CR>/\(\(\%#<p>\n\)\@<=<span \)\\|\(\%#<p>\n\(<span =\)\@!\)<CR><CR><CR>gq/\(^<\/p>\\|^\\\\|\%$\)<CR>

set linebreak

call VisualArrowsOn()
