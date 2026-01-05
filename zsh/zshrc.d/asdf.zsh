export ASDF_DATA_DIR=$HOME/.asdf
if [[ -d $ASDF_DATA_DIR ]]; then
    path[1,0]=(${ASDF_DATA_DIR}/shims)
fi
