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
    Plug 'sheerun/vim-polyglot' " Syntax support for many languages
    Plug 'vim-scripts/editorconfig-vim'
    Plug 'craigemery/vim-autotag' " Autogenerate tags
    Plug 'dylon/vim-antlr' " Syntax support for Antlr
    Plug 'majutsushi/tagbar' " Show functions and fields from live generated tags
    Plug 'vim-pandoc/vim-pandoc-syntax' " Syntax support for markdown, has some extra features
    Plug 'scrooloose/nerdtree' " Browse files in vim
    Plug 'OrangeT/vim-csharp' " Syntax support for C#
    Plug 'ctrlpvim/ctrlp.vim' " File search
    Plug 'tpope/vim-dispatch' " Async script running
    Plug 'vim-syntastic/syntastic' " Syntax helper
    "Plug 'racer-rust/vim-racer'
    Plug 'Shougo/neocomplete.vim' " Autocomplete

    Plug 'SirVer/ultisnips' " Insert snippets of code

    " Language server client
    Plug 'natebosch/vim-lsc'
    
    " Requires Vim compiled with python
    Plug 'OmniSharp/omnisharp-vim' " C# language server

    " YouCompleteMe not windows compatible
    "Plug 'Valloric/YouCompleteMe' " Multiprotocol language server
call plug#end()

" OmniSharp settings
let g:OmniSharp_server_type = 'roslyn'
let g:OmniSharp_selector_ui = 'ctrlp'   " Use ctrlp.vim
let g:OmniSharp_timeout = 1             " Timeout in seconds to wait for a response from the server
set noshowmatch                         " Showmatch significantly slows down omnicomplete when the first match contains parentheses.
set completeopt=longest,menuone,preview
set splitbelow
augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END

set updatetime=500 " this setting controls how long to wait (in ms) before fetching type / symbol information.
set cmdheight=2 " Remove 'Press Enter to continue' message when type information is longer than one line.

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

" Enable snippet completion, requires completeopt-=preview
let g:OmniSharp_want_snippet=1

" UltiSnips settings
let g:UltiSnipsExpandTrigger="<tab>" " Incompatible with YouCompleteMe
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
let g:syntastic_cs_checkers = ['code_checker'] " omnisharp-roslyn support


" Editor Config
let g:EditorConfig_exec_path = 'U:/vimfiles/plugged/editorconfig-vim/plugin/editor-core-py/main.py'


" Eclim settings
nnoremap <c-j><c-j> :JavaCorrect<cr>
nnoremap <c-j><c-h> :JavaCallHierarchy<cr>
nnoremap <c-j><c-f> ggVG:JavaFormat<cr>
nnoremap <c-j><c-i> :JavaImpl<cr>
nnoremap <c-j><c-d> :JavaDocPreview<cr>
" JavaRename requires input
nnoremap <c-j><c-r> :JavaRename 

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


" Language Server Client settings
let g:lsc_server_commands = {
    \ 'rust' : 'rls_logger.bat',
    \ 'java' : 'eclimd'
    \}
nnoremap gd :LSClientGoToDefinition<CR>
nnoremap gr :LSClientFindReferences<CR>

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

