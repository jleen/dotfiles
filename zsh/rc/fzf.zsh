try_set_bin SV_FZF_BIN ~/.local/bin/fzf /usr/bin/fzf /opt/homebrew/bin/fzf

[[ -n $SV_FZF_BIN ]] && source <($SV_FZF_BIN --zsh)
