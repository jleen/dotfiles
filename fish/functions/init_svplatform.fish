function init_svplatform
    if [ "$TERM_PROGRAM" = "Apple_Terminal" ]
    or [ "$TERM_PROGRAM" = "iTerm.app" ]
        set -x SVPLATFORM osx
    else if [ -n "$DISPLAY" ]
        set -x SVPLATFORM X11
    else if [ -n "$WINDOW" ]
        set -x SVPLATFORM screen
    else
        set -x SVPLATFORM vt
    end

    if uname -v | grep -q PREEMPT
    or uname -r | grep -q Microosft
    or [ -n "$WSL_INTEROP" ]
        set -x SVLINUX wsl
    end

    if [ $SVPLATFORM = X11 ]
        set -x EDITOR 'gvim -f'
    else
        set -x EDITOR vi
    end
    set -x VISUAL $EDITOR
end
