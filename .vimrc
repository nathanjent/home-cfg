set expandtab tabstop=4 shiftwidth=4
set number cpoptions+=n


call plug#begin('~/.vim/plugged')

Plug 'racer-rust/vim-racer'
Plug 'vim-scripts/editorconfig-vim'
Plug 'sheerun/vim-polyglot'

call plug#end()

set hidden
let g:racer_cmd = "/home/nathanjent/.cargo/bin/racer"
let $RUST_SRC_PATH="/lib64/rustlib/x86_64-unknown-linux-gnu/lib/"

colorscheme slate
set guifont=Monoid:h9
