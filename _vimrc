if has('nvim')
    " neovim specific settings
    call plug#begin('$LOCALAPPDATA/vimfiles/plugged')
        "Plug 'vim-scripts/editorconfig-vim'
        "Plug 'dylon/vim-antlr'
        Plug 'sheerun/vim-polyglot'
    call plug#end()
    set g:python3_host_prog=$PYTHON3\python.exe
else
    " vim specific settings

    " Put all temporary files under the same directory.
    " https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
    set backup
    set backupdir   =$HOME/vimfiles/backup/
    set backupext   =-vimbackup
    set backupskip  =
    "set directory   =$HOME/vimfiles/swap/
    set updatecount =100
    "set undofile
    "set undodir     =$HOME/vimfiles/undo/
    set viminfo ='100,n$HOME/vimfiles/info/viminfo

    call plug#begin('$HOME/vimfiles/plugged')
        "Plug 'racer-rust/vim-racer'
        Plug 'sheerun/vim-polyglot'
        Plug 'vim-scripts/editorconfig-vim'
        Plug 'craigemery/vim-autotag'
        Plug 'dylon/vim-antlr'
        Plug 'majutsushi/tagbar'
        Plug 'vim-pandoc/vim-pandoc-syntax'
        Plug 'scrooloose/nerdtree'
        Plug 'OrangeT/vim-csharp'
        "Plug 'vim-syntastic/syntastic'
        Plug 'ctrlpvim/ctrlp.vim'

        " Language server client
        "Plug 'natebosch/vim-lsc'
        
        " Requires Vim compiled with python
        "Plug 'OmniSharp/omnisharp-vim'
        
        " YouCompleteMe not windows compatible
        "Plug 'Valloric/YouCompleteMe'
    call plug#end()

    " Editor Config
    let g:EditorConfig_exec_path = 'U:/vimfiles/plugged/editorconfig-vim/plugin/editor-core-py/main.py'

    " Add status when working with Eclim projects
    set statusline+=%<%f\ %M\ %h%r%=%-10.(%l,%c%V\ %{eclim#project#util#ProjectStatusLine()}%)\ %P
    let g:EclimProjectStatusLine = 'eclim(p=${name}, n=${natures})'
    let g:EclimHtmlValidate = 0 " Disabled because of issues with markdown files
    "let g:EclimFileTypeValidate = 0 " Disable Eclim validation when using syntastic

    " CtrlP settings
    let g:ctrlp_match_window = 'bottom,order:ttb'
    let g:ctrlp_switch_buffer = 0
    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_user_command = 'rg %s -l --hidden -g ""'
endif

set nocompatible            " Explicitly set not vi compatible mode.
set guioptions-=T           " Remove toolbar option in gui vim

filetype plugin indent on   " Load plugins & indent according to detected filetype.
syntax on                   " Enable syntax highlighting.

set autoindent              " Indent according to previous line.
set expandtab               " Use spaces instead of tabs.
set tabstop     =4          " Spaces per tab
set softtabstop =4          " Tab key indents by 4 spaces.
set shiftwidth  =4          " >> indents by 4 spaces.
set shiftround              " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                  " Switch between buffers without having to save first.
set showmatch               " Highlight matching [{()}]
"CAUSES SLOWNESS IN WINDOWS CONSOLE"set laststatus  =2         " Always show statusline.
set display     =lastline   " Show as much as possible of the last line.

set showmode                " Show current mode in command-line.
set showcmd                 " Show already typed keys when more are expected.

set incsearch               " Highlight while searching with / or ?.
set hlsearch                " Keep matches highlighted.

" Remove highlighted searches
nnoremap <leader><space> :nohlsearch<CR>

set ttyfast                 " Faster redrawing.
set lazyredraw              " Only redraw when necessary.

set splitbelow              " Open new windows below the current window.
set splitright              " Open new windows right of the current window.

"set cursorline             " Highlight the current line
set wrapscan                " Searches wrap around end-of-file.
set report      =0          " Always report changed lines.
set synmaxcol   =200        " Only highlight the first 200 columns.

set list                    " Show non-printable characters.

set number                  " Include the line number column
set cpoptions+=n            " Wrapped lines use line number column example ------------------------------------------------------------------------------------------------------------------------------
set wildmenu                " Lists autocomplete items above command input

set foldenable              " Enable folding
set foldlevelstart=5        " Open folds to this level for new buffer
set foldnestmax=10          " 10 nested fold max

if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:? ,extends:?,precedes:?,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

colorscheme industry
set guifont=Monoid:h9
set ruler
set wrapmargin=1


" Syntastic recommended settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" Language Server Client
let g:lsc_server_commands = { 'rust' : 'rls', 'java' : 'eclimd' }
nnoremap gd :LSClientGoToDefinition<CR>
nnoremap gr :LSClientFindReferences<CR>

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    au! BufNewFile,BufFilePre,BufRead *.markdown set filetype=markdown.pandoc
augroup END

let g:autotagExcludeSuffixes    = "orig.swp"     " suffixes to not ctags on

" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction

" Format JSON
command! JSONFormat call JSONFormatter()
function! JSONFormatter()
    %!python -m json.tool
endfunction
