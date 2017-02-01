colorscheme elflord
syn on

set expandtab tabstop=4 shiftwidth=4
set number cpoptions+=n
set ruler
set wrapmargin=1

call plug#begin('~/.vim/plugged')

Plug 'racer-rust/vim-racer'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/editorconfig-vim'

call plug#end()

set hidden
let g:EditorConfig_exec_path = '$HOME/.vim/plugged/editorconfig-vim/plugin/editor-core-py/main.py'
let g:racer_cmd = "/home/nathanjent/.cargo/bin/racer"

