# Apply all deb updates.
alias aptup='sudo apt-get --yes update; sudo apt-get --yes dist-upgrade'

# Sort "top" by CPU use on OS X, where for some reason this isn't the default.
[ "$SVPLATFORM" = osx ] && alias top='top -o cpu'

# Show a man page in a gvim window.
# TODO(jleen): Make this part of v.zsh and make it work on OS X.
gman () { man $* | col -b | gview - }

# Recursively grep the current directory, ignoring VC metadata and caches.
srcgrep () {
  grep -r "$*" . | grep -v tags | grep -v \\.svn| grep -v \\.git \
      | grep -v "Binary file"
}
