" Nathan's gvimrc file
"
" Maintainer:   Nathan Jent <nathanjent@gmail.com>

set guifont=Monoid:h9

let s:is_win = has('win32') || has('win64')

if s:is_win 
    set renderoptions=type:directx
endif

set guioptions-=T           " Remove toolbar option in gui vim

