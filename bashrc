HISTFILE=$HOME/.history
shopt -s extglob

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
        [ -n "$WINDOW" ] && PS1_SCREEN=":$WINDOW"
        [ $TERM = xterm -o $TERM = screen ] && PS1_XTERM="]0;$HOSTNAME$PS1_SCREEN"
        [ $TERM = cygwin ] && PS1_XTERM="]0;Cygwin - bash"
	PS1='\[$PS1_XTERM`tput setaf ${SHELLCOLOR:-4}``tput bold`\]$HOSTNAME$PS1_SCREEN\[`tput sgr0`\] [$PWD]\$ '
    fi

fi
