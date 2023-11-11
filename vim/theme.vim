" GUI display options
if has("gui_running")
    if !has ("gui_macvim")
        set lines=50
    endif
    set columns=80
    set cursorline
endif

if has("gui_running") || &t_Co >= 256
    set background=dark
    syntax enable
    colorscheme paisaje
    set laststatus=2
    let g:lightline = { 'colorscheme': 'landscape' }
endif

set guioptions+=a  " autoselect: xterm-style clipboard cut
set guioptions-=T  " no toolbar

hi normal guifg=gray90 guibg=black
hi CursorLine guibg=gray20

" Cursor line travels with focus.
au WinEnter * set cursorline
au WinLeave * set nocursorline
au FocusGained * set cursorline
au FocusLost * set nocursorline

if has("gui_win32")
    set winaltkeys=no
    set guifont=Cascadia_Code_PL:h10:cANSI,Lucida_Console:h10:cANSI
    let g:Tex_UsePython=0
endif

if has ("gui_macvim")
    set transparency=0
    function! s:set_font()
        if len(getfontname('Monoid'))
            set guifont=Monoid:h14
            let g:big_font="Monoid:h18"
        else
            set guifont=Menlo_Regular:h13
        endif
    endfunction
    autocmd GUIEnter * call s:set_font()
endif

if has("gui_gtk")
    function! s:set_font()
        if exists("g:sv_font") && len(g:sv_font)
            let &guifont=g:sv_font
        elseif len(getfontname('Monoid'))
            set guifont=Monoid\ 9
            let g:big_font="Monoid 14"
        else
            set guifont=Monospace\ 12
            let g:big_font="Monospace 16"
        endif
    endfunction
    autocmd GUIEnter * call s:set_font()
endif

" Generic display options
set background=dark
