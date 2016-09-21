syn on
colorscheme elflord
set guifont=Monoid:h9
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
set number cpoptions+=n

call plug#begin('$HOME/vimfiles/plugged')


Plug 'racer-rust/vim-racer'
Plug 'sheerun/vim-polyglot'

call plug#end()

set hidden
let g:racer_cmd = "C:/Users/njent/.cargo/bin/racer"
let $RUST_SRC_PATH="C:/git/rust/src/"

