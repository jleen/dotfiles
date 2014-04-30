# Case-insensitive, partial-word, and substring completion, cribbed from
# oh-my-zsh.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
