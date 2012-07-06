# Don't delete so much.
# Adapted from http://www.zsh.org/mla/users/2009/msg00589.html .
_my_extended_wordchars='*?[]~&;!#$%^(){}<>@\\';
_my_extended_wordchars_space="${my_extended_wordchars} "
_my_extended_wordchars_slash="${my_extended_wordchars}/"

# is the current position \-quoted ?
function _is_quoted(){
  test "${BUFFER[$CURSOR-1,CURSOR-1]}" = "\\"
}

_unquote-backward-delete-word(){
  while  _is_quoted
    do zle .backward-kill-word
  done
}

_unquote-forward-delete-word(){
  while  _is_quoted
    do zle .kill-word
  done
}

_unquote-backward-word(){
  while  _is_quoted
    do zle .backward-word
  done
}

_unquote-forward-word(){
  while _is_quoted
    do zle .forward-word
  done
}

_backward-delete-to-space() {
  local WORDCHARS=${_my_extended_wordchars_slash}
  zle .backward-kill-word
  _unquote-backward-delete-word
}

_backward-delete-to-/ () {
  local WORDCHARS=${_my_extended_wordchars}
  zle .backward-kill-word
  _unquote-backward-delete-word
}

_forward-delete-to-space() {
  local WORDCHARS=${_my_extended_wordchars_slash}
  zle .kill-word
  _unquote-forward-delete-word
}

_forward-delete-to-/ () {
  local WORDCHARS=${_my_extended_wordchars}
  zle .kill-word
  _unquote-forward-delete-word
}

_backward-to-space() {
  local WORDCHARS=${_my_extended_wordchars_slash}
  zle .backward-word
  _unquote-backward-word
}

_forward-to-space() {
   local WORDCHARS=${_my_extended_wordchars_slash}
   zle .forward-word
   _unquote-forward-word
}

_backward-to-/ () {
  local WORDCHARS=${_my_extended_wordchars}
  zle .backward-word
  _unquote-backward-word
}

_forward-to-/ () {
  local WORDCHARS=${_my_extended_wordchars}
  zle .forward-word
  _unquote-forward-word
}

zle -N _backward-delete-to-/
zle -N _forward-delete-to-/
zle -N _backward-delete-to-space
zle -N _forward-delete-to-space
zle -N _backward-to-/
zle -N _forward-to-/
bindkey '^w'       _backward-delete-to-/
bindkey "^[b"      _backward-to-/
bindkey "^[f"      _forward-to-/
bindkey "^[^?"     _backward-delete-to-/
bindkey "^[d"      _forward-delete-to-/
# xterm
bindkey "^[[3;3~"  _forward-delete-to-/
bindkey "^[[1;3C" _forward-to-/
bindkey "^[[1;3D" _backward-to-/
# Terminal.app
bindkey "^[[5C" _forward-to-/
bindkey "^[[5D" _backward-to-/
bindkey "^[^[[C"  _forward-to-/
bindkey "^[^[[D"  _backward-to-/
# Why does Skai need these other Terminal.app codes?  10.5 versus 10.6 maybe?
bindkey "^[O5C" _forward-to-/
bindkey "^[O5D" _backward-to-/
# PuTTY
# TODO(jleen): Why did we want these next two?  They break ssh from Darwin.
#bindkey "^[OC" _forward-to-/
#bindkey "^[OD" _backward-to-/
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
# xterm over NX on Leopard (bite me)
bindkey "^[[1;9C" _forward-to-/
bindkey "^[[1;9D" _backward-to-/
