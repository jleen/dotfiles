[[ -z $SV_STARSHIP_BIN ]] && [[ -x ~/.cargo/bin/starship ]] && SV_STARSHIP_BIN=~/.cargo/bin/starship
[[ -z $SV_STARSHIP_BIN ]] && [[ -x /snap/starship/current/bin/starship ]] && SV_STARSHIP_BIN=/snap/starship/current/bin/starship
export STARSHIP_CONFIG="$SVCONFIGDIR/starship/starship.toml"
if [[ -x "$SV_STARSHIP_BIN" ]]; then
    eval "$($SV_STARSHIP_BIN init zsh)"
    typeset -ga precmd_functions

    function sv_prompt_window_title {
        local ssh screen
        [[ -n $SSH_CONNECTION ]] && ssh="$HOST "
        [[ -n $WINDOW ]] && screen="$WINDOW "
        print -Pn "\e]0;$ssh$screen%~\007"
    }
    precmd_functions+='sv_prompt_window_title'
    sv_prompt_window_title
fi
