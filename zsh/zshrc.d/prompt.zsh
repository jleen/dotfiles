# Saturn Valley Intergalactic Standard Command Prompt

# Distinguished funny symbol for root shell.
[[ ${(%):-%#} = \# ]] && local starboat="#" || local starboat="❯"

# GNU Screen identification.
if [[ -n $WINDOW ]]; then
    local screen=" $WINDOW"
    # https://www.gnu.org/software/screen/manual/html_node/Control-Sequences.html
    # ... but do we need this?  What happens without it?
    local screenclear="%{`print \\\\ek\\\\e\\\\134`%}"
fi

# Window title.
if [[ $TERM = (xterm*|rxvt*|screen) ]]; then
    local title="%{`print \\\\e`]0;$screen%~`print \\\\007`%}"
fi

# Hack around annoying shell quote behavior.
local newline=$'\n'

# Needed so we can pass $SV_PROMPT_EXTRA by name.
setopt prompt_subst

# Put it all together.
PROMPT="$screenclear$title$newline%B%F{cyan}%~%f%b$screen\$SV_PROMPT_EXTRA$newline%B%F{blue}$starboat%f%b "
