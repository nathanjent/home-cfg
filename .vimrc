set expandtab tabstop=4 shiftwidth=4


call plug#begin('~/.vim/plugged')

Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'

call plug#end()

set hidden
let g:racer_cmd = "/home/nathanjent/.cargo/bin/racer"
let $RUST_SRC_PATH="/home/nathanjent/git/rust/src/"

colorscheme slate

