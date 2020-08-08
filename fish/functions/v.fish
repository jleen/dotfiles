if [ "$SVLINUX" = 'wsl' ]
  function v --description \
      'Saturn Valley Pandimensional Unifor Editor Launcher (WSL Flavor)'
    if [ (count $argv) -gt 3 ]
      if [ $argv[1] = '-f' ]
        set --erase argv[1]
      else
        echo 'Specify -f to edit lots of files at once.'
        return 1
      end
    end
    if [ (count $argv) = 0 ]
      spawn gvim.exe
    else
      for fn in $argv
        spawn gvim.exe "$fn"
      end
    end
  end
  alias vv='spawn gvim.exe -R -'
else if [ "$svplatform" = 'cygwin' ]
  function v --description \
      'Saturn Valley Pandimensional Unifor Editor Launcher (Cygwin Flavor)'
    if [ (count $argv) -gt 3 ]
      if [ $argv[1] = -f ]
        set --erase argv[1]
      else
        echo 'specify -f to edit lots of files at once.'
        return 1
      end
    end
    if [ (count $argv) = 0 ]
      cygstart --hide gvim.bat
    else
      for fn in $argv
        set --local winfn "`cygpath -wa "$fn"`"
        cygstart --hide gvim.bat "\"$winfn\""
      end
    end
  end
  alias vv='gvim.bat -R -'
else if [ "$SVPLATFORM" = osx ]
  set --local macvim_dir /Applications/MacVim.app/Contents/bin
  [ -d $macvim_dir ]; and path+=$macvim_dir

  function v --description \
      'Saturn Valley Pandimensional Unifor Editor Launcher (MacOS Flavor)'
    if [ (count $argv) -gt 3 ]
      if [ $argv[1] = '-f' ]
        set --erase argv[1]
      else
        echo 'Specify -f to edit lots of files at once.'
        return 1
      end
    end
    if [ (count $argv) = 0 ]
      mvim
    else
      local groggy sleeping
      pgrep -qx MacVim; or set groggy 1
      for fn in $argv
        [ -n $sleeping ]; and sleep 0.3; and set --erase sleeping
        mvim $fn
        [ -n $groggy ]; and set sleeping 1; and set --erase groggy
      end
    end
  end
  alias vv='mvim -R - > /dev/null'
else
  function v --description \
      'Saturn Valley Pandimensional Unifor Editor Launcher (POSIX Flavor)'
    if [ (count $argv) -gt 3 ]
      if [[ $argv[1] = '-f' ]
        shift
      else
        echo 'Specify -f to edit lots of files at once.'
        return 1
      end
    end
    if [ $SVPLATFORM = X11 ]
      if [ (count $arv) = 0 ]
        gvim
      else
        for fn in $argv
          gvim $fn
        end
      end
    else if [ $SVPLATFORM = screen ]
      if [ count $argv = 0 ]
        screen -t vi vi
      else
        for fn in $argv
          screen -t "vi $fn" vi $fn
        end
      end
    else
      vi $argv
    end
  end
  function vv
    if [ $SVPLATFORM = X11 ]
      gvim -R -
    else
      vi -R -
    end
  end
end
