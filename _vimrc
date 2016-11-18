colorscheme elflord
syn on
set guifont=Monoid:h9
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
set number cpoptions+=n
set ruler

call plug#begin('$HOME/vimfiles/plugged')

Plug 'racer-rust/vim-racer'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/editorconfig-vim'

call plug#end()

set hidden
let g:racer_cmd = "C:/Users/njent/.cargo/bin/racer"
let $RUST_SRC_PATH="C:/git/rust/src/"
let g:EditorConfig_exec_path = '$HOME/vimfiles/plugged/editorconfig-vim/plugin/editor-core-py/main.py'
