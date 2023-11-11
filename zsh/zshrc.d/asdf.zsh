if [[ -f ~/.asdf/asdf.sh ]]; then
    . ~/.asdf/asdf.sh
    fpath[1,0]=(${ASDF_DIR}/completions)
fi
