# Private Temp Dir

SVTMP="$TMPPREFIX-$USERNAME-sv"
if [ -e "$SVTMP" ]; then
  if [[ ! ( -O "$SVTMP" && -d "$SVTMP" ) ]]; then
    echo "Bad $SVTMP"
    unset SVTMP
  fi
else
  if mkdir -pm 700 "$SVTMP" 2> /dev/null; then
    echo "Created $SVTMP"
  elif [[ -O "$SVTMP" && -d "$SVTMP" ]]; then
    echo "Another process created $SVTMP for us, yay"
  else
    echo "Unable to create $SVTMP"
    unset SVTMP
  fi
fi
