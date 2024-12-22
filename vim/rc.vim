set clipboard=unnamed  " System clipboard at the top of the register stack.
set completeopt=  " Less visual noise when tab completing.
set foldlevelstart=1  " Start with one fold expanded.
set ignorecase smartcase  " Ignore case if search string is all lowercase.
set mouse=a  " Mouse in terminal, all modes (including command line).
set mousemodel=extend  " Right mouse button extends selection.
set scrolloff=3  " Always show some context lines when scrolling.
set shiftwidth=4 tabstop=4 expandtab  " Indent 4 cols; never insert tabs.
set showbreak=+  " Visually indicate continued lines.
set showmatch  " Highlight match while searching (like Emacs i-search).
set noshowmode  " Don't need the mode since we have lightline.
set title  " Always try to set the window title.  (Not the nvim default; why?)
set wildmode=longest:list  " Tab complete longest unambiguous and show choices.

let g:netrw_home=$HOME  " Store .netrwhist and .netrwbook in home directory.
let g:netrw_silent=1  " Suppress chatter during file transfers.
let html_no_rendering=1  " Do not want hokey HTML WYSIWYG.

" The following are the defaults in Neovim but not classic Vim.
filetype plugin indent on  " Execute filetype plugins and indent plugins.
set autoindent  " Indent, uh, automatically.
set autoread  " Auto-reload externally changed files if not locally changed.
set backspace=indent  " Backspace through autoindents.
set backspace+=eol  " Backspace through lnebreaks.
set backspace+=start  " Backspace through where we entered Insert mode.
set display=lastline " Editing behavior
set ruler " Always show the ruler.
set timeoutlen=1000  " One-second timeout for key sequences.
set ttimeoutlen=50  " 50 ms for escape codes..
