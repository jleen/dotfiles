# Screen Meta-Management

# Private temp dir.
SVTMP=$TMPPREFIX-$USERNAME-sv
if [[ -e $SVTMP ]]; then
  if [[ ! ( -O $SVTMP && -d $SVTMP ) ]]; then
    echo "Bad $SVTMP"
    unset SVTMP
  fi
else
  if mkdir -pm 700 "$SVTMP" 2> /dev/null; then
    echo "Created $SVTMP"
  elif [[ -O $SVTMP && -d $SVTMP ]]; then
    echo "Another process created $SVTMP for us, yay"
  else
    echo "Unable to create $SVTMP"
    unset SVTMP
  fi
fi

if [[ -d $SVTMP ]]; then
  SCREENENV=$SVTMP/screenenv
else
  SCREENENV=$HOME/screenenv
fi

sv_exportable_vars=(
    DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS SV_SUPPRESS_ITERM
)

ss () {
  if [[ -n $WINDOW ]]; then
    echo "You have your slaw, sir!"
  else
    [[ -n $SCREENENV ]] && echo "" > $SCREENENV
    if screen -ls | grep -q prime; then
      if [[ -n $SCREENENV ]]; then
        for var in $sv_exportable_vars; do
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
      local varname=`echo $record | cut -d= -f1`
      local varval=`echo $record | cut -d= -f2-`
      if (( $sv_exportable_vars[(I)$varname] )); then
        export $varname=$varval
      fi
    done
    init_svplatform
  }

  precmd_functions+=snarf_screen_env
  preexec_functions+=snarf_screen_env
fi
