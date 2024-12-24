[[ -z $SV_FZF_BIN ]] && [[ -x /usr/bin/fzf ]] && SV_FZF_BIN=/usr/bin/fzf

# Maybe the whole package is installed.
if [[ -z "$SV_FZF_DIR" && -d /usr/share/doc/fzf/examples ]]; then
    SV_FZF_DIR=/usr/share/doc/fzf/examples
fi

# If we found the package, use its shell integration.
if [[ -n "$SV_FZF_DIR" ]]; then
    source $SV_FZF_DIR/key-bindings.zsh
    source $SV_FZF_DIR/completion.zsh
fi

# Otherwise, if we have a standalone binary somewhere,
# use it with our own shell integration.
if [[ -n "$SV_FZF_BIN" ]]; then
    source $SVCONFIGDIR/zsh/fzf/key-bindings.zsh
    source $SVCONFIGDIR/zsh/fzf/completion.zsh
fi
