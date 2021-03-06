if [[ $SVPLATFORM = cygwin ]]; then
    alias ls='ls --color=auto -pUG'
    eval `dircolors -b "$SVCONFIGDIR/dircolors"`
    export SVN_EDITOR='gvim.bat -f'
    [[ -o l ]] && path[1,0]=/usr/bin && cd  # Srsly?
    VIMINIT="source `cygpath -wa $SVCONFIGDIR | sed 's/ /\\ /'`/vim/startup.vim"
    setopt NO_GLOBAL_RCS

    # Let's see how completely this confuses me on OS X.
    alias open=cygstart

    cygtrans () {
        local -a CMD=("$1")
        shift
        local ARG
        for ARG in "$@"; do
            if [ -e "$ARG" ]; then
                CMD=("${CMD[@]}" "`cygpath -w "$ARG"`")
            else
                CMD=("${CMD[@]}" "$ARG")
            fi
        done
        "${CMD[@]}"
    };

    cygimport () {
        alias $1="cygtrans $1"
    }

    cygimport-batch () {
        alias $1="cygtrans $1.bat"
    }

    cygimport-cmd () {
        alias $1="cygtrans $1.cmd"
    }

    cygimport-builtin () {
        alias $1="cygtrans cmd /c $1"
    }

    if [[ -n $ZSH_VERSION ]]; then unalias -m dir; else unalias dir; fi
    dir () {
        local THE_DIR=`cygpath -wa ${1:-.}`
        pushd ~ > /dev/null
        cd    # Avoid annoying CMD.EXE UNC path warning
        cmd /c dir "$THE_DIR"
        popd > /dev/null
        echo  # Wonder why we need this?
    }

    cygimport-builtin start

    # Need absolute path to cat because I've seen dev environments on Windows
    # which contain their own version of cat.

    for x in `/bin/cat "${CYGIMPORTPREFIX:-$HOME/.}exe.imports"`; do
        cygimport $x
    done
    for x in `/bin/cat "${CYGIMPORTPREFIX:-$HOME/.}bat.imports"`; do
        cygimport-batch $x
    done
    for x in `/bin/cat "${CYGIMPORTPREFIX:-$HOME/.}cmd.imports"`; do
        cygimport-cmd $x
    done
fi
