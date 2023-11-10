# Saturn Valley Intergalactic Standard Command Prompt

[[ ${(%):-%#} = \# ]] && local starboat="#" || local starboat="❯"

if [[ -n $WINDOW ]]; then
    local screen=" $WINDOW"
    # https://www.gnu.org/software/screen/manual/html_node/Control-Sequences.html
    # ... but do we need this?  What happens without it?
    local screenclear="%{`print \\\\ek\\\\e\\\\134`%}"
fi

if [[ $TERM = (xterm*|rxvt*|screen) ]]; then
    local title="%{`print \\\\e`]0;$screen%~`print \\\\007`%}"
fi

local newline=$'\n'
setopt prompt_subst
PROMPT="$screenclear$title$newline%B%F{cyan}%~%f%b$screen$newline%B%F{blue}$starboat%f%b "
