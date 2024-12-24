if has("gui_running")
    set lines=50 columns=80
endif

if has("gui_running") || &t_Co >= 256
    set background=dark
    colorscheme paisaje
    set laststatus=2  " Every window has a status line.
    let g:lightline = { 'colorscheme': 'landscape' }

    " Highlight cursor line in focused window only.
    set cursorline
    au WinEnter * set cursorline
    au WinLeave * set nocursorline
    au FocusGained * set cursorline
    au FocusLost * set nocursorline
endif

set winaltkeys=no  " On Windows, don't use Alt for menus.
set guioptions-=T  " On Windows, don't show the toolbar.
set guioptions+=a  " On X, Visual mode sets the global selection.

if exists("g:sv_font") && len(g:sv_font)
    let &guifont=g:sv_font
else
    if has("gui_win32")
        set guifont=Cascadia_Code_PL:h10:cANSI,Lucida_Console:h10:cANSI
    elseif has ("gui_macvim")
        set guifont=Monoid:h14,Menlo_Regular:h13
        let g:big_font="Monoid:h18,Menlo_Regular:h17"
    elseif has("gui_gtk")
        set guifont=Monospace\ 12
        let g:big_font="Monospace 16"
    elseif has("nvim") && has("gui_running")
        set guifont=Cascadia_Mono_PL:h12
        let g:big_font="Cascadia_Mono_PL:h16"
    endif
endif
