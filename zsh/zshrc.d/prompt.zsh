# Saturn Valley Intergalactic Standard Command Prompt

[[ -n $HOST ]] && host=$HOST || host=`uname -n`
local short_host=`echo ${host}|cut -d. -f1`
if [[ $TERM = dumb ]]; then
  # We're probably in Emacs M-x shell.
  PROMPT='${short_host} [%~]%# '
else
  if type tput > /dev/null; then
    local tput_setaf_0=`tput setaf 0`
    local tput_bold=`tput bold`
    local tput_sgr0=`tput sgr0`
    local tput_setaf=`tput setaf ${SHELLCOLOR:-4}`
  else
    # Do it by hand.
    local tput_setaf_0=$'\e[30m'
    local tput_bold=$'\e[1m'
    local tput_sgr0=$'\e(B\e[m'
    local tput_setaf=$"\e}[3${SHELLCOLOR:-4}m"
    local tput_setaf=$'\e[34m'
  fi
  if [[ -n $WINDOW ]]; then
    local screen=":$WINDOW"
    local screen_clear="`print \\\\ek\\\\e\\\\134`"
  fi
  if [[ $TERM = (xterm*|rxvt*|screen|cygwin) ]]; then
    local xterm="`print \\\\e`]0;$SHELLPREFIX${short_host}${screen}:%~`print \\\\007`"
  fi
  if [[ -n $SHELLPREFIX ]]; then
    local prefix="%{$tput_setaf_0$tput_bold%}$SHELLPREFIX%{$tput_sgr0%}"
  fi
  local cruft="%{${screen_clear}${xterm}${shellprefix}%}"
  local color_on="%{$tput_setaf$tput_bold%}"
  local color_off="%{$tput_sgr0%}"
  setopt prompt_subst
  PROMPT="${cruft}${prefix}${color_on}${short_host}${screen}${color_off} [\${SV_SPECIAL_PROMPT}\${SV_PWD_PROMPT:-%~}]%# "
fi
