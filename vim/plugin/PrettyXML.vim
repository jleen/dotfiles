" Make XML pretty

function! PrettyXML() range
    execute a:firstline . "," . a:lastline . "s/></>\r</g"
    normal =''
endfunction

command! -range PrettyXML <line1>,<line2>call PrettyXML()

noremap <Leader>x :PrettyXML<CR>
