# Make paths behave sanely (unique values only!) and make sure Saturn Valley
# stuff is near the head.  Also add local stuff if it exists.
typeset -U path fpath cdpath
path[1,0]=$SVCONFIGDIR/bin
[[ -d $SVCONFIGDIR/local/bin ]] && path[1,0]=$SVCONFIGDIR/local/bin
fpath[1,0]=$SVCONFIGDIR/zsh/functions

# Where to find a few config files.  We override the default location via
# environment variables so the user doesn't have to create stubs in $HOME.
export BAT_CONFIG_PATH="$SVCONFIGDIR/bat/batconfig"
export INPUTRC="$SVCONFIGDIR/readline/inputrc"
export PYTHONSTARTUP="$SVCONFIGDIR/python/startup.py"
export SCREENRC="$SVCONFIGDIR/screen/screenrc"
export VIMINIT="source $SVCONFIGDIR/vim/startup.vim"
