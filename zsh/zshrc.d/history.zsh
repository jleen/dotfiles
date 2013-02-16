# Set up command history.  Store it in the obvious place, store lots of it, and
# share it between shell instances.

HISTFILE=$HOME/.history
HISTSIZE=10100
SAVEHIST=10000
setopt inc_append_history  # fc -RI to import from other shells.
