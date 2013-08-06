# Screen Meta-Management

SCREENENV=$SVTMP/screenenv

ss () {
  if [[ -n $WINDOW ]]; then
    echo "You have your slaw, sir!"
  else
    [[ -n $SCREENENV ]] && echo "" > $SCREENENV
    if screen -ls | grep -q prime; then
      if [[ -n $SCREENENV ]]; then
        for var in DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS; do
          local val=${(P)var}
          screen -S prime -X setenv $var "$val"
          echo "$var=$val" >> $SCREENENV
        done
      fi
      screen -x prime
    else
      screen -S prime
    fi
  fi
}

if [[ -n $WINDOW && -n $SCREENENV ]]; then
  function snarf_screen_env {
    local record
    for record in `cat $SCREENENV`; do
      case $record in
        DISPLAY*|XAUTHORITY*|DBUS_SESSION_BUS_ADDRESS*) export $record;;
      esac
    done
    init_svplatform
  }

  precmd_functions+=snarf_screen_env
  preexec_functions+=snarf_screen_env
fi
