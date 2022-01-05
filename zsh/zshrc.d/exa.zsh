[[ -z $SV_EXA_BIN ]] && [[ -x ~/.cargo/bin/exa ]] && SV_EXA_BIN=~/.cargo/bin/exa

if [ -x $SV_EXA_BIN ]; then
    unalias ls
    function ls () {
        case $1 in
            -l)  shift ; $SV_EXA_BIN -l  $* ;;
            -a)  shift ; $SV_EXA_BIN -a  $* ;;
            -la) shift ; $SV_EXA_BIN -la $* ;;
            -*)  /bin/ls                      $* ;;
            *)           $SV_EXA_BIN     $* ;;
        esac
    }
fi
