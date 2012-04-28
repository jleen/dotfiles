Saturn Valley Dotfiles of Doom
==============================

Contains jleen's lovingly hand-wrangled battle-scarred Unix config that has
been evolving for over a decade of fun-filled whimsy.

Installation
------------

Copy templates/.zshenv to your home directory and edit as needed.

You don't need to source zsh/zshrc from your .zshrc because zsh/zshenv
already does it if it's running in an interactive shell.  Similarly you don't
need to source vim/startup.vim from your .vimrc because zsh/zshenv sets your
VIMINIT to run vim/startup.vim (which in turn sources your .vimrc).
