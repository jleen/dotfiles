# zshenv sets up environment variables that we want even if this is a
# noninteractive shell, e.g. variables that we'd like to have available in
# processes launched by wrapper scripts.

[[ -n $1 ]] && HOST=$1
[[ -n $2 ]] && SHELLCOLOR=$2

export SVCONFIGDIR="${0:h:h}"

# For root shells, don't do anything fancy.
if [[ $UID = 0 || $EUID = 0 ]]; then
  setopt PRIVILEGED
else
  source $SVCONFIGDIR/zsh/paths.zsh
  source $SVCONFIGDIR/zsh/env.zsh

  [[ -f $SVCONFIGDIR/local/zshenv ]] && source $SVCONFIGDIR/local/zshenv

  if [[ -o INTERACTIVE ]]; then
      [[ -f $SVCONFIGDIR/local/zshrc-pre ]] && source $SVCONFIGDIR/local/zshrc-pre
      for rc in $SVCONFIGDIR/zsh/zshrc.d/*.zsh; do
        source $rc
      done
      [[ -f $SVCONFIGDIR/local/zshrc ]] && source $SVCONFIGDIR/local/zshrc
  fi

  if [[ -o LOGIN ]]; then
      [[ -f $SVCONFIGDIR/local/zlogin ]] && source $SVCONFIGDIR/local/zlogin
  fi
fi
