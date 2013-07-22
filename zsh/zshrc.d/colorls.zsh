# Color ls

if [ "$TERM" != "dumb" ] && which dircolors > /dev/null; then
  eval "`dircolors -b`"
  alias ls='ls -F --color=auto'
elif [ "$SVPLATFORM" = osx ]; then
  alias ls='ls -FG'
else
  alias ls='ls -F'
fi
