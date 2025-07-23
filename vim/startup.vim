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

if has('nvim') && filereadable(escape(s:current_file, ' ') . "/../local/vim.lua")
  exec "source " . escape(s:current_file, ' ') . "/../local/vim.lua"
endif

" Set the font as late as possible, to allow local overrides
" without triggering an error if the default isn’t on this system.
let &guifont=g:sv_font

" Hack the WSL.
let s:wslpath=matchlist(getcwd(), '\\\\wsl$\\\([a-zA-Z]*\)\\')
if len(s:wslpath) > 1
    let $HOME='\\wsl$\' . s:wslpath[1] . '\home\' . $USERNAME
endif


