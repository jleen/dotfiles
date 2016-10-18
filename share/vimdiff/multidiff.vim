" Vim script to diff a bunch of file pairs in tabs.
" Based upon work by bramm.

set columns=165
set lazyredraw
set splitright

let s:idx = 0
while s:idx < argc()
  if argv(s:idx) != ':'
    if s:idx > 2
      tabnew
    endif
    exe "silent edit " . fnameescape(argv(s:idx))
    let s:idx += 1
    exe "silent vertical diffsplit " . fnameescape(argv(s:idx))
  endif
  let s:idx += 1
endwhile

" GTK resizing doesn't work very well when the tab page labels appear.
" Reduce the number of lines here.
set lines-=2

tabrewind
set nolazyredraw
redraw
