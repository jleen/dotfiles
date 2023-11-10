# Saturn Valley Intergalactic Standard Command Prompt

local caret=${SV_PROMPT_CARET:-%#}
if [[ -n $SV_PROMPT_COLOR_CARET ]]; then
    caret=$'%{\e[38;5;${SV_PROMPT_COLOR_CARET}m%}${SV_PROMPT_CARET:-%#}%{\e(B\e[m%}'
fi

local pre_pwd post_pwd pre_window host
if [[ -n $SV_PROMPT_SIGIL ]]; then
    host=$SV_PROMPT_SIGIL
    if [[ -n $SV_PROMPT_COLOR_PWD ]]; then
        pre_pwd=$'%{\e[38;5;${SV_PROMPT_COLOR_PWD}m%}'
        post_pwd=$'%{\e(B\e[m%}'
    fi
else
    pre_window=':'
    if [[ -n $HOST ]]; then
        host=$HOST
    else
        host=`uname -n`
    fi
    pre_pwd='['
    post_pwd=']'
fi

local short_host=`echo ${host}|cut -d. -f1`
local color_host=${SV_PROMPT_SIGIL_COLOR:-$short_host}
if type tput > /dev/null; then
    local tput_setaf_0=`tput setaf 0`
    local tput_bold=`tput bold`
    local tput_sgr0=`tput sgr0`
    local tput_setaf=`tput setaf ${SV_PROMPT_COLOR:-4}`
else
    # Do it by hand.
    local tput_setaf_0=$'\e[30m'
    local tput_bold=$'\e[1m'
    local tput_sgr0=$'\e(B\e[m'
    local tput_setaf=$'\e}[3${SV_PROMPT_COLOR:-4}m'
fi
if [[ -n $WINDOW ]]; then
    local screen=":$WINDOW"
    local screen_clear="`print \\\\ek\\\\e\\\\134`"
fi
if [[ $TERM = (xterm*|rxvt*|screen|cygwin) ]]; then
    local xterm="`print \\\\e`]0;$SHELLPREFIX${short_host}${screen}$pre_window\${SV_SPECIAL_WINDOW_PROMPT}\${SV_PWD_PROMPT:-%~}`print \\\\007`"
fi
if [[ -n $SHELLPREFIX ]]; then
    local prefix="%{$tput_setaf_0$tput_bold%}$SHELLPREFIX%{$tput_sgr0%}"
fi
SV_PROMPT_TITLE="%{${screen_clear}${xterm}${shellprefix}%}"
local color_on="%{$tput_setaf$tput_bold%}"
local color_off="%{$tput_sgr0%}"
setopt prompt_subst
PROMPT="${SV_PROMPT_TITLE}${prefix}${color_on}${short_host}${screen}${color_off} $pre_pwd\${SV_SPECIAL_PROMPT}\${SV_PWD_PROMPT:-%~}$post_pwd$caret "
