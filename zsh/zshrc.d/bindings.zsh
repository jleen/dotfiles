# Use emacs bindings, with a couple of tweaks: C-u deletes all backwards (DUH!),
# and M-q delays the current command (if there is one) or goes into the
# multiline editor.
#
# TODO(jleen): push-line-or-edit seems to be acting more like push-line.  wtf?

bindkey -e
bindkey '^u' backward-kill-line
bindkey '\eq' push-line-or-edit

# Beeping is rude.
setopt no_beep

# Retain literal '*' when there's no glob match.  This is sloppy but useful.
setopt no_nomatch
