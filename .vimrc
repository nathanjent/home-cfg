colorscheme elflord


set expandtab tabstop=4 shiftwidth=4
set number cpoptions+=n

call plug#begin('~/.vim/plugged')

Plug 'racer-rust/vim-racer'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/editorconfig-vim'
Plug 'peter-edge/vim-capnp'

call plug#end()

set hidden
let g:racer_cmd = "/home/nathanjent/.cargo/bin/racer"

