# zshenv sets up environment variables that we want even if this is a
# noninteractive shell, e.g. variables that we'd like to have available in
# processes launched by wrapper scripts.

HOST=$1
SHELLCOLOR=$2

# This is for zsh but it's useful to have it bash-compatible (so it can be
# sourced from .xsession, for example).
if [[ -n $BASH_VERSION ]]; then
  export SVCONFIGDIR=`dirname $(dirname ${BASH_ARGV[0]})`
else
  export SVCONFIGDIR="${0:h:h}"
fi

# For root shells, don't do anything fancy.
if [[ ! -o PRIVILEGED ]]; then
  source $SVCONFIGDIR/zsh/zshenv
  [[ -f $SVCONFIGDIR/local/zshenv ]] && source $SVCONFIGDIR/local/zshenv

  if [[ -o INTERACTIVE ]]; then
      source $SVCONFIGDIR/zsh/zshrc
      [[ -f $SVCONFIGDIR/local/zshrc ]] && source $SVCONFIGDIR/local/zshrc
  fi

  if [[ -o LOGIN ]]; then
      [[ -f $SVCONFIGDIR/local/zlogin ]] && source $SVCONFIGDIR/local/zlogin
  fi
fi
