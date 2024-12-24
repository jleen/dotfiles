" Now it's a whole tree!
let s:current_file=expand("<sfile>:h")
exec "set runtimepath=" . escape(s:current_file, ' ') . ","
                      \ . escape(&runtimepath, ' ') . ","
                      \ . escape(s:current_file, ' ') . "/after"
exec "set packpath=" . escape(s:current_file, ' ') . ","
                   \ . escape(&packpath, ' ') . ","
                   \ . escape(s:current_file, ' ') . "/after"

" Swapfile hygiene.
if has("unix")
    let s:swapdir = "/var/tmp/jleen/vim"
    if exists ("*mkdir") && !isdirectory(s:swapdir)
        call mkdir("/var/tmp/jleen/vim", "p", 0700)
    endif
    if isdirectory(s:swapdir)
        let &directory = s:swapdir . "//"
    endif
endif

" Viminfo hygiene.
if has("win32") || has("win64")
    if has("nvim")
        set viminfo+=n~/.nviminfo
    else
        set viminfo+=n~/.viminfo
    endif
endif

exec "source " . escape(s:current_file, ' ') . "/rc.vim"
exec "source " . escape(s:current_file, ' ') . "/theme.vim"

" It's your turn!
exec "set packpath=" . escape(s:current_file, ' ') . "/../local/vim,"
                   \ . escape(&packpath, ' ') . ","

if filereadable(escape(s:current_file, ' ') . "/../local/vimrc")
  exec "source " . escape(s:current_file, ' ') . "/../local/vimrc"
endif

if has('nvim') && filereadable(escape(s:current_file, ' ') . "/../local/vimrc")
  exec "source " . escape(s:current_file, ' ') . "/../local/vim.lua"
endif

" Hack the WSL.
let s:wslpath=matchlist(getcwd(), '\\\\wsl$\\\([a-zA-Z]*\)\\')
if len(s:wslpath) > 1
    let $HOME='\\wsl$\' . s:wslpath[1] . '\home\' . $USERNAME
endif

let g:neovide_cursor_animate_command_line = v:false

let g:vindent_motion_OO_prev   = '[=' " jump to prev block of same indent.
let g:vindent_motion_OO_next   = ']=' " jump to next block of same indent.
let g:vindent_motion_more_prev = '[+' " jump to prev line with more indent.
let g:vindent_motion_more_next = ']+' " jump to next line with more indent.
let g:vindent_motion_less_prev = '[-' " jump to prev line with less indent.
let g:vindent_motion_less_next = ']-' " jump to next line with less indent.
let g:vindent_motion_diff_prev = '[;' " jump to prev line with different indent.
let g:vindent_motion_diff_next = '];' " jump to next line with different indent.
let g:vindent_motion_XX_ss     = '[p' " jump to start of the current block scope.
let g:vindent_motion_XX_se     = ']p' " jump to end   of the current block scope.
let g:vindent_object_XX_ii     = 'ii' " select current block.
let g:vindent_object_XX_ai     = 'ai' " select current block + one extra line  at beginning.
let g:vindent_object_XX_aI     = 'aI' " select current block + two extra lines at beginning and end.
let g:vindent_jumps            = 1    " make vindent motion count as a |jump-motion| (works with |jumplist|).
