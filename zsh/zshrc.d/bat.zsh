[[ -z $SV_BAT_BIN ]] && [[ -x ~/.cargo/bin/bat ]] && SV_BAT_BIN=~/.cargo/bin/bat

[[ -x $SV_BAT_BIN ]] && alias cat=$SV_BAT_BIN
