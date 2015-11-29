# Saturn Valley Intergalactic Standard Command Prompt

# TODO(jleen): I should be able to do "function {" and get an anonymous scope
# that's executed immediately.  Maybe it only works on versions > 4.3.4, which
# is what Leopard gives me?
setprompt () {
  [[ -n $HOST ]] && host=$HOST || host=`uname -n`
  local short_host=`echo ${host}|cut -d. -f1`
  if [[ $TERM = dumb ]]; then
    # We're probably in Emacs M-x shell.
    PROMPT='${short_host} [%~]%# '
  else
    if [[ -n $WINDOW ]]; then
      local screen=":$WINDOW"
      local screen_clear="`print \\\\ek\\\\e\\\\134`"
    fi
    if [[ $TERM = (xterm*|rxvt*|screen|cygwin) ]]; then
      local xterm="`print \\\\e`]0;$SHELLPREFIX${short_host}${screen}:%~`print \\\\007`"
    fi
    if [[ -n $SHELLPREFIX ]]; then
      local prefix="%{`tput setaf 0``tput bold`%}$SHELLPREFIX%{`tput sgr0`%}"
    fi
    local cruft="%{${screen_clear}${xterm}${shellprefix}%}"
    local color_on="%{`tput setaf ${SHELLCOLOR:-4}``tput bold`%}"
    local color_off="%{`tput sgr0`%}"
    setopt prompt_subst
    PROMPT="${cruft}${prefix}${color_on}${short_host}${screen}${color_off} [\${SV_SPECIAL_PROMPT}\${SV_PWD_PROMPT:-%~}]%# "
  fi
}
setprompt
unfunction setprompt
