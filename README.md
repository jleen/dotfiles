# Saturn Valley Dotfiles of Destiny

Contains jleen's lovingly hand-wrangled battle-scarred Unix config that has
been evolving for over two decades of fun-filled whimsy.

## Installation

You’ll probably want to `git clone --recursive-submodules` to get the Vim plugins.
(Or just `git submodule update --init` after cloning.)

Source `zsh/startup.zsh` from your zshenv.  Pass it a prompt title and prompt
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
* `apt install bat eza fzf git-delta ripgrep zoxide zsh zsh-autosuggestions zsh-syntax-highlighting`

Or, on Mac OS, just

* `brew install nvim neovide-app bat eza fd fzf delta ripgrep zoxide zsh-autosuggestions zsh-syntax-highlighting`

In either case, you’ll want to

* `bat cache --build --source /home/jleen/sv/bat`

## Theming

You might want to configure Vim fonts in `local/pre.vim`, e.g.
```
let g:sv_font="Garply_Sans:h12"
let g:big_font="Garply_Sans:h18"
```

## Windows Support

A lot of this stuff sort of works on Windows.
`nushell` is my preferred shell there, and its config bootstrap is `config.nu` in
`$nu.default-config-dir`, which is typically `%AppData%\nushell`.

The preferred Vim is NeoVim via Neovide, and the config bootstrap is
`%LocalAppData%\nvim\init.vim`.

You can get these dependencies from e.g.

* `scoop install neovim neovide nushell`

## Vendored Catppuccin

Catppuccin is the flavor of the day! This repo contains vendored code from the following repos:

* https://github.com/catppuccin/bat @ `6810349`
* https://github.com/catppuccin/delta @ `313b3ac`
* https://github.com/eza-community/eza-themes @ `5714985`
* https://github.com/catppuccin/zsh-syntax-highlighting @ `7926c3d`