call plug#begin('~/.vim/plugged')
    Plug 'sheerun/vim-polyglot' " Syntax support for many languages
    Plug 'vim-scripts/editorconfig-vim'
    Plug 'majutsushi/tagbar' " Show functions and fields from live generated tags
    Plug 'vim-pandoc/vim-pandoc-syntax' " Syntax support for markdown, has some extra features
    Plug 'scrooloose/nerdtree' " Browse files in vim
    Plug 'peter-edge/vim-capnp'

    " Language Server Protocol client
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'

    Plug 'Valloric/YouCompleteMe' " Multiprotocol language server
call plug#end()

" Editor Config
let g:EditorConfig_exec_path = '$HOME/.vim/plugged/editorconfig-vim/plugin/editor-core-py/main.py'
" Eclim settings
let g:EclimCompletionMethod = 'omnifunc'
nnoremap <c-j><c-j> :JavaCorrect<cr>
nnoremap <c-j><c-h> :JavaCallHierarchy<cr>
nnoremap <c-j><c-f> ggVG:JavaFormat<cr>
nnoremap <c-j><c-i> :JavaImpl<cr>
nnoremap <c-j><c-d> :JavaDocPreview<cr>
nnoremap <c-j><c-s> :JavaSearchContext<cr>
" JavaRename requires input
nnoremap <c-j><c-r> :JavaRename 

" Add status when working with Eclim projects
set statusline+=%<%f\ %M\ %h%r%=%-10.(%l,%c%V\ %{eclim#project#util#ProjectStatusLine()}%)\ %P
let g:EclimProjectStatusLine = 'eclim(p=${name}, n=${natures})'
let g:EclimHtmlValidate = 0 " Disabled because of issues with markdown files
"let g:EclimFileTypeValidate = 0 " Disable Eclim validation when using syntastic

" Language Server Client settings
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

let g:lsp_async_completion = 1
autocmd FileType rust setlocal omnifunc=lsp#complete

" Pandoc syntax settings
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    au! BufNewFile,BufFilePre,BufRead *.markdown set filetype=markdown.pandoc
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
"CAUSES SLOWNESS IN WINDOWS CONSOLE"set laststatus  =2         " Always show statusline.
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
set cpoptions+=n            " Wrapped lines use line number column example ------------------------------------------------------------------------------------------------------------------------------
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

set ruler                   "Show the line and column number of the cursor position
"set wrapmargin=1            "Number of characters from the right where wrapping starts

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
