au! BufRead /tmp/mutt-* setfiletype cs
if (stridx(bufname("%"), "/tmp/mutt-") == 0)
    /^$
    +
endif
