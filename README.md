# Saturn Valley Dotfiles of Destiny

Contains jleen's lovingly hand-wrangled battle-scarred Unix config that has
been evolving for over two decades of fun-filled whimsy.

## Installation

Source zsh/startup.zsh from your zshenv.  Pass it a prompt title and prompt
color as arguments.

You don't need to do anything in
zshrc, vimrc, &c because we configure everything to look for your rc files
in the right place.  You can put your own stuff in a subdirectory called
"local" (which is gitignored).

You’ll need to manually update your .gitconfig. We could rewire it with GIT_CONFIG_GLOBAL,
but too many tools automatically edit your gitconfig. You want something like:
```
[include]
    path = "~/sv/git/gitconfig"
```

## Optional Dependencies

The following will be autoconfigured if present.

* neovim (ideally the latest AppImage from GitHub)
* starship (again from GitHub)
* `apt install zsh eza git-delta fzf ripgrep bat`
* `bat cache --build --source /home/jleen/sv/bat`

## Theming

You might want to configure Vim fonts in `local/pre.vim`, e.g.
```
let g:sv_font="Garply_Sans:h12"
let g:big_font="Garply_Sans:h18"
```
