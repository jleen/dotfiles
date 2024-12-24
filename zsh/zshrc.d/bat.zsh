[[ -z $SV_BAT_BIN ]] && [[ -x /usr/bin/batcat ]] && SV_BAT_BIN=/usr/bin/batcat
[[ -z $SV_BAT_BIN ]] && [[ -x ~/.cargo/bin/bat ]] && SV_BAT_BIN=~/.cargo/bin/bat

[[ -x $SV_BAT_BIN ]] && alias cat=$SV_BAT_BIN
alias batcache="bat cache --build --source $SVCONFIGDIR/bat"
