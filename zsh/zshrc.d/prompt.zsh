# Saturn Valley Intergalactic Standard Command Prompt

local starboat="❯"

if [[ -n $WINDOW ]]; then
    local screen=" $WINDOW"
    local screen_clear="`print \\\\ek\\\\e\\\\134`"
fi
if [[ $TERM = (xterm*|rxvt*|screen|cygwin) ]]; then
    local xterm="`print \\\\e`]0;$SHELLPREFIX${screen}:\${SV_SPECIAL_WINDOW_PROMPT}\${SV_PWD_PROMPT:-%~}`print \\\\007`"
fi
local sv_prompt_title="%{${screen_clear}${xterm}${shellprefix}%}"
local color_on="%{$tput_setaf$tput_bold%}"
local color_off="%{$tput_sgr0%}"
setopt prompt_subst
local newline=$'\n'
PROMPT="$sv_prompt_title$newline$prefix%B%F{cyan}%~%f%b$screen$newline%B%F{blue}$starboat%f%b "
