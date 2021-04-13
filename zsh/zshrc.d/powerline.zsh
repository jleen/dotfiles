[[ -z "$SV_POWERLINE_GO_BIN" ]] &&
    which go > /dev/null &&
    [[ -x `go env GOPATH`/bin/powerline-go ]] &&
    SV_POWERLINE_GO_BIN=`go env GOPATH`/bin/powerline-go

if [[ -n "$SV_POWERLINE_GO_BIN" ]]; then

    function powerline_precmd() {
        eval "$($SV_POWERLINE_GO_BIN -condensed -error $? -static-prompt-indicator -modules venv,host,ssh,cwd,perms,jobs,exit,root -modules-right git,hg,svn -shell zsh -eval -theme ${SV_POWERLINE_GO_THEME:-default} -path-aliases $SV_POWERLINE_EXTRA_ARGS)"
        if [[ -n "$SV_PROMPT_SIGIL_POWERLINE" ]]; then
            PS1=`echo $PS1 | sed -e s/%m/$SV_PROMPT_SIGIL_POWERLINE/`
        elif [[ -n "$SV_PROMPT_SIGIL" ]]; then
            PS1=`echo $PS1 | sed -e s/%m/$SV_PROMPT_SIGIL/`
        fi
        PS1="%{$SV_PROMPT_TITLE%}$PS1"
    }

    function install_powerline_precmd() {
      for s in "${precmd_functions[@]}"; do
        if [ "$s" = "powerline_precmd" ]; then
          return
        fi
      done
      precmd_functions+=(powerline_precmd)
    }

    if [ "$TERM" != "linux" ]; then
        install_powerline_precmd
    fi
fi
