try_set_bin eza_bin /usr/bin/eza /opt/homebrew/bin/eza

if [[ -x $eza_bin ]]; then
    unalias ls
    function ls () {
        case $1 in
            -l)  shift ; $eza_bin -l  $* ;;
            -a)  shift ; $eza_bin -a  $* ;;
            -la) shift ; $eza_bin -la $* ;;
            -*)  /bin/ls              $* ;;
            *)           $eza_bin     $* ;;
        esac
    }
fi
