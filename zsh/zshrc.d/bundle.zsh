for bundle in "$SVCONFIGDIR/zsh/bundle/zsh-autosuggestions/zsh-autosuggestions.zsh" "$SVCONFIGDIR/zsh/bundle/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"; do
    [ -f $bundle ] && source $bundle
done
