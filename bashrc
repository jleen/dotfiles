HISTFILE="$HOME/.history"
export CONFIGDIR="${CONFIGDIR:-$HOME/config}"
export INPUTRC="$CONFIGDIR/inputrc"
shopt -s extglob
shopt -s no_empty_cmd_completion
set -o emacs

if [ "$PS1" ]; then

    # set a fancy prompt
    
    alias ss='screen -ls | grep prime > /dev/null && screen -x prime || screen -S prime'
    alias ll='ls -l'
    alias la='ls -A'
    alias l='ls -CF'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
    alias r='fc -s'

    if [ "$TERM" = "dumb" ]; then
	# we're probably in Emacs M-x shell
        PS1='\h [$PWD]\$ '
        alias ls='ls -F'
    else
        alias ls='ls -F --color=auto'
        [ -n "$WINDOW" ] && PS1_SCREEN=":$WINDOW"
        SHORTHOSTNAME=`echo $HOSTNAME|cut -d. -f1`
        [ $TERM = xterm -o $TERM = screen -o $TERM = cygwin ] && PS1_XTERM="]0;$SHORTHOSTNAME$PS1_SCREEN:\w"
	PS1="\[$PS1_XTERM`tput setaf ${SHELLCOLOR:-4}``tput bold`\]$SHORTHOSTNAME$PS1_SCREEN\[`tput sgr0`\] [\$PWD]\$ "
    fi

fi

[ "$OSTYPE" == cygwin ] && source "$CONFIGDIR/cygwin.bash"

go ()
{
    cd `locate $1|sed -e 's/\/[^/]*$//'`
}
    
if [ "$OSTYPE" == cygwin ]; then
    v ()
    {
        if [ -z "$*" ]; then
            cygstart --hide gvim
        else
            for fn in "$@"; do
                cygstart --hide gvim "\"`cygpath -wa "$fn"`\""
            done
        fi
    }
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
elif [ -n "$WINDOW" ]; then
    v ()
    {
        if [ -z "$*" ]; then
            screen vi
        else
            for fn in "$@"; do
                screen -t "vi $fn" vi "$fn"
            done
        fi
    }
else
    v () { vi "$@"; }
fi

gman ()
{
    man $* | col -b | gview -
}
