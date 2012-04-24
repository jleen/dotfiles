echo "*** TODO: install zsh! ***"

export SVCONFIGDIR=`dirname ${BASH_ARGV[0]}`

HISTFILE="$HOME/.history"
HISTCONTROL=ignoreboth

export INPUTRC="$SVCONFIGDIR/inputrc"
shopt -s extglob
shopt -s no_empty_cmd_completion
shopt -s checkwinsize
set -o emacs

[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"


if [ "$PS1" ]; then

    LS_COLOR_OPT=--color=auto

    alias r='fc -s'

    SHORTHOSTNAME=`echo $HOSTNAME|cut -d. -f1`
    if [ "$TERM" = "dumb" ]; then
        # we're probably in Emacs M-x shell
        PS1='$SHORTHOSTNAME [\w]\$ '
        alias ls='ls -F'
    else
        alias ls='ls -F $LS_COLOR_OPT'
        [ -n "$WINDOW" ] && PS1_SCREEN=":$WINDOW"
        [ -n "$WINDOW" ] && PS1_SCREENCLEAR="\\033k\033\134"
        if [ $TERM = xterm -o $TERM = xterm-color -o $TERM = screen -o $TERM = cygwin ]; then
            PS1_XTERM="\e]0;$SHELLPREFIX$SHORTHOSTNAME$PS1_SCREEN:\w\007"
        fi
    [ -n "$SHELLPREFIX" ] && COLOR_SHELLPREFIX="`tput setaf 0``tput bold`\]$SHELLPREFIX\[`tput sgr0`"
    PS1="\[$PS1_SCREENCLEAR$PS1_XTERM$COLOR_SHELLPREFIX`tput setaf ${SHELLCOLOR:-4}``tput bold`\]$SHORTHOSTNAME$PS1_SCREEN\[`tput sgr0`\] [\w]\\$ "
    fi

fi

[ "$OSTYPE" == cygwin ] && source "$SVCONFIGDIR/cygwin/zshrc"

if [ "$OSTYPE" == cygwin ]; then
    v ()
    {
        if [ -z "$*" ]; then
            cygstart --hide gvim.bat
        else
            for fn in "$@"; do
                local winfn=`cygpath -wa "$fn"`
                cygstart --hide gvim.bat "\"$winfn\""
            done
        fi
    }
    alias vv='gvim.bat -R -'
elif [ "$TERM_PROGRAM" == Apple_Terminal ]; then
    v ()
    {
        if [ -z "$*" ]; then
            mvim
        else
            for fn in "$@"; do
                mvim "$fn"
            done
        fi
    }
    alias vv='mvim -R - > /dev/null'
elif [ -n "$DISPLAY" ]; then
    v ()
    {
        if [ -z "$*" ]; then
            gvim
        else
            for fn in "$@"; do
                gvim "$fn"
            done
        fi
    }
    alias vv='gvim -R -'
elif [ -n "$WINDOW" ]; then
    v ()
    {
        if [ -z "$*" ]; then
            screen -t vi vi
        else
            for fn in "$@"; do
                screen -t "vi $fn" vi "$fn"
            done
        fi
    }
    alias vv='vi -R -'
else
    v () { vi "$@"; }
    alias vv='vi -R -'
fi
