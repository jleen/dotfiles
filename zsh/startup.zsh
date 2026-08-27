# FRONT DOOR for this entire dotfile empire.
# Bootstrap both the global and the local shell initialization.
# Global shell initialization will also configure the editor and tools.
#
[[ -n $1 ]] && HOST=$1
[[ -n $2 ]] && SHELLCOLOR=$2

export SVCONFIGDIR="${0:h:h}"

# For root shells, don't do anything fancy.
if [[ $UID = 0 || $EUID = 0 ]]; then
  setopt PRIVILEGED
else
  # We'll handle globals ourselves, so we can interleave customizations.
  # We sequence the inits as described in `man zsh`.
  set -o noglobalrcs

  # zshenv
  source $SVCONFIGDIR/zsh/env.zsh
  [[ -f $SVCONFIGDIR/local/zshenv ]] && source $SVCONFIGDIR/local/zshenv

  # zprofile
  if [[ -o LOGIN ]]; then
      [[ -f /etc/zprofile ]] && source /etc/zprofile
  fi

  # zshrc
  if [[ -o INTERACTIVE ]]; then
    [[ -f $SVCONFIGDIR/local/zshrc-pre ]] && source $SVCONFIGDIR/local/zshrc-pre
    [[ -f /etc/zshrc ]] && source /etc/zshrc
    for rc in $SVCONFIGDIR/zsh/rc/*.zsh; do
      source $rc
    done
    [[ -f $SVCONFIGDIR/local/zshrc ]] && source $SVCONFIGDIR/local/zshrc
  fi

  # zlogin
  if [[ -o LOGIN ]]; then
    [[ -f /etc/zlogin ]] && source /etc/zlogin
    [[ -f $SVCONFIGDIR/local/zlogin ]] && source $SVCONFIGDIR/local/zlogin
  fi
fi
