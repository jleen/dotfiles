if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.aspx setfiletype aspcs
  au! BufRead,BufNewFile *.asps setfiletype aspcs
  au! BufRead,BufNewFile *.xms  setfiletype xml
  au! BufRead,BufNewFile *.jss  setfiletype javascript
  au! BufRead,BufNewFile *.bat,*.cmd call <SID>SetBatchFT()
augroup END

fun! <SID>SetBatchFT()
    if getline(1) =~? "rem.*perl"
        setf perl
    else
        setf dosbatch
    endif
endfun
