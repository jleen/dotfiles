source "$CONFIGDIR/bashrc"

if [ "PS1" ]; then
  # TODO(jleen): Can completion go in the main file?
  [ -f /etc/bash_completion ] && . /etc/bash_completion
  # Local aliases.
fi
