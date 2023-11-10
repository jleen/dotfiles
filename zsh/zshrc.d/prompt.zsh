# Saturn Valley Intergalactic Standard Command Prompt

[[ ${(%):-%#} = \# ]] && local starboat="#" || local starboat="❯"

if [[ -n $WINDOW ]]; then
    local screen=" $WINDOW"
    local screen_clear="`print \\\\ek\\\\e\\\\134`"  # ???
fi
if [[ $TERM = (xterm*|rxvt*|screen|cygwin) ]]; then
    local xterm="`print \\\\e`]0;$SHELLPREFIX${screen}:\${SV_SPECIAL_WINDOW_PROMPT}%~`print \\\\007`"
fi
local title="%{${screen_clear}${xterm}%}"
local newline=$'\n'
setopt prompt_subst
PROMPT="$title$newline$prefix%B%F{cyan}%~%f%b$screen$newline%B%F{blue}$starboat%f%b "
