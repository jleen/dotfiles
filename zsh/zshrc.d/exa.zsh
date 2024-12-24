for exa_bin in "$SV_EXA_BIN" ./cargo/bin/exa /usr/local/bin/exa /usr/bin/eza; do
    if [[ -x $exa_bin ]]; then
        unalias ls
        function ls () {
            case $1 in
                -l)  shift ; $exa_bin -l  $* ;;
                -a)  shift ; $exa_bin -a  $* ;;
                -la) shift ; $exa_bin -la $* ;;
                -*)  /bin/ls                      $* ;;
                *)           $exa_bin     $* ;;
            esac
        }
        break
    fi
done
