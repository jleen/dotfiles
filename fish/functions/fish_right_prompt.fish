function fish_right_prompt --description \
    'Saturn Valley Interdimensional Auxiliary Prompt (Aquatic Version)'
  set -l last_pipestatus $pipestatus
  __fish_print_pipestatus " [" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus
  echo -ns ' ' (set_color 224499) (fish_git_prompt '⯇%s⯈') \
      (set_color normal)
end
