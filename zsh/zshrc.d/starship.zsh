export STARSHIP_CONFIG="$SVCONFIGDIR/starship/starship.toml"
[[ -x "$SV_STARSHIP_BIN" ]] && eval "$($SV_STARSHIP_BIN init zsh)"
