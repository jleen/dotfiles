# Saturn Valley Pandimensional Uniform Editor Launcher

function () {
  # Silently spawn an unowned process.
  spawn () { ($* > /dev/null 2>&1 &) }

  # The all-important EDITOR.
  if [[ -n $DISPLAY ]]; then
    export EDITOR='gvim -f'
  else
    export EDITOR='vi'
  fi
  export VISUAL=$EDITOR

  ##
  ##   W I N D O W S   ( W S L )
  #    (pop up "real Windows" Gvim if available)
  ##
  if [[ `uname -r` = *Microsoft* || -n $WSL_INTEROP ]]; then
    # TODO: We should see if Gvim is even available.
    v () {
      if [[ $#* -gt 3 ]]; then
        if [[ $1 == -f ]]; then
          shift
        else
          echo 'Specify -f to edit lots of files at once.'
          return 1
        fi
      fi
      if [[ -z $* ]]; then
        spawn "${SV_GVIM_EXE:-gvim.exe}"
      else
        for fn in $@; do
          fn=`wslpath -wa $fn`
          spawn "${SV_GVIM_EXE:-gvim.exe}" "$fn"
        done
      fi
    }
    alias vv='spawn "${SV_GVIM_EXE:-gvim.exe}" -R -'
    alias vvv='spawn "${SV_GVIM_EXE:-gvim.exe}"'

  ##
  ##  M A C I N T O S H
  ##  (MacVim if available; otherwise skip this case)
  ##
  elif [[ -d /Applications/MacVim.app ]]; then
    local macvim_dir=/Applications/MacVim.app/Contents/bin
    [[ -d $macvim_dir ]] && path+=$macvim_dir

    v () {
      if [[ $#* -gt 3 ]]; then
        if [[ $1 == -f ]]; then
          shift
        else
          echo 'Specify -f to edit lots of files at once.'
          return 1
        fi
      fi
      if [[ -z $* ]]; then
        mvim
      else
        local groggy sleeping
        pgrep -qx MacVim || groggy=1
        for fn in $@; do
          [[ -n $sleeping ]] && sleep 0.3 && unset sleeping
          mvim $fn
          [[ -n $groggy ]] && sleeping=1 && unset groggy
        done
      fi
    }
    alias vv='mvim -R - > /dev/null'
    alias vvv='mvim -R'

  ##
  ##  G E N E R I C   T E R M I N A L
  ##  (including screen)
  ##
  else
    v () {
      if [[ $#* -gt 3 ]]; then
        if [[ $1 == -f ]]; then
          shift
        else
          echo 'Specify -f to edit lots of files at once.'
          return 1
        fi
      fi
      if [[ -n $DISPLAY ]]; then
        if [[ -z $* ]]; then
          gvim
        else
          for fn in $@; do
            gvim $fn
          done
        fi
      elif [[ -n $WINDOW ]]; then
        if [[ -z $* ]]; then
          # TODO: Get rid of TERM hack for Mac OS.
          TERM=screen-256color screen -t vi vi
        else
          for fn in $@; do
            screen -t "vi $fn" vi $fn
          done
        fi
      else
        vi $@
      fi
    }
    # Check for X at invocation time, to support screen reattach.
    # (Our screen harness already updates DISPLAY at reattach.)
    vv () {
      if [[ -n $DISPLAY ]]; then
        gvim -R -
      else
        vi -R -
      fi
    }
    vvv () {
      if [[ -n $DISPLAY ]]; then
        gvim
      else
        vi
      fi
    }
  fi
}
