let s:is_win = has('win32')

if s:is_win
    let $VIMFILES = expand('$HOME\vimfiles')
else
    let $VIMFILES = expand('$HOME/.vim')
endif

let s:vim_plug_file = $VIMFILES . '/autoload/plug.vim'
if !filereadable(s:vim_plug_file)
    execute '!curl -fLo ' . s:vim_plug_file . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echo 'Vim-Plug installed. Restarting Vim to load it.'
    exit
endif

"Vim-Plug plugin management
call plug#begin(expand('$VIMFILES/plugged'))
    Plug 'sheerun/vim-polyglot' " Syntax support for many languages
    Plug 'vim-scripts/editorconfig-vim'
"    Plug 'craigemery/vim-autotag' " Autogenerate tags
    Plug 'majutsushi/tagbar' " Show functions and fields from live generated tags
    Plug 'vim-pandoc/vim-pandoc-syntax' " Syntax support for markdown, has some extra features

    Plug 'scrooloose/nerdtree' " Browse files in vim
    Plug 'Xuyuanp/nerdtree-git-plugin' " See GIT symbols in Nerdtree

    Plug 'OrangeT/vim-csharp' " Syntax support for C# things
"    Plug 'vim-syntastic/syntastic' " Syntax helper
    Plug 'Shougo/neocomplete.vim' " Autocomplete
    
    " Insert snippets of code
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    Plug 'tpope/vim-dispatch' " Async script running
    Plug 'kien/ctrlp.vim' " File search

    Plug 'Valloric/YouCompleteMe' " Polyglot code-completion engine

    Plug 'w0rp/ale' " Asynchronous Linting Engine

    if s:is_win
        Plug 'dylon/vim-antlr' " Syntax support for Antlr
        Plug 'vim-scripts/Windows-PowerShell-Syntax-Plugin' " Syntax support for Powershell
    else
        Plug 'peter-edge/vim-capnp'
    endif
call plug#end()

" ALE settings
let g:ale_linters = {
            \'rust': ['rls']
            \}
let g:ale_fixers = {
            \'rust': ['rustfmt']
            \}

" Editor Config
let g:EditorConfig_exec_path = $VIMFILES . '/plugged/editorconfig-vim/plugin/editor-core-py/main.py'

" YouCompleteMe settings
nnoremap <leader>y :YcmDiags<cr>
nnoremap <leader>yf :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>f :YcmCompleter FixIt<cr>
nnoremap <leader>g :YcmCompleter GoTo<cr>
nnoremap <leader>fm :YcmCompleter Format<cr>
nnoremap <leader>gr :YcmCompleter GoToReferences<cr>
nnoremap <leader>d :YcmCompleter GetDoc<cr>
nnoremap <leader>t :YcmCompleter GetType<cr>
nnoremap <leader>i :YcmCompleter OrganizeImports<cr>
" Rename requires input
nnoremap <leader>r :YcmCompleter RefactorRename 

" YouCompleteMe requires UTF-8
set encoding=utf-8

" UltiSnips settings
" let g:UltiSnipsExpandTrigger='<tab>' " Incompatible with YouCompleteMe
" let g:UltiSnipsJumpForwardTrigger='<c-b>'
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" NERDtree settings
if s:is_win
    let g:NERDTreeIndicatorMapCustom = {
        \ "Modified"  : "Mod",
        \ "Staged"    : "Stg",
        \ "Untracked" : "Untk",
        \ "Renamed"   : "Ren",
        \ "Unmerged"  : "Umrg",
        \ "Deleted"   : "Del",
        \ "Dirty"     : "Drt",
        \ "Clean"     : "Cln",
        \ 'Ignored'   : 'Ign',
        \ "Unknown"   : "Unk"
        \ }
endif

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'rg %s -l --hidden -g ""'

" Pandoc syntax settings
augroup pandoc_syntax
    au!
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    au BufNewFile,BufFilePre,BufRead *.markdown set filetype=markdown.pandoc
augroup END

" AutoTag settings
let g:autotagExcludeSuffixes    = "orig.swp"     " suffixes to not ctags on

" other settings
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
if !s:is_win
    set laststatus  =2          " Always show statusline.
endif
set display     =lastline   " Show as much as possible of the last line.

set showmode                " Show current mode in command-line.
set showcmd                 " Show already typed keys when more are expected.

set incsearch               " Highlight while searching with / or ?.
set hlsearch                " Keep matches highlighted.

set ttyfast                 " Faster redrawing.
set lazyredraw              " Only redraw when necessary.

set splitbelow              " Open new windows below the current window.
set splitright              " Open new windows right of the current window.

"set cursorline              " Highlight the current line
set wrapscan                " Searches wrap around end-of-file.
set report      =0          " Always report changed lines.
set synmaxcol   =200        " Only highlight the first 200 columns.

set list                    " Show non-printable characters.

set number                  " Include the line number column
set cpoptions+=n            " Wrapped lines use line number column; example->--------------------------------------------------------------------------------------------------------------------------->
set wildmenu                " Lists autocomplete items above command input

set foldenable              " Enable folding
set foldlevelstart=5        " Open folds to this level for new buffer
set foldnestmax=10          " 10 nested fold max

set noshowmatch             " Showmatch significantly slows down omnicomplete when the first match contains parentheses.
set completeopt=longest,menuone,preview
set splitbelow              " New split window below current

if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:? ,extends:?,precedes:?,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

colorscheme industry
set guifont=Monoid:h9
set ruler                   "Show the line and column number of the cursor position
if s:is_win
    set wrapmargin=1        "Number of characters from the right where wrapping starts
endif

" ------- Custom Commands ------------
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

" Highlight repeated lines
command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
function! HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction
