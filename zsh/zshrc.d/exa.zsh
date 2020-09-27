if [ -x ~/.cargo/bin/exa ]; then
    unalias ls
    function ls () {
        case $1 in
            -l)  shift ; ~/.cargo/bin/exa -l  $* ;;
            -a)  shift ; ~/.cargo/bin/exa -a  $* ;;
            -la) shift ; ~/.cargo/bin/exa -la $* ;;
            -*)  /bin/ls                      $* ;;
            *)           ~/.cargo/bin/exa     $* ;;
        esac
    }
fi
