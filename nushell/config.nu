$env.config.show_banner = false
$env.config.buffer_editor = 'nvim'


###
### Prompt
###

if (which starship | is-not-empty) {
  $env.STARSHIP_SHELL = "nu"
  $env.STARSHIP_CONFIG = $nu.home-dir + "/sv/starship/starship.toml"

  def create_left_prompt [] {
      starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
  }

  $env.PROMPT_COMMAND = { || create_left_prompt }
  $env.PROMPT_COMMAND_RIGHT = ""

} else {

  # Fallback if starship is not installed.

  $env.PROMPT_COMMAND = {||
    # Distinguished symbol for root shell
    let starboat = if (is-admin) { "#" } else { "❯" }

    # GNU Screen identification
    let screen = if ($env.WINDOW? != null) {
      $" ($env.WINDOW)"
    } else {
      ""
    }

    # SSH detection and hostname
    let ssh = if ($env.SSH_CONNECTION? != null) {
      $"(ansi green_bold)(sys host | get hostname)(ansi reset) "
    } else {
      ""
    }

    let xssh = if ($env.SSH_CONNECTION? != null) {
      $"(sys host | get hostname) "
    } else {
      ""
    }

    # Window title for compatible terminals
    let term = $env.TERM? | default ""
    let title = if (($term | str contains 'xterm') or
                    ($term | str contains 'rxvt') or
                    ($term == 'screen')) {
      $"\e]0;($xssh)($screen)\a"
    } else {
      ""
    }

    # Get current directory
    let dir = $"(ansi cyan_bold)($env.PWD)(ansi reset)"

    # Get prompt extra if it exists
    let prompt_extra = $env.SV_PROMPT_EXTRA? | default ""

    # Assemble the prompt
    $"($title)\n($ssh)($dir)($screen)($prompt_extra)\n(ansi cyan_bold)▶(ansi blue_bold)($starboat)(ansi reset) "
  }
}

$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "


###
### Editor
###

def v [...files] {
  if ($files | is-empty) {
    job spawn { neovide } | ignore
  } else {
    for file in $files {
      job spawn { neovide $file }
    }
  }
}
