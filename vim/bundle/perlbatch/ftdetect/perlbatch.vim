au! BufRead,BufNewFile *.bat,*.cmd call <SID>SetBatchFT()

fun! <SID>SetBatchFT()
    if getline(1) =~? "rem.*perl"
        setf perl
    else
        setf dosbatch
    endif
endfun
