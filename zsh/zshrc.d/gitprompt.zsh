if [[ ! -x "$SV_STARSHIP_BIN" ]]; then

    typeset -ga precmd_functions
    typeset -ga chpwd_functions
    typeset -ga preexec_functions

    function set_git_prompt {
      local gitcolorstart gitcolorend
      if [[ -n $SV_PROMPT_COLOR_GIT ]]; then
        gitcolorstart=$'%{\e[38;5;${SV_PROMPT_COLOR_GIT}m%}'
        gitcolorend=$'%{\e(B\e[m%}'
      fi
      local open="$gitcolorstart${SV_PROMPT_GIT_L:-[}"
      local close="${SV_PROMPT_GIT_R:-]}$gitcolorend"
      local gitref=$(git symbolic-ref HEAD 2> /dev/null)
      if [[ -n $gitref ]] ; then
        #RPROMPT="$open${gitref#refs/heads/}$close"
        SV_PROMPT_EXTRA=" %F{yellow}${gitref#refs/heads/}%f"
      else
        #RPROMPT=""
        unset SV_PROMPT_EXTRA
      fi
    }

    function zsh_git_prompt_precmd {
      if [[ -n "$PR_GIT_UPDATE" ]] ; then
        set_git_prompt
        PR_GIT_UPDATE=
      fi
    }
    precmd_functions+='zsh_git_prompt_precmd'

    function zsh_git_prompt_chpwd {
      PR_GIT_UPDATE=1
    }
    chpwd_functions+='zsh_git_prompt_chpwd'

    function zsh_git_prompt_preexec {
      case "$(history $HISTCMD)" in 
      *git*)
        PR_GIT_UPDATE=1
        ;;
      esac
    }
    preexec_functions+='zsh_git_prompt_preexec'

    PR_GIT_UPDATE=1
fi
