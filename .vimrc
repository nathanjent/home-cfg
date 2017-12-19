colorscheme industry

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
"CAUSES SLOWNESS IN WINDOWS CONSOLE"set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

"set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:? ,extends:?,precedes:?,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

set number cpoptions+=n
set ruler                  "Show the line and column number of the cursor position
"set wrapmargin=1          "Number of characters from the right where wrapping starts

call plug#begin('~/.vim/plugged')

"Plug 'racer-rust/vim-racer'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/editorconfig-vim'
Plug 'peter-edge/vim-capnp'
Plug 'majutsushi/tagbar'
"Plug 'natebosch/vim-lsc'
Plug 'Valloric/YouCompleteMe'

call plug#end()

let g:lsc_server_commands = {'dart': 'dart_language_server'}

nnoremap gd :LSClientGoToDefinition<CR>
nnoremap gr :LSClientFindReferences<CR>

set hidden
let g:EditorConfig_exec_path = '$HOME/.vim/plugged/editorconfig-vim/plugin/editor-core-py/main.py'

" Racer settings
let g:racer_cmd = "/home/nathanjent/.cargo/bin/racer"
let g:racer_experimental_completer = 1

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

if has('nvim')
    set rtp^=~/.vim/
else
endif
