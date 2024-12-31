# Saturn Valley Pandimensional Uniform Editor Launcher

# Figure out the sort of environment we're running on,
# so later tweaks can behave appropriately.
local sv_v_platform
if [[ `uname -r` = *Microsoft* || -n $WSL_INTEROP ]]; then
  sv_v_platform=wsl
elif [[ $OSTYPE = cygwin ]]; then
  sv_v_platform=cygwin
# TODO(jleen): Make the OS X check less bogus.
elif [[ $TERM_PROGRAM = Apple_Terminal || $TERM_PROGRAM = iTerm.app ]]; then  
  sv_v_platform=osx
elif [[ -n $DISPLAY ]]; then
  sv_v_platform=X11
elif [[ -n $WINDOW ]]; then
  sv_v_platform=screen
else
  sv_v_platform=vt
fi

# Find NeoVim if we can.
[[ -z $SV_NVIM_BIN ]] && whence -p nvim > /dev/null && SV_NVIM_BIN=`whence -p nvim`
echo $SV_NVIM_BIN
# The all-important EDITOR.
if [[ -n $SV_NVIM_BIN ]]; then
  export EDITOR='nvim'
elif [[ $sv_v_platform = X11 ]]; then
  export EDITOR='gvim -f'
else
  export EDITOR='vi'
fi
export VISUAL=$EDITOR

if [[ $SV_NEOVIDE_BIN ]]; then
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
      spawn "$SV_NEOVIDE_BIN" --wsl
    else
      for fn in $@; do
        # We use -- to work around https://github.com/neovide/neovide/issues/2689
        spawn "$SV_NEOVIDE_BIN" --wsl -- "\"$fn\""
      done
    fi
  }
  alias vv='nvim -R -'
elif [[ $sv_v_platform = wsl ]]; then
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
elif [[ $svplatform = cygwin ]]; then
  v () {
    if [[ $#* -gt 3 ]]; then
      if [[ $1 == -f ]]; then
        shift
      else
        echo 'specify -f to edit lots of files at once.'
        return 1
      fi
    fi
    if [[ -z $* ]]; then
      cygstart --hide gvim.bat
    else
      for fn in $@; do
        local winfn="`cygpath -wa "$fn"`"
        cygstart --hide gvim.bat "\"$winfn\""
      done
    fi
  }
  alias vv='gvim.bat -R -'
  alias vvv='givm.bat'
elif [[ $sv_v_platform = osx ]]; then
  if [[ -n $SV_VIMR_BIN ]]; then
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
        vimr
      else
        vimr -s $*
      fi
    }
  else
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
  fi
  if [[ -n $SV_NVIM_BIN ]]; then
    alias vv='nvim -R -'
    alias vv='nvim'
  else
    alias vv='mvim -R - > /dev/null'
    alias vvv='mvim -R'
  fi
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
    if [[ $sv_v_platform = X11 ]]; then
      if [[ -z $* ]]; then
        gvim
      else
        for fn in $@; do
          gvim $fn
        done
      fi
    elif [[ $sv_v_platform = screen ]]; then
      if [[ -z $* ]]; then
        screen -t vi vi
      else
        for fn in $@; do
          screen -t "vi $fn" vi $fn
        done
      fi
    else
      vi $@
    fi
  }
  # Check sv_v_platform at invocation time, to support screen reattach.
  vv () {
    if [[ $sv_v_platform = X11 ]]; then
      gvim -R -
    else
      vi -R -
    fi
  }
  vvv () {
    if [[ $sv_v_platform = X11 ]]; then
      gvim
    else
      vi
    fi
  }
fi
