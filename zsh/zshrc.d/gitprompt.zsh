typeset -ga precmd_functions
typeset -ga chpwd_functions
typeset -ga preexec_functions
typeset -ga sv_special_prompt_specs

function set_git_prompt {
  gitref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $gitref ]] ; then
    gitbranch="[${gitref#refs/heads/}]"
  else
    gitbranch=""
  fi
  RPROMPT="${gitbranch}"
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

function sv_set_special_prompt {
  unset SV_SPECIAL_PROMPT
  unset SV_PWD_PROMPT

  for prompt_spec in $sv_special_prompt_specs; do
    local prompt_trigger=`echo $prompt_spec|cut -d: -f1`
    local prompt_name=`echo $prompt_spec|cut -d: -f2`
    if [[ $PWD == $prompt_trigger* ]]; then
      SV_SPECIAL_PROMPT="%{`tput bold`%}$prompt_name%{`tput sgr0`%}:"
      SV_SPECIAL_WINDOW_PROMPT="$prompt_name:"
      SV_PWD_PROMPT=`echo $PWD | cut -c$((${#prompt_trigger}+2))-`
      SV_PWD_PROMPT=${SV_PWD_PROMPT:=.}
    fi
  done
}

function sv_set_prompt_precmd {
  if [[ -n "$SV_PROMPT_UPDATE" ]] ; then
    sv_set_special_prompt
    SV_PROMPT_UPDATE=
  fi
}
precmd_functions+='sv_set_prompt_precmd'

function sv_set_prompt_chpwd {
  SV_PROMPT_UPDATE=1
}
chpwd_functions+='sv_set_prompt_chpwd'

SV_PROMPT_UPDATE=1
 
