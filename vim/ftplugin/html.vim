function! s:IsInTag()
    let syntype=synIDattr(synID(line("."), col("."), 1), "name")
    return (syntype == "htmlTag") ||
         \ (syntype == "htmlTagName") ||
         \ (syntype == "htmlArg") ||
         \ (syntype == "htmlString")
endfunction

function! s:ThisChar()
    if col(".") == 1
        return 0
    else
        return strpart(getline("."), col(".") - 1, 1)
    endif
endfunction

function! s:IsAtWordStart()
    if col(".") == 1
        return 1
    else
        let char=strpart(getline("."), col(".") - 1, 1)
        return (char == " ") ||
             \ (char == "	") ||
             \ (char == "-") ||
             \ (char == ";")
    endif
endfunction

" REVIEW: Why can't this be an s: function?  It seems to trigger
" a "Press ENTER" prompt in the inoremap and it's not clear why.
function! InsertQuote(leftquote, rightquote, straightquote)
    if s:ThisChar() == ">"
        exec "normal! a" . a:leftquote
    elseif s:IsInTag()
        exec "normal! a" . a:straightquote
    elseif s:IsAtWordStart()
        exec "normal! a" . a:leftquote
    else
        exec "normal! a" . a:rightquote
    endif
    call s:ResumeInsert()
endfunction

function! s:ResumeInsert()
    if strlen(getline(".")) == col(".")
        startinsert!
    else
        normal! l
        startinsert
    endif
endfunction

function! s:LookingAt(what)
    if strlen(a:what) > col(".")
        return 0
    else
        return strpart(getline("."), col(".") - strlen(a:what), strlen(a:what))
                    \ == a:what
    endif
endfunction

function! s:InstantAbbrev(key, replacement)
    if s:LookingAt(a:key)
        exec "normal! " . (strlen(a:key) - 1) . "h" .
                    \ strlen(a:key) . "s" . a:replacement
    endif
    call s:ResumeInsert()
endfunction

inoremap <buffer> ' <Esc>:call InsertQuote("&lsquo;", "&rsquo;", "'")<CR>
inoremap <buffer> " <Esc>:call InsertQuote("&ldquo;", "&rdquo;", '"')<CR>
inoremap <buffer> . .<Esc>:call <SID>InstantAbbrev("...", "&hellip;")<CR>
inoremap <buffer> - -<Esc>:call <SID>InstantAbbrev("--", "&mdash;")<CR>
