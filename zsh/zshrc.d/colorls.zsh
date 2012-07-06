# Color ls

if [ "$TERM" != "dumb" ] && which dircolors > /dev/null; then
  eval "`dircolors -b`"
  alias ls='ls -F --color=auto'
elif [ "$TERM_PROGRAM" = Apple_Terminal ]; then
  alias ls='ls -FG'
else
  alias ls='ls -F'
fi
