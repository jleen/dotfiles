# zshenv sets up environment variables that we want even if this is a
# noninteractive shell, e.g. variables that we'd like to have available in
# processes launched by wrapper scripts.

[[ -x /usr/bin/lesspipe ]] && eval "$(lesspipe)"
export POETRY_VIRTUALENVS_IN_PROJECT=true
export PIPENV_VENV_IN_PROJECT=1
export OPEN_SOURCE_CONTRIBUTOR=true
