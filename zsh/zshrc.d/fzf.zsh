if [[ -z "SV_FZF_DIR" && -d /usr/share/doc/fzf/examples ]]; then
    SV_FZF_DIR=/usr/share/doc/fzf/examples
fi

if [[ -n "$SV_FZF_DIR" ]]; then
    source $SV_FZF_DIR/key-bindings.zsh
    source $SV_FZF_DIR/completion.zsh
fi
