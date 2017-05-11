set nocompatible           " Explicitly set not vi compatible mode.

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

""old"set tabstop=4 softtabstop=0 shiftwidth=2 smarttab
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


" Put all temporary files under the same directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
set backup
set backupdir   =$HOME/vimfiles/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/vimfiles/swap//
set updatecount =100
"set undofile
"set undodir     =$HOME/vimfiles/undo/
set viminfo ='100,n$HOME/vimfiles/info/viminfo

colorscheme elflord
set guifont=Monoid:h9
set number cpoptions+=n
set ruler
set wrapmargin=1

call plug#begin('$HOME/vimfiles/plugged')

Plug 'racer-rust/vim-racer'
Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/editorconfig-vim'
Plug 'craigemery/vim-autotag'

call plug#end()

let g:EditorConfig_exec_path = '$HOME/vimfiles/plugged/editorconfig-vim/plugin/editor-core-py/main.py'
let g:racer_cmd = "C:/Users/njent/.cargo/bin/racer"

set statusline=%<%f\ %M\ %h%r%=%-10.(%l,%c%V\ %{eclim#project#util#ProjectStatusLine()}%)\ %P
let g:EclimProjectStatusLine = 'eclim(p=${name}, n=${natures})'
