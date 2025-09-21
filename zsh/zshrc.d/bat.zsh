try_set_bin SV_BAT_BIN /usr/bin/batcat ~/.cargo/bin/bat /usr/bin/bat

[[ -x $SV_BAT_BIN ]] && alias cat=$SV_BAT_BIN
alias batcache="bat cache --build --source $SVCONFIGDIR/bat"
