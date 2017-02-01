colorscheme elflord
syn on
set guifont=Monoid:h9
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
set number cpoptions+=n
set ruler
set wrapmargin=1

call plug#begin('$HOME/vimfiles/plugged')

Plug 'racer-rust/vim-racer'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/editorconfig-vim'
Plug 'craigemery/vim-autotag'

call plug#end()

set hidden
let g:EditorConfig_exec_path = '$HOME/vimfiles/plugged/editorconfig-vim/plugin/editor-core-py/main.py'
let g:racer_cmd = "C:/Users/njent/.cargo/bin/racer"
let $RUST_SRC_PATH="C:/git/rust/src/"

set statusline=%<%f\ %M\ %h%r%=%-10.(%l,%c%V\ %{eclim#project#util#ProjectStatusLine()}%)\ %P
let g:EclimProjectStatusLine = 'eclim(p=${name}, n=${natures})'
