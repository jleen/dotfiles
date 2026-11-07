() {
    source $SVCONFIGDIR/zsh/themes/catppuccin_frappe-zsh-syntax-highlighting.zsh

    local prefix bundle
    for prefix in /opt/homebrew/share /usr/local/share /usr/share; do
        [[ -d $prefix/zsh-autosuggestions || -d $prefix/zsh-syntax-highlighting ]] && break
    done
    for bundle in \
        $prefix/zsh-autosuggestions/zsh-autosuggestions.zsh \
        $prefix/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    do
        [[ -f $bundle ]] && source $bundle
    done
}
