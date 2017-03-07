# Based upon https://iterm2.com/misc/zsh_startup.in

if [[ -z $SV_SUPPRESS_ITERM ]]; then
  # TODO(jleen) This logic is pretty bogus.
  [[ ($TERM == xterm) || ($TERM == linux && -z $SSH_TTY && $SVPLATFORM != osx) ]] && export SV_SUPPRESS_ITERM=yes || export SV_SUPPRESS_ITERM=no
fi

alias is_iterm='[[ $SV_SUPPRESS_ITERM != yes ]]'

if [[ -o interactive ]]; then
  screen_dc=
  screen_st=
  [[ $TERM == screen* ]] && screen_dc="\eP" && screen_st="\e\\\\"
  [[ -n $TMUX ]] && screen_dc="\ePtmux;\e" && screen_st="\e\\\\"

  # Indicates start of command output. Runs just before command executes.
  iterm2_before_cmd_executes() {
    is_iterm && printf "$screen_dc\e]133;C;\r\007$screen_st"
  }

  iterm2_set_user_var() {
    is_iterm && printf "$screen_dc\e]1337;SetUserVar=%s=%s\007$screen_st" "$1" $(printf "%s" "$2" | base64)
  }

  # Users can write their own version of this method. It should call
  # iterm2_set_user_var but not produce any other output.
  # e.g., iterm2_set_user_var currentDirectory $PWD
  # Accessible in iTerm2 (in a badge now, elsewhere in the future) as
  # \(user.currentDirectory).
  iterm2_print_user_vars() {
  }

  iterm2_print_state_data() {
    is_iterm && printf "$screen_dc\e]1337;RemoteHost=%s@%s\007$screen_st" "$USER" "$iterm2_hostname"
    is_iterm && printf "$screen_dc\e]1337;CurrentDir=%s\007$screen_st" "$PWD"
    iterm2_print_user_vars
  }

  # Report return code of command; runs after command finishes but before prompt
  iterm2_after_cmd_executes() {
    is_iterm && printf "$screen_dc\e]133;D;$?\007$screen_st"
    iterm2_print_state_data
  }

  # Mark start of prompt
  iterm2_prompt_start() {
    is_iterm && printf "$screen_dc\e]133;A\007$screen_st"
  }

  # Mark end of prompt
  iterm2_prompt_end() {
    is_iterm && printf "$screen_dc\e]133;B\007$screen_st"
  }

  # There are three possible paths in life.
  #
  # 1) A command is entered at the prompt and you press return.
  #    The following steps happen:
  #    * iterm2_preexec is invoked
  #      * PS1 is set to ITERM2_PRECMD_PS1
  #      * ITERM2_PRECMD_PS1 is set to empty string
  #    * The command executes (possibly reading or modifying PS1)
  #    * iterm2_precmd is invoked
  #      * ITERM2_PRECMD_PS1 is set to PS1 (as modified by command execution)
  #      * PS1 gets our escape sequences added to it
  #    * zsh displays your prompt
  #    * You start entering a command
  #
  # 2) You press ^C while entering a command at the prompt.
  #    The following steps happen:
  #    * (iterm2_preexec is NOT invoked)
  #    * iterm2_precmd is invoked
  #      * iterm2_before_cmd_executes is called since we detected that iterm2_preexec was not run
  #      * (ITERM2_PRECMD_PS1 and PS1 are not messed with, since PS1 already has our escape
  #        sequences and ITERM2_PRECMD_PS1 already has PS1's original value)
  #    * zsh displays your prompt
  #    * You start entering a command
  #
  # 3) A new shell is born.
  #    * PS1 has some initial value, either zsh's default or a value set before this script is sourced.
  #    * iterm2_precmd is invoked
  #      * ITERM2_PRECMD_PS1 is set to the initial value of PS1
  #      * PS1 gets our escape sequences added to it
  #    * Your prompt is shown and you may begin entering a command.
  #
  # Invariants:
  # * ITERM2_PRECMD_PS1 is empty during and just after command execution
  # * PS1 does not have our escape sequences during command execution
  # * After the command executes but before a new one begins, PS1 has escape sequences and
  #   ITERM2_PRECMD_PS1 has PS1's original value.
  iterm2_decorate_prompt() {
    # This should be a raw PS1 without iTerm2's stuff. It could be changed during command
    # execution.
    ITERM2_PRECMD_PS1="$PS1"

    # Add our escape sequences just before the prompt is shown.
    is_iterm && PS1="%{$(iterm2_prompt_start)%}$PS1%{$(iterm2_prompt_end)%}"
  }

  iterm2_precmd() {
    if [ -n "$ITERM2_PRECMD_PS1" ]; then
      # You pressed ^C while entering a command (iterm2_preexec did not run)
      is_iterm && iterm2_before_cmd_executes
    fi

    is_iterm && iterm2_after_cmd_executes

    if [ -z "$ITERM2_PRECMD_PS1" ]; then
      iterm2_decorate_prompt
    fi
  }

  # This is not run if you press ^C while entering a command.
  iterm2_preexec() {
    # Set PS1 back to its raw value prior to executing the command.
    PS1="$ITERM2_PRECMD_PS1"
    ITERM2_PRECMD_PS1=""
    is_iterm && iterm2_before_cmd_executes
  }

  # If hostname -f is slow on your system, set iterm2_hostname prior to sourcing this script.
  if [[ -z "$iterm2_hostname" ]]; then
    if [[ `uname -v` == *PREEMPT* ]]; then
      iterm2_hostname=`hostname `
    else
      iterm2_hostname=`hostname -f`
    fi
  fi

  [[ -z $precmd_functions ]] && precmd_functions=()
  precmd_functions=($precmd_functions iterm2_precmd)

  [[ -z $preexec_functions ]] && preexec_functions=()
  preexec_functions=($preexec_functions iterm2_preexec)

  is_iterm && iterm2_print_state_data
  is_iterm && printf "$screen_dc\e]1337;ShellIntegrationVersion=1\007$screen_st"
fi
