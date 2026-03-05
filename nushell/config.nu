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

$env.config.menus ++= [{
    name: completion_menu
    only_buffer_difference: false # Search is done on the text written after activating the menu
    marker: "◿ "                  # Indicator that appears with the menu is active
    type: {
        layout: columnar          # Type of menu
        columns: 4                # Number of columns where the options are displayed
        col_width: 20             # Optional value. If missing all the screen width is used to calculate column width
        col_padding: 2            # Padding between columns
    }
    style: {
        text: green                   # Text style
        selected_text: green_reverse  # Text style for selected option
        description_text: yellow      # Text style for description
    }
}, {
    name: history_menu
    only_buffer_difference: true # Search is done on the text written after activating the menu
    marker: "⍋ "                 # Indicator that appears with the menu is active
    type: {
        layout: list             # Type of menu
        page_size: 10            # Number of entries that will presented when activating the menu
    }
    style: {
        text: green                   # Text style
        selected_text: green_reverse  # Text style for selected option
        description_text: yellow      # Text style for description
    }
}]

$env.config.table.mode = 'light'
$env.config.datetime_format.table = '%v %l:%M %P'

###
### Editor
###

def v [...files] {
  let nv = $env.SV_NEOVIDE_BIN? | default neovide
  let wsl = (uname).kernel-release | str contains WSL | if $in { ['--wsl' '--'] } else { [] }
  if ($files | is-empty) {
    job spawn { ^$nv ...$wsl } | ignore
  } else {
    for file in $files {
      job spawn { ^$nv ...$wsl $file }
    }
  }
}
