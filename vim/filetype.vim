if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.aspx setfiletype aspcs
  au! BufRead,BufNewFile *.asps setfiletype aspcs
  au! BufRead,BufNewFile *.xms  setfiletype xml
  au! BufRead,BufNewFile *.jss  setfiletype javascript
augroup END
