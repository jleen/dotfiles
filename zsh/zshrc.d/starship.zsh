try_set_bin() {
    local varname="$1"
    shift

    for candidate in "$@"; do
        eval "[[ -z $`echo $varname` ]] && [[ -x \"`echo $candidate`\" ]] && `echo $varname`=\"`echo $candidate`\""
    done
}

try_set_bin SV_STARSHIP_BIN ~/.local/bin/starship ~/.cargo/bin/starship /snap/starship/current/bin/starship

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
