" From the Reference Manual
function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-P>"
endfunction
inoremap <Esc>/ <C-R>=CleverTab()<CR>
