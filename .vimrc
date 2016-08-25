set expandtab tabstop=4 shiftwidth=4
set number cpoptions+=n


call plug#begin('~/.vim/plugged')

Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
Plug 'vim-scripts/editorconfig-vim'

call plug#end()

set hidden
let g:racer_cmd = "/home/nathanjent/.cargo/bin/racer"
let $RUST_SRC_PATH="/home/nathanjent/git/rust/src/"

colorscheme slate

