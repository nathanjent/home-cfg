" Nathan's gvimrc file
"
" Maintainer:   Nathan Jent <nathanjent@gmail.com>

colorscheme industry

let s:is_win = has('win32') || has('win64')

if s:is_win 
    set guifont=Monoid:h9,Consolas:h11
    set renderoptions=type:directx
else
    set guifont=Monospace\ 10
endif

set guioptions-=T           " Remove toolbar option in gui vim

